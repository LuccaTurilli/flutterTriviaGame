import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../services/trivia_service.dart'; // Servicio para conectarse a la API
import '../models/question.dart'; // Modelo de pregunta
import '../providers/question_provider.dart'; // Provider para gestionar las preguntas

class GameScreen extends StatefulWidget {
  /// Callback para cambiar el índice del BottomNavigationBar.
  final Function(int) changeIndex;

  const GameScreen({required this.changeIndex});

  @override
  _GameScreenState createState() => _GameScreenState();
}

class _GameScreenState extends State<GameScreen> {
  /// Índice de la pregunta actual.
  int currentQuestionIndex = 0;

  /// Indicador de carga mientras se cargan las preguntas.
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    loadQuestions(); // Cargar preguntas al iniciar la pantalla.
  }

  /// Método para cargar las preguntas desde el QuestionProvider.
  Future<void> loadQuestions() async {
    final questionProvider = Provider.of<QuestionProvider>(context, listen: false);

    // Verificar si ya hay preguntas cargadas en el provider.
    if (!questionProvider.areQuestionsLoaded) {
      try {
        final triviaService = TriviaService();
        final fetchedQuestions = await triviaService.fetchQuestions(amount: 5); // Cargar 5 preguntas.
        questionProvider.setQuestions(fetchedQuestions); // Guardar preguntas en el provider.
      } catch (e) {
        print('Error al cargar las preguntas: $e');
        showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: Text('Error'),
            content: Text('No se pudieron cargar las preguntas. Por favor, inténtalo de nuevo.'),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(context),
                child: Text('Cerrar'),
              ),
            ],
          ),
        );
      }
    }

    setState(() {
      isLoading = false; // Finalizar la carga.
    });
  }

  /// Método para verificar si la respuesta seleccionada es correcta.
  void checkAnswer(String selectedOption) {
    final questionProvider = Provider.of<QuestionProvider>(context, listen: false);
    final currentQuestion = questionProvider.questions[currentQuestionIndex];

    // Verificar si la respuesta seleccionada es correcta.
    if (currentQuestion.isCorrect(selectedOption)) {
      setState(() {
      questionProvider.updateScore(1); // Incrementar el puntaje en el provider. // Incrementar el puntaje si la respuesta es correcta.
         ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('¡Respuesta Correcta!'),
            backgroundColor: Colors.green,
            duration: Duration(seconds: 1),
          ),
        );      
      });
    }else{
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('¡Respuesta incorrecta!'),
          backgroundColor: Colors.red,
          duration: Duration(seconds: 1),
        ),
      );
    }

    // Si no estamos en la última pregunta, avanzar a la siguiente.
    if (currentQuestionIndex < questionProvider.questions.length - 1) {
      setState(() {
        currentQuestionIndex++;
      });
    } else {
      // Si ya no hay más preguntas, navegar a la pantalla de resultados.
      widget.changeIndex(2); // Cambiar al índice de la pantalla de resultados.
    }
  }

  @override
  Widget build(BuildContext context) {
    final questionProvider = Provider.of<QuestionProvider>(context);

    // Mostrar un indicador de carga mientras se cargan las preguntas.
    if (isLoading) {
      return Scaffold(
        appBar: AppBar(title: Text('Trivia App')),
        body: Center(
          child: CircularProgressIndicator(),
        ),
      );
    }

    // Mostrar un mensaje si no hay preguntas disponibles.
    if (questionProvider.questions.isEmpty) {
      return Scaffold(
        appBar: AppBar(title: Text('Trivia App')),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text('No se pudieron cargar las preguntas.'),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: loadQuestions, // Reintentar cargar preguntas.
                child: Text('Reintentar'),
              ),
            ],
          ),
        ),
      );
    }

    // Obtener la pregunta actual basándonos en el índice.
    final currentQuestion = questionProvider.questions[currentQuestionIndex];

    return Scaffold(
      appBar: AppBar(
        title: Text('Pregunta ${currentQuestionIndex + 1}'), // Mostrar el número de la pregunta.
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0), // Agregar margen interno.
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start, // Alinear el contenido a la izquierda.
          children: [
            // Mostrar el texto de la pregunta.
            Text(
              currentQuestion.text,
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 20), // Espacio entre la pregunta y las opciones.

            // Generar dinámicamente los botones de las opciones de respuesta.
            ...currentQuestion.options.map((option) {
              return Padding(
                padding: const EdgeInsets.symmetric(vertical: 5), // Espaciado vertical entre botones.
                child: ElevatedButton(
                  onPressed: () => checkAnswer(option), // Verificar la respuesta al presionar.
                  child: Text(option), // Mostrar el texto de la opción.
                ),
              );
            }).toList(), // Convertir el mapa en una lista de widgets.
          ],
        ),
      ),
    );
  }
}