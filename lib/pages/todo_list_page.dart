import 'package:flutter/material.dart';
import 'package:todo_list/models/todo.dart';
import 'package:todo_list/widgets/todo_list_item.dart';

class TodoListPage extends StatefulWidget {
  const TodoListPage({Key? key}) : super(key: key);

  @override
  State<TodoListPage> createState() => _TodoListPageState();
}

class _TodoListPageState extends State<TodoListPage> {
  List<Todo> todos = [];
  Todo? deletedTodo;
  int? deletedTodoPosition;

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
                        decoration: const InputDecoration(
                          border: OutlineInputBorder(),
                          labelText: "Adicione uma tarefa",
                          hoverColor: Colors.purple,
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
                          onDelete: onDelete,
                          onEdit: onEdit,
                        ),
                    ],
                  ),
                ),
                Padding(
                    padding: const EdgeInsets.symmetric(vertical: 3),
                    child: Row(
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
                            showDeleteTodosConfirmationDialog();
                          },
                          style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.purple,
                              padding: const EdgeInsets.all(18)),
                          child: const Text("Limpar tudo"),
                        ),
                      ],
                    )),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void showDeleteTodosConfirmationDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text("Limpar Tudo?"),
        content: const Text("Tem certeza que deseja excluir todas as tarefas?"),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: const Text(
              "Cancelar",
              style: TextStyle(
                color: Colors.purple,
              ),
            ),
          ),
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
              onClearAll();
            },
            child: const Text(
              "Limpar Tudo",
              style: TextStyle(
                color: Colors.red,
              ),
            ),
          ),
        ],
      ),
    );
  }

  void onClearAll() {
    setState(() {
      todos.clear();
    });
  }

  void onDelete(Todo todo) {
    deletedTodo = todo;
    deletedTodoPosition = todos.indexOf(todo);

    setState(() {
      todos.remove(todo);
    });

    ScaffoldMessenger.of(context).clearSnackBars();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          "Tarefa ${todo.title} removida com sucesso!",
          style: const TextStyle(
            color: Color(0xff060708),
          ),
        ),
        backgroundColor: Colors.white,
        action: SnackBarAction(
          label: 'Desfazer',
          textColor: Colors.purple,
          onPressed: () {
            setState(() {
              todos.insert(deletedTodoPosition!, deletedTodo!);
            });
          },
        ),
        duration: const Duration(seconds: 5),
      ),
    );
  }

  void onEdit(Todo todo) {
    int todoEditIndex = todos.indexOf(todo);
    setState(() {
      todos[todoEditIndex].title = todoController.text;
      todos[todoEditIndex].dateTime = DateTime.now();
      todoController.clear();
    });
  }
}
