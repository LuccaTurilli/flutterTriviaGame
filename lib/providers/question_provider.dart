import 'package:flutter/material.dart';
import '../models/question.dart'; // Importamos el modelo de pregunta

/// Provider para gestionar las preguntas.
/// Este provider permite almacenar, cargar y acceder a las preguntas desde cualquier parte de la aplicación.
class QuestionProvider with ChangeNotifier {

  int _score = 0;

  /// Lista de preguntas cargadas.
  List<Question> _questions = [];

  /// Indica si las preguntas ya han sido cargadas.
  bool _areQuestionsLoaded = false;

  /// Getter para obtener la lista de preguntas.
  List<Question> get questions => _questions;

  /// Getter para verificar si las preguntas están cargadas.
  bool get areQuestionsLoaded => _areQuestionsLoaded;

//getter de score
  int get score => _score;

  /// Método para establecer las preguntas.
  /// Se usa cuando se cargan preguntas desde la API o desde el almacenamiento local.
  void setQuestions(List<Question> questions) {
    _questions = questions; // Guardar las preguntas.
    _areQuestionsLoaded = true; // Marcar como cargadas.
    notifyListeners(); // Notificar a los widgets que escuchan este provider.
  }

  /// Método para limpiar las preguntas.
  /// Se puede usar para reiniciar el juego o borrar el estado.
  void clearQuestions() {
    _questions = []; // Limpiar la lista de preguntas.
    _areQuestionsLoaded = false; // Marcar como no cargadas.
    notifyListeners(); // Notificar a los widgets que escuchan este provider.
  }
  //actualizar score
  void updateScore(int points) {
    _score += points;
    notifyListeners();
  }

}