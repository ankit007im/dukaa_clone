import 'package:dukaan_clone/controller/authController.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomePage extends StatelessWidget {
  final AuthController controller = Get.put(AuthController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Home PAge"),
        actions: [
          IconButton(icon: Icon(Icons.logout), onPressed: (){
            print(controller.auth.currentUser.uid);
          })
        ],
      ),
      body: Container(
        alignment: Alignment.center,
        child: Text("Home" + controller.auth.currentUser.phoneNumber),
      ),
    );
  }
}
