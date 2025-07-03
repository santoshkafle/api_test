import 'dart:convert';
import 'dart:developer';

import 'package:api_test/models/todos_model.dart';
import 'package:http/http.dart' as http;

class Todoservices {
  static const String url =
      "https://6866622d89803950dbb27925.mockapi.io/ap1/v1/GroceryItems";
  static Future<List<TodosModel>> getTodos() async {
    final respon = await http.get(Uri.parse(url));
    final data = jsonDecode(respon.body) as List<dynamic>;

    try {
      if (respon.statusCode == 200) {
        return data.map((e) => TodosModel.formJson(e)).toList() ?? [];
      } else {
        throw Exception("no data to show");
      }
    } catch (e) {
      log(e.toString());
      return [];
    }
  }
}
