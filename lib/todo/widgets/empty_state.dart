import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/enums.dart';
import '../providers/task_provider.dart';

class EmptyState extends StatelessWidget {
  const EmptyState({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<TaskProvider>(
      builder: (context, provider, child) {
        final filter = provider.currentFilter;
        
        String title;
        String subtitle;
        IconData icon;
        
        switch (filter) {
          case TaskFilter.all:
            title = 'No tasks yet';
            subtitle = 'Create your first task to get started';
            icon = Icons.task_alt;
            break;
          case TaskFilter.pending:
            title = 'All caught up!';
            subtitle = 'No pending tasks at the moment';
            icon = Icons.check_circle_outline;
            break;
          case TaskFilter.completed:
            title = 'No completed tasks';
            subtitle = 'Complete some tasks to see them here';
            icon = Icons.history;
            break;
        }
        
        return Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                icon,
                size: 80,
                color: Theme.of(context).colorScheme.primary.withOpacity(0.5),
              ),
              const SizedBox(height: 16),
              Text(
                title,
                style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                  color: Theme.of(context).colorScheme.onSurface.withOpacity(0.8),
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 8),
              Text(
                subtitle,
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  color: Theme.of(context).colorScheme.onSurface.withOpacity(0.6),
                ),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        );
      },
    );
  }
}