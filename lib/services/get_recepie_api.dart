import 'dart:convert';

import 'package:api_learning/models/recepie_model.dart';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;

class GetRecepieApi {
  Future<RecepieModel> getRecepie() async {
    final Uri url = Uri.parse("https://dummyjson.com/recipes");

    final response = await http.get(url);
    final data = jsonDecode(response.body);
    debugPrint("Data=>>>>>>>>>>>  $data");

    if (response.statusCode == 200) {
      return RecepieModel.fromJson(data);
    }
    throw Exception("SomeThing Wrong");
  }
}
