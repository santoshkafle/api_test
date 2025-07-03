import 'package:api_test/services/todoservices.dart';
import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("HomePage"),
        centerTitle: true,
        backgroundColor: Colors.grey[100],
      ),
      backgroundColor: Colors.grey[100],
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
                  child: ListTile(
                    leading: Text(
                      data[index].id,
                      style: TextStyle(
                        fontSize: 25,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    title: Text(
                      data[index].title,
                      style: TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                    trailing:
                        data[index].completed
                            ? Icon(Icons.check, color: Colors.green)
                            : Icon(Icons.dangerous, color: Colors.red),
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
