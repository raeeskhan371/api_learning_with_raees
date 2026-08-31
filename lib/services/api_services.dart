import 'dart:convert';

import 'package:api_learning/models/UserModel.dart';
import 'package:api_learning/models/get_post_api.dart';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;

class ApiServices {
  List<GetPostModel> _getPostList = [];
  List<UserModel> _userList = [];
  List<UserModel> get userList => _userList;
  List<GetPostModel> get getPostList => _getPostList;

  Future<List<GetPostModel>> getPost() async {
    final Uri url = Uri.parse("https://jsonplaceholder.typicode.com/posts");

    final response = await http.get(url);
    var data = jsonDecode(response.body.toString());

    debugPrint("StatusCode: ${response.statusCode}");

    if (response.statusCode == 200) {
      for (var i in data) {
        _getPostList.add(GetPostModel.fromJson(i));
      }

      return _getPostList;
    }

    return _getPostList;
  }

  Future<List<UserModel>> getUser() async {
    final Uri url = Uri.parse("https://jsonplaceholder.typicode.com/users");
    final response = await http.get(url);
    final data = jsonDecode(response.body);

    return (data as List).map((e) => UserModel.fromJson(e)).toList();
  }
}
