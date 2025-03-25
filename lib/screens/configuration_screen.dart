import 'dart:async';

import 'package:flutter/material.dart';
import 'ConfigurationScreenItems/text_field_name.dart';
import 'package:hive/hive.dart';
import '../models/user.dart';  // Importa el modelo User
void main() {
  runApp(ConfigurationScreen());
}

class ConfigurationScreen extends StatefulWidget {
  @override
  State<ConfigurationScreen> createState() => _ConfigurationScreenState();
}

class _ConfigurationScreenState extends State<ConfigurationScreen> {
  @override
  Widget build(BuildContext context) {
  String _displayText = '';
                var box = Hive.box<User>('users');
                User? user = box.get('user1');


  void _limpiar() {
    setState(() {
      _displayText = '';
    });
  }



    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Wizard'),
        ),
        body: Column(
          children: [
            MyTextField(
              onChanged: (text) {
                  _displayText = text;
                  print(" $text");
              },
              onSubmitted: (text) {
                  _displayText = text;
              },
            ),
             
                    ElevatedButton(
              onPressed: _limpiar,
              child: Text('Limpiar Label'),
            ),
             
             ElevatedButton(
              onPressed: () {
                
                var box = Hive.box<User>('users');
                box.put('user1', User(  _displayText , 25));
                print('Usuario guardado $_displayText');

      

                if (user != null) {
                  print('Nombre: ${user.name}, Edad: ${user.age}');
                } else {
                  print('Usuario no encontrado');
                }

              },
              child: Text('Guardar Usuario'),
              
            ), Text('Bienvenido,   ${user?.name} '),
          ],
        ),
      ),
    );
  }
}