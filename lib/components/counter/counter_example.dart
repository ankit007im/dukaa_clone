import 'package:dukaan_clone/components/counter/counter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';

class CounterExample extends StatefulWidget {
  CounterExample({Key key, this.title}) : super(key: key);
  final String title;
  @override
  _CounterExampleState createState() => _CounterExampleState();
}

class _CounterExampleState extends State<CounterExample> {
  
  final Counter counter = Counter();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'You have pushed the button this many times:',
            ),
            Observer(
                builder: (_) => Text(
                      '${counter.value}',
                      style: TextStyle(fontSize: 20),
                    )),
            MaterialButton(
              color: Colors.red,
              child: Text("Clear All", style: TextStyle(color: Colors.white),),
              onPressed: counter.clearAll,
            )
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: counter.increment,
        tooltip: 'Increment',
        child: Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    ); 
  }
}