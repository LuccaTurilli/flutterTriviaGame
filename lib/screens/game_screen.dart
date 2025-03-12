import 'package:flutter/material.dart';
import '../services/trivia_service.dart'; // Importamos el servicio para conectarnos a la API
import '../models/question.dart'; // Importamos el modelo de pregunta

class GameScreen extends StatefulWidget {


  final Function(int) changeIndex; // Callback para cambiar el índice del BottomNavigationBar
  final Function(int) updateScore; // Callback para actualizar el puntaje

  GameScreen({required this.changeIndex, required this.updateScore});

  @override
    _GameScreenState createState() => _GameScreenState();
}

class _GameScreenState extends State<GameScreen> {
  // Inicializamos una lista vacía para almacenar las preguntas.
  // Esto asegura que `questions` siempre tenga un valor inicial.
  List<Question> questions = [];

  // Índice de la pregunta actual. Comienza en 0 (primera pregunta).
  int currentQuestionIndex = 0;

  // Puntaje del jugador. Se incrementa cuando el usuario responde correctamente.
  int score = 0;

  // Indicador de carga. Es `true` mientras se cargan las preguntas desde la API.
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    // Llamamos al método para cargar las preguntas desde la API cuando se inicia la pantalla.
    fetchQuestionsFromAPI();
  }

  // Método para cargar preguntas desde la API
  Future<void> fetchQuestionsFromAPI() async {
    final triviaService = TriviaService(); // Instancia del servicio de la API
    try {
      // Obtenemos las preguntas desde la API usando el método `fetchQuestions`.
      // Usamos `await` para esperar a que el `Future` se complete.
      final fetchedQuestions = await triviaService.fetchQuestions(amount: 5, category: "25");

      // Actualizamos el estado con las preguntas obtenidas y desactivamos el indicador de carga.
      setState(() {
        questions = fetchedQuestions; // Asignamos las preguntas cargadas
        isLoading = false; // Indicamos que la carga ha terminado
      });
    } catch (e) {
      // Si ocurre un error al cargar las preguntas, lo mostramos en la consola.
      print('Error al cargar las preguntas: $e');

      // Actualizamos el estado para desactivar el indicador de carga incluso si hay un error.
      setState(() {
        isLoading = false;
      });
    }
  }

  // Función para verificar si la respuesta seleccionada es correcta
  void checkAnswer(String selectedOption) {
    // Obtenemos la pregunta actual basándonos en el índice.
    final currentQuestion = questions[currentQuestionIndex];

    // Verificamos si la respuesta seleccionada es correcta.
    if (currentQuestion.isCorrect(selectedOption)) {
      setState(() {
        score++; // Incrementamos el puntaje si la respuesta es correcta
      });
    }

    // Si no estamos en la última pregunta, avanzamos a la siguiente.
    if (currentQuestionIndex < questions.length - 1) {
      setState(() {
        currentQuestionIndex++; // Avanzamos al siguiente índice de pregunta
      });
    } else {
      // Si ya no hay más preguntas, navegamos a la pantalla de resultados.
 widget.updateScore(score); // Actualizamos el puntaje global
      widget.changeIndex(2); // Navegamos a la pantalla de resultados (índice 2)
    }
  }

  @override
  Widget build(BuildContext context) {
    // Si `isLoading` es `true`, mostramos un indicador de carga.
    if (isLoading) {
      return Scaffold(
        appBar: AppBar(title: Text('Trivia App')),
        body: Center(
          child: CircularProgressIndicator(), // Indicador de carga circular
        ),
      );
    }

    // Si `questions` está vacía después de intentar cargar las preguntas, mostramos un mensaje de error.
    if (questions.isEmpty) {
      return Scaffold(
        appBar: AppBar(title: Text('Trivia App')),
        body: Center(
          child: Text('No se pudieron cargar las preguntas.'), // Mensaje de error
        ),
      );
    }

    // Obtenemos la pregunta actual basándonos en el índice.
    final currentQuestion = questions[currentQuestionIndex];

    return Scaffold(
      appBar: AppBar(
        title: Text('Pregunta ${currentQuestionIndex + 1}'), // Mostramos el número de la pregunta
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0), // Agregamos un margen interno
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start, // Alineamos el contenido a la izquierda
          children: [
            // Mostramos el texto de la pregunta
            Text(
              currentQuestion.text,
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold), // Estilo del texto de la pregunta
            ),
            SizedBox(height: 20), // Espacio entre la pregunta y las opciones

            // Generamos dinámicamente los botones de las opciones de respuesta
            ...currentQuestion.options.map((option) {
              return Padding(
                padding: const EdgeInsets.symmetric(vertical: 5), // Espaciado vertical entre botones
                child: ElevatedButton(
                  onPressed: () => checkAnswer(option), // Llamamos a la función para verificar la respuesta
                  child: Text(option), // Mostramos el texto de la opción
                ),
              );
            }).toList(), // Convertimos el mapa en una lista de widgets
          ],
        ),
      ),
    );
  }
}