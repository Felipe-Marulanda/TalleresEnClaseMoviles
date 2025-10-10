import 'package:flutter/material.dart';
import 'package:parqueadero_2025_g2/services/api_service.dart';
import 'package:parqueadero_2025_g2/widgets/item_card.dart';
import 'meal_detail_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late Future<List<dynamic>> _dataFuture;

  @override
  void initState() {
    super.initState();
    _dataFuture = ApiService().fetchData();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<dynamic>>(
      future: _dataFuture,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        }

        if (snapshot.hasError) {
          return Center(child: Text('Error: ${snapshot.error}'));
        }

        if (!snapshot.hasData || snapshot.data!.isEmpty) {
          return const Center(child: Text('No hay datos disponibles'));
        }

        final data = snapshot.data!;
        return ListView.builder(
          padding: const EdgeInsets.all(10),
          itemCount: data.length,
          itemBuilder: (context, index) {
            final meal = data[index] as Map<String, dynamic>;
            final title = meal['strMeal']?.toString() ?? 'Sin nombre';
            final category = meal['strCategory']?.toString().trim() ?? '';
            final area = meal['strArea']?.toString().trim() ?? '';
            final instructions = meal['strInstructions']?.toString().trim() ?? '';
            final highlightParts = <String>[
              if (category.isNotEmpty) category,
              if (area.isNotEmpty) area,
            ];
            final description = highlightParts.isNotEmpty
                ? highlightParts.join(' · ')
                : instructions;
            final imageUrl = meal['strMealThumb']?.toString() ?? '';

            return Center(
              child: ConstrainedBox(
                constraints: const BoxConstraints(maxWidth: 720),
                child: GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => MealDetailPage(meal: meal),
                      ),
                    );
                  },
                  child: ItemCard(
                    title: title,
                    description:
                        description.isEmpty ? 'Sin descripción' : description,
                    imageUrl: imageUrl,
                  ),
                ),
              ),
            );
          },
        );
      },
    );
  }
}
