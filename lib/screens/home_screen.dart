import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Trivia App')),
      body: Center(
        child: ElevatedButton(
          onPressed: () {
            // Navegar a la pantalla de juego
            Navigator.pushNamed(context, '/game');
          },
          child: Text('Bienvenido triviaventurero, comenzar Trivia'),
        ),
      ),
    );
  }
}
