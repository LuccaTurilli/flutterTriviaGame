import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/question.dart';

class TriviaService {
  // URL base de la API
  final String _baseUrl = 'https://opentdb.com/api.php';


  // Método para obtener preguntas desde la API
  Future<List<Question>> fetchQuestions({
    int amount = 10, // Número de preguntas
    String category = '', // Categoría (opcional)
    String difficulty = '', // Dificultad (opcional)
  }) async {
    try {
      // Construir la URL con parámetros
      final response = await http.get(Uri.parse(
        '$_baseUrl?amount=$amount&category=$category&difficulty=$difficulty&type=multiple',
      ));

      // Verificar si la respuesta fue exitosa
      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        final List<dynamic> results = data['results'];

        // Convertir los datos JSON en objetos Question
        return results.map((json) => Question.fromJson(json)).toList();
      } else {
        throw Exception('Error al cargar las preguntas: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Error al conectar con la API: $e');
    }
  }
}

