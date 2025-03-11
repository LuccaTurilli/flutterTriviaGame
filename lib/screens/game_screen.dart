import 'package:flutter/material.dart';
import '../models/question.dart'; // Importamos el modelo de pregunta
import '../utils/questions_data.dart'; // Importamos los datos de preguntas

class GameScreen extends StatefulWidget {
  @override
  _GameScreenState createState() => _GameScreenState();
}

class _GameScreenState extends State<GameScreen>
    with SingleTickerProviderStateMixin {
  late List<Question>
  questions; // Lista de preguntas que se mostrarán en el juego
  int currentQuestionIndex = 0; // Índice de la pregunta actual
  int score = 0; // Puntaje del jugador
  late AnimationController _controller;
  late Animation<double> _fadeAnimation;

  @override
  void initState() {
    super.initState();
    // Inicializamos la lista de preguntas al cargar la pantalla
    questions =
        getQuestions(); // Obtenemos las preguntas desde el archivo de datos

    _controller = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 100),
    );
    _fadeAnimation = Tween<double>(begin: 0, end: 1).animate(_controller);
    _controller.forward();
  }

  // Función para verificar si la respuesta seleccionada es correcta
  void checkAnswer(int selectedIndex) {
    bool isCorrect =
        selectedIndex == questions[currentQuestionIndex].correctAnswerIndex;
    // Verificamos si el índice seleccionado coincide con el índice de la respuesta correcta
    if (isCorrect) score++;

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          isCorrect ? '¡Respuesta Correcta!' : 'Respuesta Incorrecta',
        ),
        backgroundColor: isCorrect ? Colors.green : Colors.red,
        duration: Duration(seconds: 1),
      ),
    );

    // Si no estamos en la última pregunta, avanzamos a la siguiente
    if (currentQuestionIndex < questions.length - 1) {
      setState(() {
        currentQuestionIndex++; // Avanzamos al siguiente índice de pregunta
        _controller.reset();
        _controller.forward();
      });
    } else {
      // Si ya no hay más preguntas, navegamos a la pantalla de resultados
      Navigator.pushReplacementNamed(
        context,
        '/results', // Ruta de la pantalla de resultados
        arguments: score, // Pasamos el puntaje como argumento
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    // Obtenemos la pregunta actual basándonos en el índice
    final currentQuestion = questions[currentQuestionIndex];

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Pregunta ${currentQuestionIndex + 1}',
        ), // Mostramos el número de la pregunta
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(2.0), // Agregamos un margen interno
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment:
                CrossAxisAlignment
                    .center, // Alineamos el contenido a la izquierda
            children: [
              // Mostramos el texto de la pregunta
              Text(
                currentQuestion.text,
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ), // Estilo del texto de la pregunta
              ),
              SizedBox(height: 20), // Espacio entre la pregunta y las opciones
              // Generamos dinámicamente los botones de las opciones de respuesta
              ...currentQuestion.options.asMap().entries.map((entry) {
                int index = entry.key; // Índice de la opción
                SizedBox(height: 20);
                String option = entry.value; // Texto de la opción

                return Column(
                  children: [
                    ElevatedButton(
                      onPressed:
                          () => checkAnswer(
                            index,
                          ), // Llamamos a la función para verificar la respuesta
                      child: Text(option), // Mostramos el texto de la opción
                      style: ElevatedButton.styleFrom(
                        minimumSize: Size(
                          double.infinity,
                          50,
                        ), // Hacemos que los botones ocupen todo el ancho
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(
                            80,
                          ), // Bordes redondeados
                        ),
                      ),
                    ),
                    SizedBox(height: 10), // Espacio entre cada botón
                  ],
                );
              }).toList(), // Convertimos el mapa en una lista de widgets
            ],
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}
