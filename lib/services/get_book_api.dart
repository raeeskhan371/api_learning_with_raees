import 'dart:convert';

import 'package:api_learning/models/books.model.dart';
import 'package:flutter/widgets.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class GetBookApi {
  Future<BookModel> getBooks() async {
    final Uri url = Uri.parse("https://library-management-api-i6if.onrender.com/api/books");
    final response = await http.get(url);
    final data = jsonDecode(response.body);

    debugPrint("BookData: $data");
    debugPrint("Response StatusCode: $response");

    return BookModel.fromJson(data);
  }

  Future<void> addUser({
    required String fullName,
    required String email,
    required String password,
  }) async {
    final Uri url = Uri.parse(
      "https://library-management-api-i6if.onrender.com/api/users/register",
    );

    final response = await http.post(
      url,
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({'fullname': fullName, 'email': email, 'password': password}),
    );

    print('Status Code: ${response.statusCode}');
    print('Response: ${response.body}');

    if (response.statusCode >= 200 || response.statusCode < 300) {
      print("User Add SucessFully");
    }
  }

  Future<void> loginUser({required String email, required String password}) async {
    final Uri url = Uri.parse("https://library-management-api-i6if.onrender.com/api/users/login");
    final response = await http.post(
      url,
      headers: {"Content-Type": "application/json"},
      body: jsonEncode({"email": email, "password": password}),
    );

    print("Status Code:${response.statusCode}");
    print("Response:${response.body}");

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      final token = data["token"];
      final prefs = await SharedPreferences.getInstance();

      await prefs.setString("token", token);
      print('Login successful');
      print('Token saved: $token');
    } else {
      throw Exception("Login failed: ${response.body}");
    }
  }

  Future<void> checkToken() async {
    final prefs = await SharedPreferences.getInstance();
    final Uri url = Uri.parse("https://library-management-api-i6if.onrender.com/api/users");
    final token = await prefs.getString("token");
    final response = await http.get(url, headers: {"Authorization": "Bearer $token"});

    if (response.statusCode >= 200 || response.statusCode < 300) {
      final data = jsonDecode(response.body);
      print("User fecthed Successfully");
      print(data);
    } else {
      throw Exception("Error During fecthing:${response.body}");
    }
  }

  static Future<bool> checkSession() async {
    debugPrint("i checksession function start....");
    final prefs = await SharedPreferences.getInstance();
    final Uri url = Uri.parse("https://library-management-api-i6if.onrender.com/api/users");

    final token = prefs.getString("token");
    debugPrint("i checksession function GetTokenStage: $token");

    final response = await http.get(url, headers: {"Authorization": "Bearer $token"});

    debugPrint("i checksession function ResposneTrackingCode:${response.statusCode}");

    if (token == null || token.isEmpty) {
      debugPrint("i checksession function CheckingTokenStage: $token");
      return false;
    }

    if (response.statusCode == 200) {
      debugPrint("i checksession function TokenStage: Pass");
      return true;
    }

    prefs.remove("token");
    debugPrint("i checksession function TokenStage: Token Remove From Local List");
    debugPrint("i checksession function end....");
    return false;
  }
}
