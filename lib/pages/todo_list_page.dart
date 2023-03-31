import 'package:flutter/material.dart';
import 'package:todo_list/models/todo.dart';
import 'package:todo_list/repositories/todo_repository.dart';
import 'package:todo_list/widgets/todo_list_item.dart';

class TodoListPage extends StatefulWidget {
  const TodoListPage({Key? key}) : super(key: key);

  @override
  State<TodoListPage> createState() => _TodoListPageState();
}

class _TodoListPageState extends State<TodoListPage> {
  final TextEditingController todoController = TextEditingController();
  final TodoRepository todoRepository = TodoRepository();

  List<Todo> todos = [];
  Todo? deletedTodo;
  int? deletedTodoPosition;
  String? errorText;

  @override
  void initState() {
    super.initState();

    todoRepository.getTodoList().then((value) {
      setState(() {
        todos = value;
      });
    });
  }

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
                        cursorColor: Colors.purple,
                        decoration: InputDecoration(
                          border: const OutlineInputBorder(),
                          labelText: "Adicione uma tarefa",
                          focusedBorder: const OutlineInputBorder(
                            borderSide: BorderSide(
                              color: Colors.purple,
                            ),
                          ),
                          labelStyle: const TextStyle(
                            color: Colors.purple,
                          ),
                          errorText: errorText,
                        ),
                      ),
                    ),
                    const SizedBox(
                      width: 8,
                    ),
                    ElevatedButton(
                      onPressed: () {
                        String text = todoController.text;
                        if (todoController.text.isNotEmpty) {
                          setState(() {
                            Todo newTodo = Todo(
                              title: text,
                              dateTime: DateTime.now(),
                            );
                            todos.add(newTodo);
                            errorText = null;
                          });
                          todoController.clear();
                          todoRepository.saveTodoList(todos);
                        } else {
                          setState(() {
                            errorText = "O título não pode ser vazio!";
                          });
                          return;
                        }
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
    todoRepository.saveTodoList(todos);
  }

  void onDelete(Todo todo) {
    deletedTodo = todo;
    deletedTodoPosition = todos.indexOf(todo);

    setState(() {
      todos.remove(todo);
    });
    todoRepository.saveTodoList(todos);

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
            todoRepository.saveTodoList(todos);
          },
        ),
        duration: const Duration(seconds: 5),
      ),
    );
  }

  void onEdit(Todo todo) {
    if (todoController.text.isNotEmpty) {
      int todoEditIndex = todos.indexOf(todo);
      setState(() {
        todos[todoEditIndex].title = todoController.text;
        todos[todoEditIndex].dateTime = DateTime.now();
        todoController.clear();
      });
      todoRepository.saveTodoList(todos);
    } else {
      ScaffoldMessenger.of(context).clearSnackBars();
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text(
            "Digite o novo nome da tarefa no campo \"Adicione uma tarefa\"",
            style: TextStyle(
              color: Color(0xff060708),
            ),
          ),
          backgroundColor: Colors.white,
          duration: Duration(seconds: 5),
        ),
      );
    }
  }
}
