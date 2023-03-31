import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:intl/intl.dart';
import 'package:todo_list/models/todo.dart';

class TodoListItem extends StatelessWidget {
  const TodoListItem({super.key, required this.todo});

  final Todo todo;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 3),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(5),
        color: Colors.grey[200],
      ),
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            DateFormat('dd/MM/yyyy HH:mm').format(todo.dateTime),
            style: TextStyle(
              fontSize: 12,
            ),
          ),
          Text(
            todo.title,
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 16,
            ),
          ),
        ],
      ),
    );
  }
  
}
