import 'package:flutter/material.dart';
import '../screens/home_screen.dart'; // Pantalla de inicio
import '../screens/game_screen.dart'; // Pantalla de juego
import '../screens/result_screen.dart'; // Pantalla de resultados

class BottomNavWrapper extends StatefulWidget {
  @override
  _BottomNavWrapperState createState() => _BottomNavWrapperState();
}

class _BottomNavWrapperState extends State<BottomNavWrapper> {
  int currentIndex = 0;
  int _score = 0; // Variable para almacenar el puntaje global

  late final List<Widget> _screens; // Declaramos la lista como "late"

  @override
  void initState() {
    super.initState();
    _screens = [
      HomeScreen(   changeIndex: changeIndex), // Pantalla de inicio
      GameScreen(
        changeIndex: changeIndex, // Pasamos el callback para cambiar el índice
        updateScore: updateScore, // Pasamos el callback para actualizar el puntaje
      ),
      ResultScreen(score: _score), // Pantalla de resultados con el puntaje actual
    ];
  }

  // Método para cambiar el índice del BottomNavigationBar
  void changeIndex(int index) {
    if (index == 2) {
      // Si navegamos a la pantalla de resultados, actualizamos la pantalla con el puntaje más reciente
      setState(() {
        _screens[2] = ResultScreen(score: _score);
        currentIndex = index;
      });
    } else {
      setState(() {
        currentIndex = index;
      });
    }
  }

  // Método para actualizar el puntaje global
  void updateScore(int score) {
    setState(() {
      _score = score;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _screens[currentIndex], // Mostramos la pantalla correspondiente al índice
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: currentIndex,
        onTap: (index) => changeIndex(index),
        selectedItemColor: Colors.teal,
        unselectedItemColor: Colors.grey,
        backgroundColor: Colors.white,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Inicio'),
          BottomNavigationBarItem(icon: Icon(Icons.quiz), label: 'Juego'),
          BottomNavigationBarItem(icon: Icon(Icons.leaderboard), label: 'Resultados'),
        ],
      ),
    );
  }
}