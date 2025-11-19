import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;

class ApiService {
  final String _baseUrl = 'https://www.themealdb.com/api/json/v1/1/search.php?s=';

  /// Fetch data from the public API. This uses standard http client since
  /// TheMealDB is a public API that doesn't require authentication.
  /// Using AppHttpClient would add unnecessary Authorization headers.
  Future<List<dynamic>> fetchData() async {
    try {
      final response = await http.get(
        Uri.parse(_baseUrl),
      ).timeout(
        const Duration(seconds: 10),
        onTimeout: () {
          throw Exception('Tiempo de espera agotado. Revisa tu conexión a internet.');
        },
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body) as Map<String, dynamic>;
        final meals = data['meals'] as List<dynamic>? ?? <dynamic>[];
        debugPrint('✅ Datos recibidos: ${meals.length} comidas');
        return meals;
      }
      
      debugPrint('❌ Error HTTP: ${response.statusCode}');
      throw Exception('Error del servidor (${response.statusCode}). Inténtalo de nuevo.');
    } catch (e) {
      debugPrint('❌ Error en fetchData: $e');
      if (e.toString().contains('SocketException') || 
          e.toString().contains('NetworkException')) {
        throw Exception('Sin conexión a internet. Verifica tu conexión.');
      }
      rethrow;
    }
  }
}
