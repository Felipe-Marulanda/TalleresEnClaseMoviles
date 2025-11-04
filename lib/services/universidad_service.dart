import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/universidad.dart';

class UniversidadService {
  static const String collectionName = 'universidades';
  
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  // Get collection reference
  CollectionReference get _universidadesCollection =>
      _firestore.collection(collectionName);

  // Create a new university
  Future<String> crearUniversidad(Universidad universidad) async {
    try {
      final docRef = await _universidadesCollection.add(universidad.toMap());
      return docRef.id;
    } catch (e) {
      throw Exception('Error al crear universidad: $e');
    }
  }

  // Get all universities as a stream (real-time updates)
  Stream<List<Universidad>> obtenerUniversidades() {
    return _universidadesCollection
        .orderBy('nombre')
        .snapshots()
        .map((snapshot) {
      return snapshot.docs.map((doc) {
        return Universidad.fromMap(
          doc.data() as Map<String, dynamic>,
          id: doc.id,
        );
      }).toList();
    });
  }

  // Get a single university by ID
  Future<Universidad?> obtenerUniversidadPorId(String id) async {
    try {
      final doc = await _universidadesCollection.doc(id).get();
      if (doc.exists) {
        return Universidad.fromMap(
          doc.data() as Map<String, dynamic>,
          id: doc.id,
        );
      }
      return null;
    } catch (e) {
      throw Exception('Error al obtener universidad: $e');
    }
  }

  // Update a university
  Future<void> actualizarUniversidad(Universidad universidad) async {
    if (universidad.id == null) {
      throw Exception('ID de universidad requerido para actualizar');
    }
    
    try {
      await _universidadesCollection
          .doc(universidad.id!)
          .update(universidad.toMap());
    } catch (e) {
      throw Exception('Error al actualizar universidad: $e');
    }
  }

  // Delete a university
  Future<void> eliminarUniversidad(String id) async {
    try {
      await _universidadesCollection.doc(id).delete();
    } catch (e) {
      throw Exception('Error al eliminar universidad: $e');
    }
  }

  // Search universities by name (case-insensitive)
  Stream<List<Universidad>> buscarUniversidadesPorNombre(String nombre) {
    return _universidadesCollection
        .where('nombre', isGreaterThanOrEqualTo: nombre)
        .where('nombre', isLessThan: '${nombre}z')
        .snapshots()
        .map((snapshot) {
      return snapshot.docs.map((doc) {
        return Universidad.fromMap(
          doc.data() as Map<String, dynamic>,
          id: doc.id,
        );
      }).toList();
    });
  }

  // Check if a NIT already exists
  Future<bool> nitExiste(String nit) async {
    try {
      final query = await _universidadesCollection
          .where('nit', isEqualTo: nit)
          .limit(1)
          .get();
      return query.docs.isNotEmpty;
    } catch (e) {
      throw Exception('Error al verificar NIT: $e');
    }
  }

  // Get universities count
  Future<int> obtenerConteoUniversidades() async {
    try {
      final snapshot = await _universidadesCollection.get();
      return snapshot.docs.length;
    } catch (e) {
      throw Exception('Error al obtener conteo: $e');
    }
  }
}