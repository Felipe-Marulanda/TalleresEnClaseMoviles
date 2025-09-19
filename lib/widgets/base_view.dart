import 'package:flutter/material.dart';

class GridScreen extends StatelessWidget {
  const GridScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final items = List.generate(12, (index) => "Item $index");

    return Scaffold(
      appBar: AppBar(title: const Text("GridView")),
      body: GridView.builder(
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 3,
          crossAxisSpacing: 8,
          mainAxisSpacing: 8,
        ),
        itemCount: items.length,
        itemBuilder: (context, index) {
          return Card(
            color: Colors.blue.shade100,
            child: Center(child: Text(items[index])),
          );
        },
      ),
    );
  }
}
