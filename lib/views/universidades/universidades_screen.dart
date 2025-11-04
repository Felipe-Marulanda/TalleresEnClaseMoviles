import 'package:flutter/material.dart';
import '../../models/universidad.dart';
import '../../services/universidad_service.dart';
import '../../widgets/custom_appbar.dart';
import '../../widgets/custom_drawer.dart';
import 'nueva_universidad_screen.dart';

class UniversidadesScreen extends StatefulWidget {
  const UniversidadesScreen({super.key});

  @override
  State<UniversidadesScreen> createState() => _UniversidadesScreenState();
}

class _UniversidadesScreenState extends State<UniversidadesScreen> {
  final UniversidadService _universidadService = UniversidadService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(title: 'Universidades'),
      drawer: CustomDrawer(),
      body: Column(
        children: [
          // Header with add button
          Container(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              children: [
                const Icon(Icons.school, color: Colors.blue),
                const SizedBox(width: 8),
                const Text(
                  'Gestión de Universidades',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const Spacer(),
                ElevatedButton.icon(
                  onPressed: () => _navigateToNuevaUniversidad(),
                  icon: const Icon(Icons.add),
                  label: const Text('Nueva'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.green,
                    foregroundColor: Colors.white,
                  ),
                ),
              ],
            ),
          ),
          const Divider(),
          // Universities list
          Expanded(
            child: StreamBuilder<List<Universidad>>(
              stream: _universidadService.obtenerUniversidades(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                }

                if (snapshot.hasError) {
                  return Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Icon(
                          Icons.error_outline,
                          size: 64,
                          color: Colors.red,
                        ),
                        const SizedBox(height: 16),
                        Text(
                          'Error al cargar universidades',
                          style: Theme.of(context).textTheme.headlineSmall,
                        ),
                        const SizedBox(height: 8),
                        Text(
                          snapshot.error.toString(),
                          textAlign: TextAlign.center,
                          style: const TextStyle(color: Colors.grey),
                        ),
                        const SizedBox(height: 16),
                        ElevatedButton(
                          onPressed: () => setState(() {}),
                          child: const Text('Reintentar'),
                        ),
                      ],
                    ),
                  );
                }

                final universidades = snapshot.data ?? [];

                if (universidades.isEmpty) {
                  return Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Icon(
                          Icons.school_outlined,
                          size: 64,
                          color: Colors.grey,
                        ),
                        const SizedBox(height: 16),
                        Text(
                          'No hay universidades registradas',
                          style: Theme.of(context).textTheme.headlineSmall,
                        ),
                        const SizedBox(height: 8),
                        const Text(
                          'Toca el botón "Nueva" para agregar la primera universidad',
                          textAlign: TextAlign.center,
                          style: TextStyle(color: Colors.grey),
                        ),
                        const SizedBox(height: 16),
                        ElevatedButton.icon(
                          onPressed: () => _navigateToNuevaUniversidad(),
                          icon: const Icon(Icons.add),
                          label: const Text('Agregar Universidad'),
                        ),
                      ],
                    ),
                  );
                }

                return ListView.builder(
                  itemCount: universidades.length,
                  itemBuilder: (context, index) {
                    final universidad = universidades[index];
                    return _UniversidadCard(
                      universidad: universidad,
                      onTap: () => _showUniversidadDetails(universidad),
                      onDelete: () => _showDeleteConfirmation(universidad),
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  Future<void> _navigateToNuevaUniversidad() async {
    final result = await Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => const NuevaUniversidadScreen(),
      ),
    );

    if (result == true && mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Universidad creada exitosamente'),
          backgroundColor: Colors.green,
        ),
      );
    }
  }

  void _showUniversidadDetails(Universidad universidad) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(universidad.nombre),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _DetailRow('NIT:', universidad.nit),
            _DetailRow('Dirección:', universidad.direccion),
            _DetailRow('Teléfono:', universidad.telefono),
            _DetailRow('Página Web:', universidad.paginaWeb),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('Cerrar'),
          ),
        ],
      ),
    );
  }

  void _showDeleteConfirmation(Universidad universidad) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Confirmar eliminación'),
        content: Text(
          '¿Estás seguro de que deseas eliminar la universidad "${universidad.nombre}"?',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('Cancelar'),
          ),
          TextButton(
            onPressed: () async {
              Navigator.of(context).pop();
              try {
                await _universidadService.eliminarUniversidad(universidad.id!);
                if (mounted) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('Universidad eliminada exitosamente'),
                      backgroundColor: Colors.red,
                    ),
                  );
                }
              } catch (e) {
                if (mounted) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text('Error al eliminar: $e'),
                      backgroundColor: Colors.red,
                    ),
                  );
                }
              }
            },
            style: TextButton.styleFrom(foregroundColor: Colors.red),
            child: const Text('Eliminar'),
          ),
        ],
      ),
    );
  }
}

class _UniversidadCard extends StatelessWidget {
  final Universidad universidad;
  final VoidCallback onTap;
  final VoidCallback onDelete;

  const _UniversidadCard({
    required this.universidad,
    required this.onTap,
    required this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
      child: ListTile(
        leading: const CircleAvatar(
          backgroundColor: Colors.blue,
          child: Icon(Icons.school, color: Colors.white),
        ),
        title: Text(
          universidad.nombre,
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('NIT: ${universidad.nit}'),
            Text(
              universidad.direccion,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
          ],
        ),
        trailing: PopupMenuButton(
          onSelected: (value) {
            if (value == 'delete') {
              onDelete();
            }
          },
          itemBuilder: (context) => [
            const PopupMenuItem(
              value: 'delete',
              child: Row(
                children: [
                  Icon(Icons.delete, color: Colors.red),
                  SizedBox(width: 8),
                  Text('Eliminar'),
                ],
              ),
            ),
          ],
        ),
        onTap: onTap,
      ),
    );
  }
}

class _DetailRow extends StatelessWidget {
  final String label;
  final String value;

  const _DetailRow(this.label, this.value);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 80,
            child: Text(
              label,
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
          ),
          Expanded(child: Text(value)),
        ],
      ),
    );
  }
}