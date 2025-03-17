import 'package:flutter/material.dart';

/// Widget que anima un [child] para que aparezca con un efecto de fade-in desde la izquierda.
class FadeInLeft extends StatefulWidget {
  final Widget child; // Widget que se animará (puede ser una imagen, texto, etc.)
  final Duration duration; // Duración de la animación
  final double offset; // Distancia de desplazamiento inicial desde la izquierda
  final Curve curve; // Curva de animación (por ejemplo, easeOut, easeInOut, etc.)

  /// Constructor de la clase [FadeInLeft].
  const FadeInLeft({
    super.key,
    required this.child, // Widget hijo obligatorio
    this.duration = const Duration(seconds: 2), // Duración predeterminada: 2 segundos
    this.offset = 100.0, // Desplazamiento predeterminado: 100 píxeles
    this.curve = Curves.easeOut, // Curva predeterminada: easeOut
  });

  @override
  State<FadeInLeft> createState() => _FadeInLeftState();
}

/// Estado de la clase [FadeInLeft].
class _FadeInLeftState extends State<FadeInLeft> 
    with SingleTickerProviderStateMixin { // Necesario para usar AnimationController
  late AnimationController _controller; // Controlador de la animación
  late Animation<double> _opacityAnimation; // Animación de opacidad
  late Animation<double> _translateAnimation; // Animación de desplazamiento horizontal

  @override
  void initState() {
    super.initState();

    // Inicializa el AnimationController con la duración proporcionada.
    _controller = AnimationController(
      vsync: this, // Necesario para sincronizar la animación con los fotogramas
      duration: widget.duration, // Usa la duración proporcionada
    );

    // Configura la animación de opacidad.
    // La opacidad varía de 0.0 (invisible) a 1.0 (completamente visible).
    _opacityAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _controller, // Asocia la animación al controlador
        curve: widget.curve, // Usa la curva proporcionada
      ),
    );

    // Configura la animación de desplazamiento horizontal.
    // El desplazamiento varía desde un valor negativo (fuera de la pantalla a la izquierda)
    // hasta 0.0 (posición original).
    _translateAnimation = Tween<double>(
      begin: -widget.offset, // Desplazamiento inicial (fuera de la pantalla)
      end: 0.0, // Desplazamiento final (posición original)
    ).animate(
      CurvedAnimation(
        parent: _controller, // Asocia la animación al controlador
        curve: widget.curve, // Usa la curva proporcionada
      ),
    );

    // Inicia la animación cuando el widget se construye.
    _controller.forward();
  }

  @override
  void dispose() {
    // Libera los recursos del AnimationController cuando el widget se elimina.
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // Usa AnimatedBuilder para reconstruir el widget cuando la animación avanza.
    return AnimatedBuilder(
      animation: _controller, // Asocia el builder al controlador
      builder: (context, child) {
        return Opacity(
          opacity: _opacityAnimation.value, // Controla la opacidad del widget
          child: Transform.translate(
            offset: Offset(_translateAnimation.value, 0), // Controla el desplazamiento horizontal
            child: widget.child, // Muestra el widget hijo (imagen, texto, etc.)
          ),
        );
      },
    );
  }
}