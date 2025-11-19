import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/enums.dart';
import '../providers/task_provider.dart';

class FilterTabs extends StatelessWidget {
  const FilterTabs({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<TaskProvider>(
      builder: (context, provider, child) {
        return Container(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Row(
            children: [
              Expanded(
                child: _FilterChip(
                  label: 'All',
                  count: provider.totalTasks,
                  isSelected: provider.currentFilter == TaskFilter.all,
                  onTap: () => provider.setFilter(TaskFilter.all),
                ),
              ),
              const SizedBox(width: 8),
              Expanded(
                child: _FilterChip(
                  label: 'Pending',
                  count: provider.pendingCount,
                  isSelected: provider.currentFilter == TaskFilter.pending,
                  onTap: () => provider.setFilter(TaskFilter.pending),
                ),
              ),
              const SizedBox(width: 8),
              Expanded(
                child: _FilterChip(
                  label: 'Completed',
                  count: provider.completedCount,
                  isSelected: provider.currentFilter == TaskFilter.completed,
                  onTap: () => provider.setFilter(TaskFilter.completed),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}

class _FilterChip extends StatelessWidget {
  final String label;
  final int count;
  final bool isSelected;
  final VoidCallback onTap;

  const _FilterChip({
    required this.label,
    required this.count,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
        decoration: BoxDecoration(
          color: isSelected
              ? Theme.of(context).colorScheme.primary
              : Theme.of(context).colorScheme.surface,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(
            color: isSelected
                ? Theme.of(context).colorScheme.primary
                : Theme.of(context).colorScheme.outline.withOpacity(0.2),
          ),
        ),
        child: Column(
          children: [
            Text(
              label,
              style: TextStyle(
                fontWeight: FontWeight.w600,
                color: isSelected
                    ? Theme.of(context).colorScheme.onPrimary
                    : Theme.of(context).colorScheme.onSurface,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              '$count',
              style: TextStyle(
                fontSize: 12,
                color: isSelected
                    ? Theme.of(context).colorScheme.onPrimary.withOpacity(0.8)
                    : Theme.of(context).colorScheme.onSurface.withOpacity(0.6),
              ),
            ),
          ],
        ),
      ),
    );
  }
}