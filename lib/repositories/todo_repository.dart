import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:todo_list/models/todo.dart';

const todoListKey = 'todoList';

class TodoRepository {
  late SharedPreferences sharedPreferences;

  void saveTodoList(List<Todo> todos) {
    sharedPreferences.setString(todoListKey, json.encode(todos));
  }

  // Recebe os dados salvos em sessões anteriores do app
  Future<List<Todo>> getTodoList() async {
    // Instanciando sharedPreferences
    sharedPreferences = await SharedPreferences.getInstance();
    // Recebendo o json na forma de string da lista de tarefas, caso não exista, o valor padrão é '[]'
    final String jsonString = sharedPreferences.getString(todoListKey) ?? '[]';
    // Transforma a string do json em uma lista simples
    final List jsonDecoded = json.decode(jsonString) as List;
    // Transforma cada elemento da lista em um objeto da classe Todo
    return jsonDecoded.map((e) => Todo.fromJson(e)).toList();
  }
}
