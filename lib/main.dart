import 'package:flutter/material.dart';
import 'screens/bottom_nav_wrapper.dart'; // Importamos la pantalla de resultados

void main() {
  runApp(MyApp()); // Iniciamos la aplicación llamando al widget principal
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {

    
    return MaterialApp(
      title: 'Trivia App', // Título de la aplicación
      theme: ThemeData(
        primarySwatch: Colors.blue, // Tema principal con colores azules
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      initialRoute: '/', // Ruta inicial de la aplicación
      home: BottomNavWrapper(), // Pantalla de inicio
   /*   routes: {
        '/': (context) => BottomNavScreen(), // Ruta para la pantalla de inicio
        '/game': (context) => GameScreen(), // Ruta para la pantalla de juego
        '/results':
            (context) => ResultScreen(
              score: ModalRoute.of(context)!.settings.arguments as int,
            ), // Ruta para la pantalla de resultados
      },  */
    );
  }
}
