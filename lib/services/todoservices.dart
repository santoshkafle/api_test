import 'dart:convert';
import 'dart:developer';

import 'package:api_test/models/todos_model.dart';
import 'package:http/http.dart' as http;

class Todoservices {
  static const String url =
      "https://686a49482af1d945cea3ad03.mockapi.io/todo_notes_api/todos_tasks";
  static const header = {'Content-Type': 'application/json'};

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

  static Future<void> postTodosData(TodosModel todosModel) async {
    final data = await http.post(
      Uri.parse(url),
      headers: header,
      body: jsonEncode(todosModel.toJson()),
    );
    log(data.body);

    if (data.statusCode == 200) {
      log("Data inserted!");
    } else {
      log(data.statusCode.toString());
    }
  }

  static Future<void> editTodosData(TodosModel todosModel) async {
    final _url =
        "https://686a49482af1d945cea3ad03.mockapi.io/todo_notes_api/todos_tasks/${todosModel.userId}";
    final data = await http.put(
      Uri.parse(_url),
      headers: header,
      body: jsonEncode(todosModel.toJson()),
    );
    log(data.body);

    if (data.statusCode == 200) {
      log("Data inserted!");
    } else {
      log(data.statusCode.toString());
    }
  }

  static Future<void> deleteTodos(String todoId) async {
    final _url =
        "https://686a49482af1d945cea3ad03.mockapi.io/todo_notes_api/todos_tasks/$todoId";
    final respon = await http.delete(Uri.parse(_url));

    try {
      if (respon.statusCode == 200) {
        log("deleted ok");
      } else {
        throw Exception("fail to delete?");
      }
    } catch (e) {
      log(e.toString());
    }
  }
}

//https://jsonplaceholder.typicode.com/todos
