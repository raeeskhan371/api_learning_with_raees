import 'dart:convert';

import 'package:api_learning/models/books.model.dart';
import 'package:flutter/widgets.dart';
import 'package:http/http.dart' as http;

class GetBookApi {
  Future<BookModel> getBooks() async {
    final Uri url = Uri.parse("https://library-management-api-i6if.onrender.com/api/books");
    final response = await http.get(url);
    final data = jsonDecode(response.body);

    debugPrint("BookData: $data");
    debugPrint("Response StatusCode: $response");

    return BookModel.fromJson(data);
  }
}
