import 'dart:async';
import 'dart:math';
import 'package:connectivity_plus/connectivity_plus.dart';

import '../data/repository/task_repository.dart';
import '../models/enums.dart';

class SyncService {
  final TaskRepository _repository;
  final Connectivity _connectivity;
  
  Timer? _syncTimer;
  StreamSubscription<List<ConnectivityResult>>? _connectivitySubscription;
  bool _isSyncing = false;
  SyncStatus _syncStatus = SyncStatus.offline;
  
  // Backoff configuration
  static const Duration _initialBackoff = Duration(seconds: 1);
  static const Duration _maxBackoff = Duration(minutes: 5);
  static const int _maxRetries = 5;
  
  // Sync interval when connected
  static const Duration _syncInterval = Duration(minutes: 2);

  SyncService({
    required TaskRepository repository,
    Connectivity? connectivity,
  }) : _repository = repository,
       _connectivity = connectivity ?? Connectivity();

  SyncStatus get syncStatus => _syncStatus;
  bool get isSyncing => _isSyncing;

  // Initialize the sync service
  Future<void> initialize() async {
    // Listen to connectivity changes
    _connectivitySubscription = _connectivity.onConnectivityChanged.listen(
      _onConnectivityChanged,
    );

    // Check initial connectivity and start sync if connected
    final initialConnectivity = await _connectivity.checkConnectivity();
    await _onConnectivityChanged(initialConnectivity);
  }

  // Handle connectivity changes
  Future<void> _onConnectivityChanged(List<ConnectivityResult> results) async {
    final isConnected = results.isNotEmpty && !results.contains(ConnectivityResult.none);
    
    if (isConnected) {
      _syncStatus = SyncStatus.syncing;
      await _startPeriodicSync();
      // Immediate sync when connection is restored
      await _performSyncWithBackoff();
    } else {
      _syncStatus = SyncStatus.offline;
      _stopPeriodicSync();
    }
  }

  // Start periodic background sync
  Future<void> _startPeriodicSync() async {
    _stopPeriodicSync(); // Stop any existing timer
    
    _syncTimer = Timer.periodic(_syncInterval, (timer) async {
      if (!_isSyncing) {
        await _performSyncWithBackoff();
      }
    });
  }

  // Stop periodic sync
  void _stopPeriodicSync() {
    _syncTimer?.cancel();
    _syncTimer = null;
  }

  // Perform sync with exponential backoff retry
  Future<void> _performSyncWithBackoff() async {
    if (_isSyncing) return;

    _isSyncing = true;
    int retryCount = 0;
    Duration backoffDuration = _initialBackoff;

    while (retryCount < _maxRetries) {
      try {
        _syncStatus = SyncStatus.syncing;
        await _repository.forceSync();
        
        // Success - update status and break
        final pendingCount = await _repository.getPendingOperationsCount();
        _syncStatus = pendingCount == 0 ? SyncStatus.synced : SyncStatus.syncing;
        break;
        
      } catch (e) {
        retryCount++;
        print('Sync attempt $retryCount failed: $e');
        
        if (retryCount >= _maxRetries) {
          _syncStatus = SyncStatus.error;
          print('Sync failed after $retryCount attempts');
          break;
        }

        // Wait for backoff duration before retrying
        await Future.delayed(backoffDuration);
        
        // Exponential backoff with jitter
        backoffDuration = Duration(
          milliseconds: min(
            _maxBackoff.inMilliseconds,
            (backoffDuration.inMilliseconds * 2) + 
            Random().nextInt(1000), // Add jitter
          ),
        );
      }
    }

    _isSyncing = false;
  }

  // Manual sync trigger (for pull-to-refresh, etc.)
  Future<void> manualSync() async {
    final connectivity = await _connectivity.checkConnectivity();
    if (connectivity == ConnectivityResult.none) {
      throw Exception('No internet connection');
    }

    await _performSyncWithBackoff();
  }

  // Force immediate sync without backoff (for critical operations)
  Future<void> immediateSync() async {
    if (_isSyncing) return;

    _isSyncing = true;
    try {
      _syncStatus = SyncStatus.syncing;
      await _repository.forceSync();
      
      final pendingCount = await _repository.getPendingOperationsCount();
      _syncStatus = pendingCount == 0 ? SyncStatus.synced : SyncStatus.syncing;
    } catch (e) {
      _syncStatus = SyncStatus.error;
      rethrow;
    } finally {
      _isSyncing = false;
    }
  }

  // Get detailed sync information
  Future<SyncInfo> getSyncInfo() async {
    final connectivity = await _connectivity.checkConnectivity();
    final isConnected = connectivity != ConnectivityResult.none;
    final pendingCount = await _repository.getPendingOperationsCount();
    final apiHealthy = isConnected ? await _repository.checkApiHealth() : false;

    return SyncInfo(
      status: _syncStatus,
      isConnected: isConnected,
      isSyncing: _isSyncing,
      pendingOperationsCount: pendingCount,
      isApiHealthy: apiHealthy,
      connectivityType: connectivity,
    );
  }

  // Stream of sync status changes
  Stream<SyncStatus> get syncStatusStream async* {
    yield _syncStatus;
    
    // Monitor connectivity changes and update status
    await for (final connectivity in _connectivity.onConnectivityChanged) {
      if (connectivity == ConnectivityResult.none) {
        _syncStatus = SyncStatus.offline;
      } else if (_syncStatus == SyncStatus.offline) {
        _syncStatus = SyncStatus.syncing;
      }
      yield _syncStatus;
    }
  }

  // Cleanup old operations periodically
  Future<void> performMaintenanceCleanup() async {
    try {
      await _repository.cleanupOldOperations();
    } catch (e) {
      print('Maintenance cleanup failed: $e');
    }
  }

  // Pause sync (useful for battery saving modes)
  void pauseSync() {
    _stopPeriodicSync();
  }

  // Resume sync
  Future<void> resumeSync() async {
    final connectivity = await _connectivity.checkConnectivity();
    if (connectivity != ConnectivityResult.none) {
      await _startPeriodicSync();
    }
  }

  // Dispose resources
  Future<void> dispose() async {
    _stopPeriodicSync();
    await _connectivitySubscription?.cancel();
    _connectivitySubscription = null;
  }
}

// Sync information data class
class SyncInfo {
  final SyncStatus status;
  final bool isConnected;
  final bool isSyncing;
  final int pendingOperationsCount;
  final bool isApiHealthy;
  final ConnectivityResult connectivityType;

  const SyncInfo({
    required this.status,
    required this.isConnected,
    required this.isSyncing,
    required this.pendingOperationsCount,
    required this.isApiHealthy,
    required this.connectivityType,
  });

  @override
  String toString() {
    return 'SyncInfo(status: $status, connected: $isConnected, syncing: $isSyncing, pending: $pendingOperationsCount)';
  }
}

// Sync event for notifications/logging
class SyncEvent {
  final SyncEventType type;
  final String message;
  final DateTime timestamp;
  final Map<String, dynamic>? data;

  const SyncEvent({
    required this.type,
    required this.message,
    required this.timestamp,
    this.data,
  });
}

enum SyncEventType {
  syncStarted,
  syncCompleted,
  syncFailed,
  connectivityChanged,
  operationQueued,
  operationCompleted,
  operationFailed,
}