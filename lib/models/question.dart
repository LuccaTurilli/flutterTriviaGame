// Modelo de datos para representar una pregunta en la trivia
class Question {
  // Texto de la pregunta
  final String text;

  // Lista de opciones de respuesta (incluye tanto respuestas incorrectas como correctas)
  final List<String> options;

  // Respuesta correcta
  final String correctAnswer;

  // Constructor para crear una instancia de Question
  Question({
    required this.text,
    required this.options,
    required this.correctAnswer,
  });

  // Método factory para crear un objeto Question a partir de un JSON recibido de la API
  factory Question.fromJson(Map<String, dynamic> json) {
    // Extraemos las respuestas incorrectas desde el JSON
    final incorrectAnswers = List<String>.from(json['incorrect_answers']);

    // Extraemos la respuesta correcta desde el JSON
    final correctAnswer = json['correct_answer'];

    // Combinamos las respuestas incorrectas con la respuesta correcta
    final List<String> allOptions = [...incorrectAnswers, correctAnswer];

    // Mezclamos las opciones para que no siempre aparezcan en el mismo orden
    allOptions.shuffle();

    // Retornamos una nueva instancia de Question con los datos procesados
    return Question(
      text: json['question'], // Texto de la pregunta
      options: allOptions, // Opciones mezcladas
      correctAnswer: correctAnswer, // Respuesta correcta
    );
  }

  // Método para verificar si una respuesta seleccionada es correcta
  bool isCorrect(String answer) {
    // Comparamos la respuesta seleccionada con la respuesta correcta
    return answer == correctAnswer;
  }
}