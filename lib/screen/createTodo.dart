import 'package:dukaan_clone/controller/todo/todo.dart';
import 'package:dukaan_clone/models/todo.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class TodoCreate extends StatelessWidget {
  final int index;

  final TodoController todoController = Get.find();
  TodoCreate({this.index});

  @override
  Widget build(BuildContext context) {
    String text = '';
    if (!this.index.isNull) {
      text = todoController.todos[index].todo;
    }
    TextEditingController textEditingController =
        TextEditingController(text: text);

    return Scaffold(
      body: Container(
        padding: EdgeInsets.all(22),
        child: Column(
          children: [
            Expanded(
              child: TextField(
                controller: textEditingController,
                keyboardType: TextInputType.multiline,
                autofocus: true,
                decoration: InputDecoration(
                  hintText: "Create your todo here",
                  border: InputBorder.none,
                  focusedBorder: InputBorder.none,
                ),
                style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
                maxLines: 9,
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                RaisedButton(
                    onPressed: () {
                      Get.back();
                    },
                    color: Colors.redAccent,
                    child: Text("Cancel")),
                RaisedButton(
                    onPressed: () {
                      if (this.index.isNull) {
                        todoController.todos
                            .add(Todo(todo: textEditingController.text));
                      } else {
                        var edit = todoController.todos[index];
                        edit.todo = textEditingController.text;
                        todoController.todos[index] = edit;
                      }

                      Get.back();
                    },
                    color: Colors.green,
                    child: Text((this.index.isNull) ? "Create" : "Update"))
              ],
            )
          ],
        ),
      ),
    );
  }
}
