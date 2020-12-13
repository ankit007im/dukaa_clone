import 'package:dukaan_clone/components/authController.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class RegisterNumber extends StatelessWidget {
  final AuthController authController = Get.put(AuthController());
  @override
  Widget build(BuildContext context) {
    
    return Scaffold(
      appBar: AppBar(
        title: Text("Register"),
      ),
      body: Container(
          child: TextField(
        autofocus: true,
        keyboardType: TextInputType.number,
        controller: authController.phoneNumberController,
      )),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          print(authController.phoneNumberController.text);
        },
        child: Icon(
          Icons.arrow_forward,
          color: Colors.white,
        ),
        backgroundColor: Colors.blue,
      ),
    );
  }
}
