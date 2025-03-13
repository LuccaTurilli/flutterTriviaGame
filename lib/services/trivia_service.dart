import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/question.dart';

class TriviaService {
  final String _baseUrl = 'https://opentdb.com/api.php';

  Future<List<Question>> fetchQuestions({
    int amount = 10,
    String category = '',
    String difficulty = '',
  }) async {
    try {
      // Construir la URL con parámetros
      final url = Uri.parse(
        '$_baseUrl?amount=$amount&category=$category&difficulty=$difficulty&type=multiple',
      );

      // Realizar la solicitud HTTP con un tiempo de espera
      final response = await http.get(url).timeout(Duration(seconds: 10));

      // Verificar el código de estado HTTP
      if (response.statusCode == 200) {
        final data = json.decode(response.body);

        // Verificar si la API devolvió un error
        if (data['response_code'] != 0) {
          throw Exception('Error en la API: ${data['response_code']}');
        }

        final List<dynamic> results = data['results'];
        return results.map((json) => Question.fromJson(json)).toList();
      } else {
        throw Exception('Error en la solicitud HTTP: ${response.statusCode}');
      }
    } on TimeoutException {
      throw Exception('La solicitud a la API tardó demasiado tiempo.');
    } on FormatException {
      throw Exception('La respuesta de la API no tiene el formato esperado.');
    } catch (e) {
      throw Exception('Error al conectar con la API: $e');
    }
  }
}