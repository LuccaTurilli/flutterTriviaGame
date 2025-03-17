import 'package:flutter/material.dart';
import 'package:provider/provider.dart'; // Importa el paquete provider
import 'screens/bottom_nav_wrapper.dart'; // Importa el wrapper principal
import 'providers/question_provider.dart'; // Importa el QuestionProvider
import 'providers/nav_provider.dart'; // Importa otros providers si los tienes

//import 'helpers/shared_preferences_helper.dart'; // Importa la clase helper




void main() {
  WidgetsFlutterBinding.ensureInitialized(); // Necesario para usar async en main
 // await SharedPreferencesHelper().init(); // Inicializa SharedPreferences

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => NavProvider()),
        ChangeNotifierProvider(create: (_) => QuestionProvider()), // Asegúrate de incluir QuestionProvider
      ],
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Trivia App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: BottomNavWrapper(), // El wrapper principal que contiene las pantallas
    );
  }
}