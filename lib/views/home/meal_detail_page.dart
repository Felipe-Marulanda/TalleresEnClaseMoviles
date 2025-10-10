import 'package:flutter/material.dart';

class MealDetailPage extends StatelessWidget {
  final Map<String, dynamic> meal;

  const MealDetailPage({super.key, required this.meal});

  @override
  Widget build(BuildContext context) {
    final nombre = meal['strMeal']?.toString() ?? 'Sin nombre';
    final imagen = meal['strMealThumb']?.toString() ?? '';
    final categoria = meal['strCategory']?.toString() ?? 'Sin categoría';
    final area = meal['strArea']?.toString() ?? 'Origen desconocido';
    final instrucciones = meal['strInstructions']?.toString().trim() ?? '';
    final tags = (meal['strTags']?.toString() ?? '')
        .split(',')
        .map((tag) => tag.trim())
        .where((tag) => tag.isNotEmpty)
        .toList();
    final ingredientes = <String>[];

    for (var i = 1; i <= 20; i++) {
      final ingrediente = meal['strIngredient$i']?.toString().trim() ?? '';
      final medida = meal['strMeasure$i']?.toString().trim() ?? '';
      if (ingrediente.isNotEmpty) {
        final detalle = medida.isNotEmpty ? '$ingrediente – $medida' : ingrediente;
        ingredientes.add(detalle);
      }
    }

    return Scaffold(
      appBar: AppBar(title: Text(nombre)),
      body: SingleChildScrollView(
        child: Center(
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 720),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                if (imagen.isNotEmpty)
                  ClipRRect(
                    borderRadius: const BorderRadius.only(
                      bottomLeft: Radius.circular(16),
                      bottomRight: Radius.circular(16),
                    ),
                    child: AspectRatio(
                      aspectRatio: 16 / 9,
                      child: Image.network(
                        imagen,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        nombre,
                        style: Theme.of(context)
                            .textTheme
                            .headlineSmall
                            ?.copyWith(fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(height: 12),
                      Wrap(
                        spacing: 8,
                        runSpacing: 8,
                        children: [
                          _InfoChip(icon: Icons.restaurant_menu, label: categoria),
                          _InfoChip(icon: Icons.language, label: area),
                          ...tags.map((tag) => _InfoChip(icon: Icons.tag, label: tag)),
                        ],
                      ),
                      const SizedBox(height: 24),
                      if (ingredientes.isNotEmpty) ...[
                        Text(
                          'Ingredientes',
                          style: Theme.of(context)
                              .textTheme
                              .titleMedium
                              ?.copyWith(fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(height: 8),
                        ...ingredientes.map(
                          (ingrediente) => Padding(
                            padding: const EdgeInsets.symmetric(vertical: 4),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Text('• '),
                                Expanded(child: Text(ingrediente)),
                              ],
                            ),
                          ),
                        ),
                        const SizedBox(height: 24),
                      ],
                      Text(
                        'Preparación',
                        style: Theme.of(context)
                            .textTheme
                            .titleMedium
                            ?.copyWith(fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        instrucciones.isEmpty
                            ? 'No hay instrucciones disponibles.'
                            : instrucciones,
                        style: Theme.of(context).textTheme.bodyMedium,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _InfoChip extends StatelessWidget {
  final IconData icon;
  final String label;

  const _InfoChip({required this.icon, required this.label});

  @override
  Widget build(BuildContext context) {
    return Chip(
      avatar: Icon(icon, size: 16),
      label: Text(label),
    );
  }
}
