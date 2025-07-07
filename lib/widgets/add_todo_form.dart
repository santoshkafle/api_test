import 'package:api_test/models/todos_model.dart';
import 'package:api_test/provider/todos_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AddTodoForm extends StatefulWidget {
  const AddTodoForm({super.key});

  @override
  State<AddTodoForm> createState() => _AddTodoFormState();
}

class _AddTodoFormState extends State<AddTodoForm> {
  final TextEditingController _titleController = TextEditingController();
  bool isCompleted = false;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text('Add Todo Notes:'),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        spacing: 20,
        children: [
          TextFormField(
            controller: _titleController,
            decoration: InputDecoration(
              border: OutlineInputBorder(),
              label: Text('Add Titles'),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Is Completed:',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
              ),
              Switch(
                value: isCompleted,
                activeColor: Colors.blue,
                onChanged: (bool value) {
                  setState(() {
                    isCompleted = value;
                  });
                },
              ),
            ],
          ),
        ],
      ),
      actions: [
        TextButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          child: Text('Cancel'),
        ),
        TextButton(
          onPressed: () {
            if (_titleController.text.isNotEmpty) {
              final todo = TodosModel(
                userId: "",
                title: _titleController.text,
                completed: isCompleted,
              );

              context.read<TodosProvider>().createTodos(todo);
            }
            Navigator.of(context).pop();
          },
          child: Text('Add'),
        ),
      ],
    );
  }
}
