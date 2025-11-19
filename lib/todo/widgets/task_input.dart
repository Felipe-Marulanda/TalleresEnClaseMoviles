import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/task_provider.dart';

class TaskInput extends StatefulWidget {
  const TaskInput({super.key});

  @override
  State<TaskInput> createState() => _TaskInputState();
}

class _TaskInputState extends State<TaskInput> {
  final TextEditingController _controller = TextEditingController();
  bool _isExpanded = false;

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (!_isExpanded) {
      return FloatingActionButton(
        onPressed: _expand,
        child: const Icon(Icons.add),
      );
    }

    return Container(
      margin: const EdgeInsets.all(16),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surface,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          TextField(
            controller: _controller,
            autofocus: true,
            maxLines: null,
            decoration: const InputDecoration(
              hintText: 'Enter task title...',
              border: InputBorder.none,
            ),
            onSubmitted: _createTask,
          ),
          const SizedBox(height: 16),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              TextButton(
                onPressed: _cancel,
                child: const Text('Cancel'),
              ),
              const SizedBox(width: 8),
              Consumer<TaskProvider>(
                builder: (context, provider, child) {
                  return ElevatedButton(
                    onPressed: provider.isLoading ? null : _createTask,
                    child: provider.isLoading
                        ? const SizedBox(
                            width: 20,
                            height: 20,
                            child: CircularProgressIndicator(strokeWidth: 2),
                          )
                        : const Text('Add Task'),
                  );
                },
              ),
            ],
          ),
        ],
      ),
    );
  }

  void _expand() {
    setState(() {
      _isExpanded = true;
    });
  }

  void _cancel() {
    _controller.clear();
    setState(() {
      _isExpanded = false;
    });
  }

  void _createTask([String? value]) {
    final title = value ?? _controller.text;
    if (title.trim().isEmpty) return;

    context.read<TaskProvider>().createTask(title.trim());
    _controller.clear();
    setState(() {
      _isExpanded = false;
    });
  }
}