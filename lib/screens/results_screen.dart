import 'package:flutter/material.dart';
import 'package:provider/provider.dart'; // Importa el paquete provider
import '../providers/question_provider.dart'; // Importa el QuestionProvider
import '../providers/nav_provider.dart'; // Importa el NavProvider

/// Pantalla de resultados.
/// Muestra el puntaje final del usuario y opciones para reiniciar el juego o volver al inicio.
class ResultsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // Acceder al QuestionProvider para obtener el puntaje
    final questionProvider = Provider.of<QuestionProvider>(context);
    final score = questionProvider.score; // Puntaje del usuario

    // Acceder al NavProvider para navegar entre pantallas
    final navProvider = Provider.of<NavProvider>(context, listen: false);

    return Scaffold(
      appBar: AppBar(
        title: Text('Resultados'), // Título de la pantalla
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center, // Centrar los elementos verticalmente
          children: [
            // Mostrar el puntaje final
            Text(
              'Tu puntaje es: $score',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 20), // Espacio entre el texto y los botones

            // Botón para reiniciar el juego
            ElevatedButton(
              onPressed: () {
                // Reiniciar el estado del juego
                questionProvider.clearQuestions(); // Limpiar las preguntas
                navProvider.changeIndex(1); // Navegar a la pantalla de juego
              },
              child: Text('Reiniciar Juego'),
            ),
            SizedBox(height: 10), // Espacio entre los botones

            // Botón para volver al inicio
            ElevatedButton(
              onPressed: () {
                // Reiniciar el estado del juego
                questionProvider.clearQuestions(); // Limpiar las preguntas
                navProvider.changeIndex(0); // Navegar a la pantalla de inicio
              },
              child: Text('Volver al Inicio'),
            ),
          ],
        ),
      ),
    );
  }
}

