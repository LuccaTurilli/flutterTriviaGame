import 'package:flutter/material.dart';

/// Widget personalizado para mostrar un menú desplegable de categorías.
/// Este widget es reutilizable y puede ser usado en cualquier pantalla.
class CategoryDropdown extends StatefulWidget {
  /// Valor inicial seleccionado en el DropdownButton.
  /// Si no se proporciona, se usa el valor predeterminado '9' (General Knowledge).
  final String? initialValue;

  /// Callback que se ejecuta cuando el usuario selecciona una categoría.
  /// Permite notificar al padre del cambio de selección.
  final Function(String?) onChanged;

  /// Constructor del widget.
  /// Requiere un callback `onChanged` para manejar los cambios de selección.
  const CategoryDropdown({
    Key? key,
    this.initialValue,
    required this.onChanged,
  }) : super(key: key);

  @override
  _CategoryDropdownState createState() => _CategoryDropdownState();
}

class _CategoryDropdownState extends State<CategoryDropdown> {
  /// Mapa de categorías donde las claves son los IDs de las categorías
  /// y los valores son los nombres legibles para el usuario.
  static const Map<String, String> categories = {
    '9': 'General Knowledge',
    '10': 'Entertainment: Books',
    '11': 'Entertainment: Film',
    '12': 'Entertainment: Music',
    '13': 'Entertainment: Musicals & Theatres',
    '14': 'Entertainment: Television',
    '15': 'Entertainment: Video Games',
    '16': 'Entertainment: Board Games',
    '17': 'Science & Nature',
    '18': 'Science: Computers',
    '19': 'Science: Mathematics',
    '20': 'Mythology',
    '21': 'Sports',
    '22': 'Geography',
    '23': 'History',
    '24': 'Politics',
    '25': 'Art',
    '26': 'Celebrities',
    '27': 'Animals',
    '28': 'Vehicles',
    '29': 'Entertainment: Comics',
    '30': 'Science: Gadgets',
    '31': 'Entertainment: Japanese Anime & Manga',
    '32': 'Entertainment: Cartoon & Animations',
  };

  /// Variable para almacenar la categoría seleccionada actualmente.
  late String? selectedCategory;

  /// Método que se ejecuta cuando se inicializa el widget.
  /// Establece el valor inicial de `selectedCategory`.
  @override
  void initState() {
    super.initState();
    selectedCategory = widget.initialValue ?? '9'; // Usa el valor inicial o '9' como predeterminado.
  }

  @override
  Widget build(BuildContext context) {
    return DropdownButton<String>(
      // Valor seleccionado actualmente en el DropdownButton.
      value: selectedCategory,

      // Icono que se muestra al lado del DropdownButton.
      icon: const Icon(Icons.arrow_downward),

      // Elevación (sombra) del menú desplegable.
      elevation: 16,

      // Estilo del texto dentro del DropdownButton.
      style: const TextStyle(color: Colors.deepPurple),

      // Línea subrayada debajo del DropdownButton.
      underline: Container(height: 2, color: Colors.deepPurpleAccent),

      // Callback que se ejecuta cuando el usuario selecciona una opción.
      onChanged: (String? value) {
        setState(() {
          selectedCategory = value; // Actualizamos la categoría seleccionada.
        });
        widget.onChanged(value); // Notificamos al padre del cambio.
      },

      // Lista de opciones del DropdownButton.
      // Convertimos el mapa `categories` en una lista de `DropdownMenuItem`.
      items: categories.keys.map((key) {
        return DropdownMenuItem<String>(
          value: key, // El valor que se guardará al seleccionar (la clave del mapa).
          child: Text(categories[key]!), // El texto que se muestra en el menú (el valor del mapa).
        );
      }).toList(),
    );
  }
}