import 'package:flutter/material.dart';

/// Flutter code sample for [DropdownButton].

const List<String> list = <String>['One', 'Two', 'Three', 'Four'];

const Map<String, String> categories = {

  
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
 '28':  'Vehicles',
  '29': 'Entertainment: Comics',
 '30':  'Science: Gadgets',
 '31':  'Entertainment: Japanese Anime & Manga',
 '32':  'Entertainment: Cartoon & Animations',
};

  // Convertir los valores del mapa en una lista
 // List<String> categoriesList = categories.values.toList();

    List<DropdownMenuItem<String>> dropdownItems = categories.entries.map((entry) {
      return DropdownMenuItem<String>(
        value: entry.value, // El valor que se guardará al seleccionar
        child: Text(entry.value), // Lo que se muestra en el menú
      );
    }).toList();

void main() => runApp(const DropdownButtonApp());

class DropdownButtonApp extends StatelessWidget {
  const DropdownButtonApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(title: const Text('DropdownButton Sample')),
        body: const Center(child: DropdownButtonExample()),
      ),
    );
  }
}

class DropdownButtonExample extends StatefulWidget {
  const DropdownButtonExample({super.key});

  @override
  State<DropdownButtonExample> createState() => _DropdownButtonExampleState();
}

class _DropdownButtonExampleState extends State<DropdownButtonExample> {
  String? dropdownValue = categories['9']; //list.first;

  @override
  Widget build(BuildContext context) {
    return DropdownButton<String>(
      value: dropdownValue,
      icon: const Icon(Icons.arrow_downward),
      elevation: 16,
      style: const TextStyle(color: Colors.deepPurple),
      underline: Container(height: 2, color: Colors.deepPurpleAccent),
      onChanged: (String? value) {
        // This is called when the user selects an item.
        setState(() {
          dropdownValue = value!;
          print(dropdownValue);
        });
      },
      items:
          dropdownItems,
    );
  }
}
