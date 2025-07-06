import 'package:api_test/services/todoservices.dart';
import 'package:api_test/widgets/add_todo_form.dart';
import 'package:api_test/widgets/edit_todo_form.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("HomePage"),
        actions: [
          IconButton(
            onPressed: () {
              setState(() {});
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
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 12),
        child: FutureBuilder(
          future: Todoservices.getTodos(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(child: CircularProgressIndicator());
            }

            //data is loaded,
            return ListView.builder(
              itemCount: snapshot.data!.length,
              itemBuilder: (context, index) {
                final data = snapshot.data!;
                return Card(
                  color: Colors.grey[300],
                  elevation: 2,
                  child: InkWell(
                    onTap: () {
                      showDialog(
                        context: context,
                        builder:
                            (context) => EditTodoForm(todosModel: data[index]),
                      );
                    },
                    child: ListTile(
                      leading: Text(
                        data[index].userId!,
                        style: TextStyle(
                          fontSize: 25,
                          fontWeight: FontWeight.bold,
                        ),
                        maxLines: 2,
                        textAlign: TextAlign.justify,
                        overflow: TextOverflow.ellipsis,
                      ),
                      title: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            data[index].title,
                            style: TextStyle(
                              fontSize: 22,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                          data[index].completed
                              ? Icon(Icons.check, color: Colors.green)
                              : Icon(Icons.dangerous, color: Colors.red),
                        ],
                      ),
                      trailing: IconButton(
                        onPressed: () {
                          Todoservices.deleteTodos(data[index].userId!);
                          setState(() {});
                          Todoservices.getTodos();
                        },
                        icon: Icon(Icons.delete),
                      ),
                    ),
                  ),
                );
              },
            );
          },
        ),
      ),
    );
  }
}
