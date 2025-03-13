import 'package:flutter/material.dart';
import '../items/DropdownButton.dart';

class HomeScreen extends StatelessWidget {
  final Function(int) changeIndex;

  const HomeScreen({
    super.key,
    required this.changeIndex,
  }); // Callback para cambiar el índice del BottomNavigationBar

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Trivia App')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Center(
              child: ElevatedButton(
                onPressed: () {
                  changeIndex(1); // Cambiamos al índice 1 (pantalla de juego)
                },
                child: Text(
                  'Bienvenido triviaventurero elije una categoría, para comenzar con la trivia',
                ),
              ),
            ),
            DropdownButtonExample(),

            OutlinedButton(onPressed: () {}, child: const Text('Siguiente')),
          ],
        ),
      ),
    );
  }
}
