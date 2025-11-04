import 'package:flutter/material.dart';
import '../../models/universidad.dart';
import '../../services/universidad_service.dart';

class NuevaUniversidadScreen extends StatefulWidget {
  const NuevaUniversidadScreen({super.key});

  @override
  State<NuevaUniversidadScreen> createState() => _NuevaUniversidadScreenState();
}

class _NuevaUniversidadScreenState extends State<NuevaUniversidadScreen> {
  final _formKey = GlobalKey<FormState>();
  final _universidadService = UniversidadService();
  
  final _nitController = TextEditingController();
  final _nombreController = TextEditingController();
  final _direccionController = TextEditingController();
  final _telefonoController = TextEditingController();
  final _paginaWebController = TextEditingController();

  bool _isLoading = false;

  @override
  void dispose() {
    _nitController.dispose();
    _nombreController.dispose();
    _direccionController.dispose();
    _telefonoController.dispose();
    _paginaWebController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Nueva Universidad'),
        backgroundColor: Colors.blue,
        foregroundColor: Colors.white,
      ),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : SingleChildScrollView(
              padding: const EdgeInsets.all(16.0),
              child: Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    // Header
                    Card(
                      child: Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Row(
                          children: [
                            const Icon(Icons.school, size: 32, color: Colors.blue),
                            const SizedBox(width: 12),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Agregar Universidad',
                                  style: Theme.of(context).textTheme.titleLarge,
                                ),
                                Text(
                                  'Complete todos los campos requeridos',
                                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                                    color: Colors.grey[600],
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),

                    const SizedBox(height: 20),

                    // Form fields
                    _buildTextField(
                      controller: _nitController,
                      label: 'NIT',
                      hint: 'Ej: 890.123.456-7',
                      icon: Icons.badge,
                      validator: _validateNit,
                    ),

                    const SizedBox(height: 16),

                    _buildTextField(
                      controller: _nombreController,
                      label: 'Nombre de la Universidad',
                      hint: 'Ej: Universidad Central del Valle',
                      icon: Icons.school,
                      validator: _validateRequired,
                    ),

                    const SizedBox(height: 16),

                    _buildTextField(
                      controller: _direccionController,
                      label: 'Dirección',
                      hint: 'Ej: Cra 27A #48-144, Tuluá - Valle',
                      icon: Icons.location_on,
                      validator: _validateRequired,
                      maxLines: 2,
                    ),

                    const SizedBox(height: 16),

                    _buildTextField(
                      controller: _telefonoController,
                      label: 'Teléfono',
                      hint: 'Ej: +57 602 2242202',
                      icon: Icons.phone,
                      validator: _validateTelefono,
                      keyboardType: TextInputType.phone,
                    ),

                    const SizedBox(height: 16),

                    _buildTextField(
                      controller: _paginaWebController,
                      label: 'Página Web',
                      hint: 'Ej: https://www.uceva.edu.co',
                      icon: Icons.language,
                      validator: _validateUrl,
                      keyboardType: TextInputType.url,
                    ),

                    const SizedBox(height: 32),

                    // Buttons
                    Row(
                      children: [
                        Expanded(
                          child: OutlinedButton(
                            onPressed: _isLoading ? null : () => Navigator.of(context).pop(),
                            child: const Text('Cancelar'),
                          ),
                        ),
                        const SizedBox(width: 16),
                        Expanded(
                          child: ElevatedButton(
                            onPressed: _isLoading ? null : _guardarUniversidad,
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.green,
                              foregroundColor: Colors.white,
                            ),
                            child: const Text('Guardar'),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
    );
  }

  Widget _buildTextField({
    required TextEditingController controller,
    required String label,
    required String hint,
    required IconData icon,
    required String? Function(String?) validator,
    TextInputType? keyboardType,
    int maxLines = 1,
  }) {
    return TextFormField(
      controller: controller,
      decoration: InputDecoration(
        labelText: label,
        hintText: hint,
        prefixIcon: Icon(icon),
        border: const OutlineInputBorder(),
        filled: true,
        fillColor: Colors.grey[50],
      ),
      keyboardType: keyboardType,
      maxLines: maxLines,
      validator: validator,
    );
  }

  String? _validateRequired(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'Este campo es requerido';
    }
    return null;
  }

  String? _validateNit(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'El NIT es requerido';
    }
    // Basic NIT format validation (flexible)
    final nitRegex = RegExp(r'^\d{3,9}[-.]?\d{1}$');
    if (!nitRegex.hasMatch(value.replaceAll(' ', ''))) {
      return 'Formato de NIT inválido';
    }
    return null;
  }

  String? _validateTelefono(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'El teléfono es requerido';
    }
    // Basic phone validation
    final phoneRegex = RegExp(r'^[\+]?[\d\s\-\(\)]{7,15}$');
    if (!phoneRegex.hasMatch(value)) {
      return 'Formato de teléfono inválido';
    }
    return null;
  }

  String? _validateUrl(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'La página web es requerida';
    }
    
    try {
      final uri = Uri.parse(value);
      if (!uri.hasScheme || (!uri.scheme.startsWith('http'))) {
        return 'URL inválida (debe comenzar con http:// o https://)';
      }
      if (!uri.hasAuthority) {
        return 'URL inválida (dominio requerido)';
      }
    } catch (e) {
      return 'URL inválida';
    }
    
    return null;
  }

  Future<void> _guardarUniversidad() async {
    if (!_formKey.currentState!.validate()) {
      return;
    }

    setState(() {
      _isLoading = true;
    });

    try {
      // Check if NIT already exists
      final nitExiste = await _universidadService.nitExiste(_nitController.text.trim());
      if (nitExiste) {
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('Ya existe una universidad con este NIT'),
              backgroundColor: Colors.orange,
            ),
          );
        }
        return;
      }

      final universidad = Universidad(
        nit: _nitController.text.trim(),
        nombre: _nombreController.text.trim(),
        direccion: _direccionController.text.trim(),
        telefono: _telefonoController.text.trim(),
        paginaWeb: _paginaWebController.text.trim(),
      );

      await _universidadService.crearUniversidad(universidad);

      if (mounted) {
        Navigator.of(context).pop(true); // Return true to indicate success
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Error al guardar: $e'),
            backgroundColor: Colors.red,
          ),
        );
      }
    } finally {
      if (mounted) {
        setState(() {
          _isLoading = false;
        });
      }
    }
  }
}