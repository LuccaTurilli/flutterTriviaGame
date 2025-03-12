

import 'package:flutter/material.dart';

class SnackBarAnswer extends StatelessWidget {
    const SnackBarAnswer({
      super.key,
      required this.isCorrect,
    });
  
    final bool isCorrect;
  
    @override
    Widget build(BuildContext context) {
      return SnackBar(
        content: Text(
          isCorrect ? '¡Respuesta Correcta!' : 'Respuesta Incorrecta',
        ),
        backgroundColor: isCorrect ? Colors.green : Colors.red,
        duration: Duration(seconds: 1),
      );
    }
  }
  