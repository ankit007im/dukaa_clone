import 'package:dukaan_clone/components/authController.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pin_code_fields/pin_code_fields.dart';

class GetOtp extends StatelessWidget {
  final AuthController authController = Get.put(AuthController());
  @override
  Widget build(BuildContext context) {
    final formKey = GlobalKey<FormState>();
    TextEditingController textEditingController = TextEditingController();

    return Scaffold(
      appBar: AppBar(
        title: Text("Enter Otp"),
      ),
      body: Container(
        alignment: Alignment.center,
        child: Form(
          key: formKey,
          child: Padding(
              padding:
                  const EdgeInsets.symmetric(vertical: 8.0, horizontal: 30),
              child: PinCodeTextField(
                appContext: context,
                pastedTextStyle: TextStyle(
                  color: Colors.green.shade600,
                  fontWeight: FontWeight.bold,
                ),
                length: 6,
                obscureText: false,
                obscuringCharacter: '*',
                // animationType: AnimationType.fade,
                validator: (v) {
                  if (v.length < 3) {
                    return "I'm from validator";
                  } else {
                    return null;
                  }
                },
                pinTheme: PinTheme(
                  shape: PinCodeFieldShape.box,
                  borderRadius: BorderRadius.circular(5),
                  fieldHeight: 60,
                  fieldWidth: 50,
                  // activeFillColor: authController.hasError =
                  //     false ? Colors.orange : Colors.white as bool,
                ),
                cursorColor: Colors.black,
                animationDuration: Duration(milliseconds: 300),
                textStyle: TextStyle(fontSize: 20, height: 1.6),
                backgroundColor: Colors.blue.shade50,
                enableActiveFill: true,
                // errorAnimationController: errorController,
                controller: textEditingController,
                keyboardType: TextInputType.number,
                boxShadows: [
                  BoxShadow(
                    offset: Offset(0, 1),
                    color: Colors.black12,
                    blurRadius: 10,
                  )
                ],
                onCompleted: (v) {
                  print("Completed");
                },
                // onTap: () {
                //   print("Pressed");
                // },
                onChanged: (value) {
                  print(value);
                  authController.currentText = value;
                },
                beforeTextPaste: (text) {
                  print("Allowing to paste $text");
                  //if you return true then it will show the paste confirmation dialog. Otherwise if false, then nothing will happen.
                  //but you can show anything you want here, like your pop up saying wrong paste format or etc
                  return true;
                },
              )),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          authController.verifyOTPAndLogin(smsCode: authController.currentText);
        },
        child: Icon(
          Icons.add,
          color: Colors.white,
        ),
        backgroundColor: Colors.blue,
      ),
    );
  }
}
