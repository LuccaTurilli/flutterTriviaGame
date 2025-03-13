import 'package:flutter/material.dart';

class ResultScreen extends StatelessWidget {
  final int score;
  final Function(int) changeIndex;
  const ResultScreen({
    super.key,
    required this.score,
    required this.changeIndex,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Resultados')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Tu puntaje: $score',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                //  Navigator.popUntil(context, ModalRoute.withName('/'));
                changeIndex(1);
              },
              child: Text('Volver al Inicio'),
            ),
          ],
        ),
      ),
    );
  }
}
