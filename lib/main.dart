import 'package:flutter/material.dart';
import 'package:provider/provider.dart'; // Importa el paquete provider
import 'screens/bottom_nav_wrapper.dart'; // Importa el wrapper principal
import 'providers/question_provider.dart'; // Importa el QuestionProvider
import 'providers/nav_provider.dart'; // Importa otros providers si los tienes
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';

import 'models/user.dart';  // Importa el modelo User
//import 'helpers/shared_preferences_helper.dart'; // Importa la clase helper


void main() async {
  WidgetsFlutterBinding.ensureInitialized(); // Necesario para usar async en main
 // await SharedPreferencesHelper().init(); // Inicializa SharedPreferences
  await Hive.initFlutter(); // Inicializa Hive con soporte para Flutter
  await Hive.openBox('myBox'); // Abre una "box" (similar a una tabla en SQL)
 
 //registrando HIVE user para guardar datos del usuario
  Hive.registerAdapter(UserAdapter());  // Registra el adaptador
  await Hive.openBox<User>('users');   // Abre una box para el modelo User
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