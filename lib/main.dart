import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:truco/paginas/salas.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(AppTruco());
}

class AppTruco extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Jogo de Truco',
      theme: ThemeData.light().copyWith(
        primaryColor: Colors.green[900],
        accentColor: Colors.green[900],
      ),
      darkTheme: ThemeData.dark(),
      home: Salas(),
    );
  }
}
