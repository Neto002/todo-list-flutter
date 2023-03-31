import 'package:flutter/material.dart';
import 'package:todo_list/models/todo.dart';
import 'package:todo_list/widgets/todo_list_item.dart';

class TodoListPage extends StatefulWidget {
  TodoListPage({Key? key}) : super(key: key);

  @override
  State<TodoListPage> createState() => _TodoListPageState();
}

class _TodoListPageState extends State<TodoListPage> {
  List<Todo> todos = [];

  final TextEditingController todoController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Center(
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Row(
                  children: [
                    Expanded(
                      child: TextField(
                        controller: todoController,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(),
                          labelText: "Adicione uma tarefa",
                        ),
                      ),
                    ),
                    const SizedBox(
                      width: 8,
                    ),
                    ElevatedButton(
                      onPressed: () {
                        String text = todoController.text;
                        setState(() {
                          if (todoController.text.isNotEmpty) {
                            Todo newTodo =
                                Todo(title: text, dateTime: DateTime.now());
                            todos.add(newTodo);
                            todoController.clear();
                          }
                        });
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.purple,
                        padding: const EdgeInsets.symmetric(
                            vertical: 18, horizontal: 18),
                      ),
                      child: const Icon(
                        Icons.add,
                        size: 23,
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 16,
                ),
                Flexible(
                  child: ListView(
                    shrinkWrap: true,
                    children: [
                      for (Todo todo in todos)
                        TodoListItem(
                          todo: todo,
                        ),
                    ],
                  ),
                ),
                Row(
                  children: [
                    Expanded(
                        child: Text(
                      "Você possui ${todos.length} tarefas pendentes",
                    )),
                    const SizedBox(
                      width: 8,
                    ),
                    ElevatedButton(
                      onPressed: () {
                        setState(() {
                          todos.clear();
                        });
                      },
                      style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.purple,
                          padding: const EdgeInsets.all(18)),
                      child: const Text("Limpar tudo"),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
