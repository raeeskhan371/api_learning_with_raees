import 'package:api_learning/screens/Main_Home_Screen.dart';
import 'package:api_learning/screens/authgate.dart';
import 'package:api_learning/screens/recepie.dart';
import 'package:api_learning/screens/recepie_detail_screen.dart';
import 'package:api_learning/screens/singup_screen.dart';
import 'package:api_learning/services/get_book_api.dart';
import 'package:flutter/material.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(colorScheme: .fromSeed(seedColor: Colors.deepPurple)),
      home: AuthGate(),
    );
  }
}
