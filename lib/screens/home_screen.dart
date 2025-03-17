import 'package:flutter/material.dart';
import 'package:provider/provider.dart'; // Importamos el paquete provider
import '../providers/question_provider.dart'; // Importamos el QuestionProvider
import '../services/trivia_service.dart'; // Importamos el servicio para conectarse a la API
import '../items/dropdown_button.dart'; // Importamos el widget personalizado CategoryDropdown
import '../items/fade_in_left.dart';



/// Pantalla de inicio de la aplicación.
/// Permite al usuario seleccionar una categoría y comenzar el juego.
class HomeScreen extends StatefulWidget {
  /// Callback para cambiar el índice del BottomNavigationBar.
  final Function(int) changeIndex;

  const HomeScreen({required this.changeIndex});

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  /// Categoría seleccionada por el usuario.
  String? selectedCategory = '9'; // Valor predeterminado: General Knowledge (ID: 9)




  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Inicio'), // Título de la pantalla
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center, // Centrar los elementos verticalmente
          children: [
            //imagen
FadeInLeft(
  duration: const Duration(seconds: 2), // Duración personalizada
  offset: 200.0, // Desplazamiento personalizado
  curve: Curves.easeInOut, // Curva personalizada
  child: Image.asset(
  '../assets/imagenes/welcome.png',

    width: 300,
    height: 300,
  ),
),

Text('Bienvenido!!', style: TextStyle(fontSize: 24)), // Texto de bienvenida
       
            SizedBox(height: 20), // Espacio entre la imagen y el Dropdown

            // Widget personalizado para seleccionar una categoría
            CategoryDropdown(
              initialValue: selectedCategory, // Valor inicial seleccionado
              onChanged: (String? value) {
                setState(() {
                  selectedCategory = value; // Actualizar la categoría seleccionada
                  print("Categoría seleccionada: $selectedCategory");
                });
              },
            ),
            SizedBox(height: 20), // Espacio entre el Dropdown y el botón

            // Botón para comenzar el juego
            ElevatedButton(
              onPressed: () async {
                // Verificar si el usuario ha seleccionado una categoría
                if (selectedCategory == null) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('Por favor, selecciona una categoría.')),
                  );
                  return;
                }

                // Crear una instancia del servicio TriviaService
                final triviaService = TriviaService();

                try {
                  // Cargar preguntas desde la API usando la categoría seleccionada
                  final fetchedQuestions = await triviaService.fetchQuestions(
                    amount: 5, // Cargar 5 preguntas
                    category: selectedCategory!, // Usar la categoría seleccionada
                  );

                  // Guardar las preguntas en el QuestionProvider
                  final questionProvider =
                      Provider.of<QuestionProvider>(context, listen: false);
                  questionProvider.setQuestions(fetchedQuestions);

                  // Navegar a la pantalla de juego (índice 1)
                  widget.changeIndex(1);
                } catch (e) {
                  // Manejar errores al cargar las preguntas
                  print('Error al cargar las preguntas: $e');
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('Error al cargar las preguntas.')),
                  );
                }
              },
              child: Text('Comenzar Trivia'), // Texto del botón
            ),
          ],
        ),
      ),
    );
  }
}