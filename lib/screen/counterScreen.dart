import 'package:dukaan_clone/controller/counter/counter.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CounterApp extends StatelessWidget {
  CounterApp({Key key, this.title}) : super(key: key);
  final CounterController counter = Get.put(CounterController());
  final String title;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: counter.increment,
        child: Icon(
          Icons.add,
          color: Colors.white,
        ),
        backgroundColor: Colors.blue,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(child: Text("Counts number")),
            Obx(() => Text(
                  '${counter.count}',
                  style: TextStyle(fontSize: 38),
                )),
            FlatButton(
              onPressed: counter.clearAll,
              child: Text("Clear All"),
              color: Colors.red,
            )
          ],
        ),
      ),
    );
  }
}
