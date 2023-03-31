import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:todo_list/models/todo.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

class TodoListItem extends StatelessWidget {
  const TodoListItem({
    super.key,
    required this.todo,
    required this.onDelete,
    required this.onEdit,
  });

  final Todo todo;

  final Function(Todo) onDelete;
  final Function(Todo) onEdit;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 3),
      child: Slidable(
        endActionPane: ActionPane(
          motion: const DrawerMotion(),
          extentRatio: 0.5,
          children: [
            SlidableAction(
              label: "Excluir",
              backgroundColor: Colors.red,
              icon: Icons.delete,
              borderRadius: BorderRadius.circular(2),
              onPressed: (buildContext) {
                onDelete(todo);
              },
            ),
            SlidableAction(
              label: "Editar",
              backgroundColor: Colors.blue,
              icon: Icons.edit,
              borderRadius: BorderRadius.circular(2),
              onPressed: (buildContext) {
                onEdit(todo);
              },
            ),
          ],
        ),
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(5),
            color: Colors.grey[200],
          ),
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text(
                DateFormat('dd/MM/yyyy HH:mm').format(todo.dateTime),
                style: const TextStyle(
                  fontSize: 12,
                ),
              ),
              Text(
                todo.title,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
