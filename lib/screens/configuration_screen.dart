import 'package:flutter/material.dart';
import 'ConfigurationScreenItems/text_field_name.dart';

void main() {
  runApp(ConfigurationScreen());
}

class ConfigurationScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Wizard'),
        ),
        body: Column(
          children: [
            MyTextField(
              onChanged: (text) {
                print('Texto cambiado: $text');
              },
              onSubmitted: (text) {
                print('Texto enviado: $text');
              },
            ),
          ],
        ),
      ),
    );
  }
}