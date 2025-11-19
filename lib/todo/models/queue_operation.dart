enum OperationType { create, update, delete }

class QueueOperation {
  final String id;
  final String entity;
  final String entityId;
  final OperationType operation;
  final Map<String, dynamic> payload;
  final DateTime createdAt;
  final int attemptCount;
  final String? lastError;

  const QueueOperation({
    required this.id,
    required this.entity,
    required this.entityId,
    required this.operation,
    required this.payload,
    required this.createdAt,
    this.attemptCount = 0,
    this.lastError,
  });

  QueueOperation copyWith({
    String? id,
    String? entity,
    String? entityId,
    OperationType? operation,
    Map<String, dynamic>? payload,
    DateTime? createdAt,
    int? attemptCount,
    String? lastError,
  }) {
    return QueueOperation(
      id: id ?? this.id,
      entity: entity ?? this.entity,
      entityId: entityId ?? this.entityId,
      operation: operation ?? this.operation,
      payload: payload ?? this.payload,
      createdAt: createdAt ?? this.createdAt,
      attemptCount: attemptCount ?? this.attemptCount,
      lastError: lastError ?? this.lastError,
    );
  }

  // SQLite serialization
  Map<String, dynamic> toSqlite() {
    return {
      'id': id,
      'entity': entity,
      'entity_id': entityId,
      'op': operation.name,
      'payload': _encodePayload(payload),
      'created_at': createdAt.millisecondsSinceEpoch,
      'attempt_count': attemptCount,
      'last_error': lastError,
    };
  }

  factory QueueOperation.fromSqlite(Map<String, dynamic> sqlite) {
    return QueueOperation(
      id: sqlite['id'] as String,
      entity: sqlite['entity'] as String,
      entityId: sqlite['entity_id'] as String,
      operation: OperationType.values.byName(sqlite['op'] as String),
      payload: _decodePayload(sqlite['payload'] as String),
      createdAt: DateTime.fromMillisecondsSinceEpoch(sqlite['created_at'] as int),
      attemptCount: sqlite['attempt_count'] as int? ?? 0,
      lastError: sqlite['last_error'] as String?,
    );
  }

  // Helper methods for payload encoding/decoding
  static String _encodePayload(Map<String, dynamic> payload) {
    // Simple JSON encoding - in production, consider using dart:convert
    final buffer = StringBuffer('{');
    final entries = payload.entries.toList();
    for (int i = 0; i < entries.length; i++) {
      final entry = entries[i];
      buffer.write('"${entry.key}":');
      if (entry.value is String) {
        buffer.write('"${entry.value}"');
      } else if (entry.value is bool) {
        buffer.write('${entry.value}');
      } else if (entry.value is num) {
        buffer.write('${entry.value}');
      } else {
        buffer.write('"${entry.value.toString()}"');
      }
      if (i < entries.length - 1) buffer.write(',');
    }
    buffer.write('}');
    return buffer.toString();
  }

  static Map<String, dynamic> _decodePayload(String payload) {
    // Simple JSON decoding - in production, use dart:convert
    // This is a simplified version for the demo
    final result = <String, dynamic>{};
    if (payload.isEmpty || payload == '{}') return result;
    
    // Remove brackets and split by comma
    final content = payload.substring(1, payload.length - 1);
    final pairs = content.split(',');
    
    for (final pair in pairs) {
      final colonIndex = pair.indexOf(':');
      if (colonIndex == -1) continue;
      
      String key = pair.substring(0, colonIndex).trim();
      String value = pair.substring(colonIndex + 1).trim();
      
      // Remove quotes from key and value
      if (key.startsWith('"') && key.endsWith('"')) {
        key = key.substring(1, key.length - 1);
      }
      
      if (value.startsWith('"') && value.endsWith('"')) {
        value = value.substring(1, value.length - 1);
        result[key] = value;
      } else if (value == 'true') {
        result[key] = true;
      } else if (value == 'false') {
        result[key] = false;
      } else if (double.tryParse(value) != null) {
        result[key] = double.parse(value);
      } else {
        result[key] = value;
      }
    }
    
    return result;
  }

  @override
  String toString() {
    return 'QueueOperation(id: $id, entity: $entity, entityId: $entityId, operation: $operation, attempts: $attemptCount)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is QueueOperation &&
        other.id == id &&
        other.entity == entity &&
        other.entityId == entityId &&
        other.operation == operation;
  }

  @override
  int get hashCode {
    return Object.hash(id, entity, entityId, operation);
  }
}