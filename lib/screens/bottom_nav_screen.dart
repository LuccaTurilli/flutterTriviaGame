import 'package:flutter/material.dart';
import '../screens/home_screen.dart'; // Importamos la pantalla de inicio
import '../screens/game_screen.dart'; // Importamos la pantalla de juego
import '../screens/result_screen.dart'; // Importamos la pantalla de resultados

class BottomNavScreen extends StatefulWidget {
  @override
  _BottomNavScreenState createState() => _BottomNavScreenState();
}

class _BottomNavScreenState extends State<BottomNavScreen> {
  // Índice actual del BottomNavigationBar
  int _currentIndex = 0;

  // Lista de pantallas disponibles
  final List<Widget> _screens = [
    HomeScreen(), // Pantalla de inicio
    GameScreen(), // Pantalla de juego
    ResultScreen(score: 0), // Pantalla de resultados (puedes pasar un puntaje inicial)
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _screens[_currentIndex], // Mostramos la pantalla correspondiente al índice
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex, // Índice actual
        onTap: (index) {
          setState(() {
            _currentIndex = index; // Actualizamos el índice cuando se selecciona un ícono
          });
        },
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Inicio', // Texto para el ícono de inicio
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.quiz),
            label: 'Juego', // Texto para el ícono de juego
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.leaderboard),
            label: 'Resultados', // Texto para el ícono de resultados
          ),
        ],
      ),
    );
  }
}