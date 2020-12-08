import 'package:dukaan_clone/components/todo/todo_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:provider/provider.dart';

class TodoApp extends StatefulWidget {
  TodoApp({Key key, this.title}) : super(key: key);
  final String title;
  @override
  _TodoAppState createState() => _TodoAppState();
}

class _TodoAppState extends State<TodoApp> {
  @override
  Widget build(BuildContext context) => Provider<TodoList>(
        create: (_) => TodoList(),
        child: Scaffold(
          appBar: AppBar(
            title: Text(widget.title),
          ),
          body: Column(
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TodoInput(),
              ),
              Description(),
              ViewTodos(),
            ],
          ),
        ),
      );
}

class Description extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final list = Provider.of<TodoList>(context);
    return Container(
      child: Observer(
        builder: (_) => Padding(
          padding: EdgeInsets.all(8.0),
          child: Text(list.itemsDescription),
        ),
      ),
    );
  }
}

class ViewTodos extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final list = Provider.of<TodoList>(context);

    return Observer(
      builder: (_) => Flexible(
          child: ListView.builder(
              itemCount: list.todos.length,
              itemBuilder: (_, index) {
                final todo = list.todos[index];
                return Observer(
                  builder: (_) => CheckboxListTile(
                    controlAffinity: ListTileControlAffinity.leading,
                    onChanged: (flag) => todo.description,
                    value: true,
                    title: Row(
                      children: <Widget>[
                      Expanded(
                        child: Text(todo.description,
                            overflow: TextOverflow.ellipsis),
                      ),
                      IconButton(
                        onPressed: () => list.removeTodo(todo),
                        icon: Icon(Icons.delete),
                      )
                    ]),
                  ),
                );
              })),
    );
  }
}

class TodoInput extends StatelessWidget {
  final _textController = TextEditingController(text: "");
  @override
  Widget build(BuildContext context) {
    final list = Provider.of<TodoList>(context);
    return Container(
      child: TextField(
        autofocus: true,
        controller: _textController,
        decoration: InputDecoration(
            labelText: "Add a Todo", contentPadding: EdgeInsets.all(8.0)),
        onSubmitted: (String value) {
          list.addTodo(value);
          _textController.clear();
        },
      ),
    );
  }
}
