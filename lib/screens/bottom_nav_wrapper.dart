import 'package:flutter/material.dart';
import 'package:provider/provider.dart'; // Importa el paquete provider
import '../screens/home_screen.dart';
import '../screens/game_screen.dart';
import '../screens/results_screen.dart';
import '../providers/nav_provider.dart'; // Importa el NavProvider

class BottomNavWrapper extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // Acceder al NavProvider usando Provider.of
    final navProvider = Provider.of<NavProvider>(context);

    // Definir las pantallas disponibles
    final List<Widget> _screens = [
      HomeScreen(changeIndex: navProvider.changeIndex), // Pasar el callback para cambiar el índice
      GameScreen(changeIndex: navProvider.changeIndex),
      ResultsScreen(),
    ];

    return Scaffold(
      body: _screens[navProvider.currentIndex], // Mostrar la pantalla correspondiente al índice
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: navProvider.currentIndex, // Usar el índice del provider
        onTap: (index) => navProvider.changeIndex(index), // Actualizar el índice al hacer clic
        selectedItemColor: Colors.teal,
        unselectedItemColor: Colors.grey,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Inicio'),
          BottomNavigationBarItem(icon: Icon(Icons.quiz), label: 'Juego'),
          BottomNavigationBarItem(icon: Icon(Icons.leaderboard), label: 'Resultados'),
        ],
      ),
    );
  }
}