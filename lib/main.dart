import 'package:dukaan_clone/components/counter/counter_example.dart';
import 'package:dukaan_clone/components/todo/todo_example.dart';
import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.blue,
          visualDensity: VisualDensity.adaptivePlatformDensity,
        ),
        home: Scaffold(
          appBar: AppBar(
            title: Text("Examples of mobX"),
          ),
          body: ExamplePages(),
        ));
  }
}

class ExamplePages extends StatefulWidget {
  @override
  _ExamplePagesState createState() => _ExamplePagesState();
}

class _ExamplePagesState extends State<ExamplePages> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          MaterialButton(
              color: Colors.deepOrange,
              child: Text("Counter Page"),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => CounterExample(
                            title: "Counter App",
                          )),
                );
              }),
          MaterialButton(
              color: Colors.deepOrange,
              child: Text("Todo App"),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => TodoApp(title: "Todo App")),
                );
              }),
          MaterialButton(
              color: Colors.deepOrange,
              child: Text("Page 3"),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => CounterExample(
                            title: "Counter App",
                          )),
                );
              })
        ],
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
