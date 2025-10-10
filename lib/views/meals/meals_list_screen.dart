import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../models/meal.dart';
import '../../widgets/custom_appbar.dart';
import '../../widgets/custom_drawer.dart';

class MealsListScreen extends StatelessWidget {
  const MealsListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(title: 'Recetario brasileno'),
      drawer: const CustomDrawer(),
      body: ListView.separated(
        padding: const EdgeInsets.all(16),
        itemCount: sampleMeals.length,
        separatorBuilder: (_, __) => const SizedBox(height: 16),
        itemBuilder: (context, index) {
          final meal = sampleMeals[index];
          return _MealCard(meal: meal);
        },
      ),
    );
  }
}

class _MealCard extends StatelessWidget {
  final Meal meal;

  const _MealCard({required this.meal});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => context.pushNamed('meal_detail', extra: meal),
      borderRadius: BorderRadius.circular(18),
      child: Ink(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(18),
          boxShadow: const [
            BoxShadow(
              color: Color(0x14000000),
              blurRadius: 12,
              offset: Offset(0, 6),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius: const BorderRadius.vertical(top: Radius.circular(18)),
              child: AspectRatio(
                aspectRatio: 16 / 9,
                child: Image.network(
                  meal.imageUrl,
                  fit: BoxFit.cover,
                  loadingBuilder: (context, child, progress) {
                    if (progress == null) return child;
                    return const SizedBox(
                      height: 160,
                      child: Center(child: CircularProgressIndicator()),
                    );
                  },
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    meal.title,
                    style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    meal.description,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(color: Colors.grey[700]),
                  ),
                  const SizedBox(height: 12),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: const [
                      Text('Ver detalles', style: TextStyle(color: Colors.green)),
                      Icon(Icons.arrow_forward_ios, size: 16, color: Colors.green),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
