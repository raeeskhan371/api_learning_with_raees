import 'dart:convert';

import 'package:api_learning/models/product_model.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class GetApiServices {
  Future<ProductModel> getProdcut() async {
    final Uri url = Uri.parse("https://dummyjson.com/products");

    final response = await http.get(url);
    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);

      debugPrint("Data:>>>>>>>> $data");
      return ProductModel.fromJson(data);
    }
    throw Exception("Failed to fetch products");
  }
}
