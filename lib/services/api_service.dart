import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'app_http_client.dart';

class ApiService {
  final String _baseUrl = 'https://www.themealdb.com/api/json/v1/1/search.php?s=';

  /// Fetch data from the public API. This uses `AppHttpClient` which will
  /// automatically add Authorization header if a token is stored in secure
  /// storage. No changes required by callers.
  Future<List<dynamic>> fetchData() async {
    final client = AppHttpClient();
    final response = await client.get(Uri.parse(_baseUrl));

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body) as Map<String, dynamic>;
      debugPrint('✅ Datos recibidos: ${data['meals']?.length ?? 0} comidas');
      return data['meals'] as List<dynamic>? ?? <dynamic>[];
    }
    debugPrint('❌ Error: ${response.statusCode}');
    throw Exception('Error al cargar los datos de la API');
  }
}
