import 'package:dukaan_clone/controller/todo/todo.dart';
import 'package:dukaan_clone/screen/createTodo.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class TodoApp extends StatelessWidget {
  TodoApp({Key key, this.title}) : super(key: key);
  final String title;
  final TodoController todoController = Get.put(TodoController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(title),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            Get.to(TodoCreate());
          },
          child: Icon(
            Icons.add,
            color: Colors.white,
          ),
          backgroundColor: Colors.blue,
        ),
        body: Container(
          child: (todoController.todos.isEmpty)
              ? Column(
                mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      alignment: Alignment.center,
                        child: Text(
                      "Create New todo",
                      style: TextStyle(fontSize: 40),
                    )),
                    Container(
                        child: Image.network(
                            'https://media.giphy.com/media/3o6MbhbYBsqTrbP2qQ/giphy.gif', height: 300,))
                  
                  ],
                )
              : Obx(() => ListView.separated(
                  itemBuilder: (context, index) => ListTile(
                        title: Text(todoController.todos[index].todo),
                        leading: Checkbox(
                          value: todoController.todos[index].done,
                          onChanged: (v) {
                            var changed = todoController.todos[index];
                            changed.done = v;
                            todoController.todos[index] = changed;
                          },
                        ),
                        trailing: Icon(Icons.arrow_right),
                        onTap: () {
                          Get.to(TodoCreate(index: index));
                        },
                      ),
                  separatorBuilder: (_, __) => Divider(),
                  itemCount: todoController.todos.length)),
        ));
  }
}
