import 'package:api_learning/screens/Main_Home_Screen.dart';
import 'package:api_learning/screens/login_screen.dart';
import 'package:api_learning/services/get_book_api.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class AuthGate extends StatelessWidget {
  new({super.key});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: GetBookApi.checkSession(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(child: CircularProgressIndicator(color: Colors.blue));
        }
        if (!snapshot.hasData) {
          return Center(child: Text("Something wrong!"));
        }
        if (snapshot.hasError) {
          return Center(child: Text("${snapshot.error}"));
        }
        if (snapshot.data == true) {
          return MainHomeScreen();
        }
        return LoginScreen();
      },
    );
  }
}
