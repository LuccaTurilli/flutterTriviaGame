import 'package:flutter/material.dart';

/// Provider para gestionar el índice del BottomNavigationBar.
class NavProvider with ChangeNotifier {
  /// Índice de la pantalla actual.
  int _currentIndex = 0;

  /// Getter para obtener el índice actual.
  int get currentIndex => _currentIndex;

  /// Método para cambiar el índice actual.
  void changeIndex(int index) {
    if (_currentIndex != index) {
      _currentIndex = index; // Actualizar el índice
      notifyListeners(); // Notificar a los widgets que escuchan este provider
    }
  }
}