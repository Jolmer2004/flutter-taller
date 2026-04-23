import 'package:http/http.dart' as http;
import 'dart:convert';
import '../config/env.dart';

class ApiService {
  Future<List<dynamic>> getData(String endpoint) async {
    final response = await http.get(
      Uri.parse('${Env.baseUrl}/$endpoint'),
    );

    if (response.statusCode == 200) {
      final decoded = json.decode(response.body);

      // Si la respuesta es una lista directa
      if (decoded is List) {
        return decoded;
      }

      // Si la respuesta es un objeto paginado con campo "data"
      if (decoded is Map<String, dynamic> && decoded.containsKey('data')) {
        return decoded['data'] as List<dynamic>;
      }

      throw Exception('Formato de respuesta inesperado');
    } else {
      throw Exception('Error en la API: ${response.statusCode}');
    }
  }
}