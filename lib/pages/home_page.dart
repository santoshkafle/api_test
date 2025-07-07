import 'package:api_test/provider/todos_provider.dart';
import 'package:api_test/widgets/add_todo_form.dart';
import 'package:api_test/widgets/edit_todo_form.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    context.read<TodosProvider>().initilizeTodos();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final todos = context.watch<TodosProvider>();
    final isLoading = context.watch<TodosProvider>().isLoading;
    return Scaffold(
      appBar: AppBar(
        title: Text("HomePage"),
        actions: [
          IconButton(
            onPressed: () {
              context.read<TodosProvider>().initilizeTodos();
            },
            icon: Icon(Icons.refresh),
          ),
        ],
        centerTitle: true,
        backgroundColor: Colors.grey[100],
      ),
      backgroundColor: Colors.grey[100],
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () {
          showDialog(context: context, builder: (context) => AddTodoForm());
        },
      ),
      body: Center(
        child:
            isLoading
                ? CircularProgressIndicator()
                : Column(
                  children: [
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                          vertical: 10,
                          horizontal: 10,
                        ),
                        child: ListView.builder(
                          itemCount: todos.todosModel.length,
                          itemBuilder: (context, index) {
                            final todo = todos.todosModel[index];
                            return Container(
                              padding: EdgeInsets.all(20),
                              margin: EdgeInsets.only(bottom: 20),
                              decoration: BoxDecoration(
                                color: Colors.grey[300],
                                borderRadius: BorderRadius.circular(20),
                              ),
                              // height: 100,
                              child: Row(
                                children: [
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        todo.title,
                                        style: TextStyle(
                                          fontSize: 20,
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                      todo.completed
                                          ? Text(
                                            'Completed',
                                            style: TextStyle(
                                              fontSize: 16,
                                              fontWeight: FontWeight.w500,
                                              color: Colors.green,
                                            ),
                                          )
                                          : Text(
                                            'Not Completed.',
                                            style: TextStyle(
                                              fontSize: 16,
                                              fontWeight: FontWeight.w500,
                                              color: Colors.red,
                                            ),
                                          ),
                                    ],
                                  ),
                                  Spacer(),
                                  Row(
                                    children: [
                                      IconButton(
                                        onPressed: () async {
                                          showDialog(
                                            context: context,
                                            builder:
                                                (context) => EditTodoForm(
                                                  todosModel: todo,
                                                ),
                                          );
                                        },
                                        icon: Icon(
                                          Icons.edit_outlined,
                                          color: Colors.blue,
                                        ),
                                      ),
                                      IconButton(
                                        onPressed: () {
                                          todos.deleteTodos(todo.userId ?? '');
                                        },
                                        icon: Icon(
                                          Icons.delete_outline,
                                          color: Colors.red,
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            );
                          },
                        ),
                      ),
                    ),
                  ],
                ),
      ),
    );
  }
}
