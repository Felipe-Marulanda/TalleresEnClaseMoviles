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
  bool _initialized = false;

  @override
  void initState() {
    super.initState();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (!_initialized) {
      _dataFuture = ApiService().fetchData();
      _initialized = true;
    }
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
          // Don't show raw exception to users. Provide a friendly message and
          // an optional Details button for debugging.
          return Center(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Card(
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const Icon(Icons.wifi_off, size: 48, color: Colors.grey),
                      const SizedBox(height: 12),
                      Text('No se pudieron cargar las recetas', style: Theme.of(context).textTheme.titleMedium),
                      const SizedBox(height: 8),
                      const Text(
                        'Revisa tu conexión a internet o inténtalo de nuevo más tarde.',
                        textAlign: TextAlign.center,
                        style: TextStyle(color: Colors.grey),
                      ),
                      const SizedBox(height: 12),
                      Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          ElevatedButton.icon(
                            icon: const Icon(Icons.refresh),
                            label: const Text('Reintentar'),
                            onPressed: () {
                              setState(() {
                                _dataFuture = ApiService().fetchData();
                              });
                            },
                          ),
                          const SizedBox(width: 8),
                          TextButton(
                            child: const Text('Detalles'),
                            onPressed: () {
                              final details = snapshot.error?.toString() ?? 'Sin detalles';
                              showDialog<void>(
                                context: context,
                                builder: (_) => AlertDialog(
                                  title: const Text('Detalles técnicos'),
                                  content: SingleChildScrollView(child: Text(details)),
                                  actions: [
                                    TextButton(onPressed: () => Navigator.of(context).pop(), child: const Text('Cerrar')),
                                  ],
                                ),
                              );
                            },
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
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
