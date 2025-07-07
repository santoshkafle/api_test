import 'package:api_test/models/todos_model.dart';
import 'package:api_test/services/todoservices.dart';
import 'package:flutter/material.dart';

class TodosProvider with ChangeNotifier {
  List<TodosModel> _todosModel = [];
  bool _isLoading = false;

  List<TodosModel> get todosModel => _todosModel;
  bool get isLoading => _isLoading;

  void initilizeTodos() async {
    _isLoading = true;
    notifyListeners();

    final newTodos = await Todoservices.getTodos();
    _todosModel = newTodos;
    _isLoading = false;
    notifyListeners();
  }

  void createTodos(TodosModel _todos) async {
    _isLoading = true;
    notifyListeners();

    await Todoservices.postTodosData(_todos);
    initilizeTodos();
  }

  void editTodos(TodosModel _todos) async {
    _isLoading = true;
    notifyListeners();

    await Todoservices.editTodosData(_todos);
    initilizeTodos();
  }

  void deleteTodos(String userId) async {
    _isLoading = true;
    notifyListeners();

    await Todoservices.deleteTodos(userId);
    initilizeTodos();
  }
}
