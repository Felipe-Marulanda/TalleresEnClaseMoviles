import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;

class ApiService {
  final String _baseUrl = 'https://www.themealdb.com/api/json/v1/1/search.php?s=';

  Future<List<dynamic>> fetchData() async {
    final response = await http.get(Uri.parse(_baseUrl));

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body) as Map<String, dynamic>;
      debugPrint('✅ Datos recibidos: ${data['meals']?.length ?? 0} comidas');
      return data['meals'] as List<dynamic>? ?? <dynamic>[];
    }
    debugPrint('❌ Error: ${response.statusCode}');
    throw Exception('Error al cargar los datos de la API');
  }
}
