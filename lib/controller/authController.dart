import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dukaan_clone/pages/Otp.dart';
import 'package:dukaan_clone/pages/home.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AuthController extends GetxController {
  TextEditingController phoneNumberController = TextEditingController();
  TextEditingController pinPutController = TextEditingController();
  final FirebaseAuth auth = FirebaseAuth.instance;
  
  String verificationCode;
  // bool hasError = false.obs();
  // String currentText = "".obs();
  // Firebase user one-time fetch
  Future<User> get getUser async => auth.currentUser;

  // Firebase user a realtime stream
  Stream<User> get user => auth.authStateChanges();

  // final FirebaseFirestore _db = FirebaseFirestore.instance;
  Rx<User> firebaseUser = Rx<User>();

  // @override
  // void onReady() async {
  //   //run every time auth state changes
  //   ever(firebaseUser, handleAuthChanged);
  //   firebaseUser.value = await getUser;
  //   firebaseUser.bindStream(user);
  //   super.onReady();
  // }

  //   handleAuthChanged(_firebaseUser) async {
  //   //get user data from firestore

  //   if (_firebaseUser == null) {
  //     // Get.offAll(SignInUI());
  //   } else {
  //     // Get.offAll(HomeUI());
  //   }
  // }

  //  // Firebase user one-time fetch
  // Future<User> get getUser async => auth.currentUser;

  // // Firebase user a realtime stream
  // Stream<User> get user => auth.authStateChanges();

  //Streams the firestore user from the firestore collection
  // Stream<UserModel> streamFirestoreUser() {
  //   print('streamFirestoreUser()');
  //   if (firebaseUser?.value?.uid != null) {
  //     return _db
  //         .doc('/users/${firebaseUser.value.uid}')
  //         .snapshots()
  //         .map((snapshot) => UserModel.fromMap(snapshot.data()));
  //   }

  //   return null;
  // }

  void printVal() {
    print(auth.currentUser);
    print(user);
  }

  void verifyOTPAndLogin({String smsCode}) async {
    PhoneAuthCredential phoneAuthCredential = PhoneAuthProvider.credential(
        verificationId: verificationCode, smsCode: smsCode);
    printVal();
    await auth.signInWithCredential(phoneAuthCredential);
    Get.offAll(HomePage());
  }

  void verifyPhoneNumber() async {
    await auth.verifyPhoneNumber(
        phoneNumber: phoneNumberController.text,
        verificationCompleted: (PhoneAuthCredential credential) async {
          await FirebaseAuth.instance
              .signInWithCredential(credential)
              .then((value) async {
            if (value.user != null) {
              print(value.user);
              Get.offAll(HomePage());
            }
          });
        },
        verificationFailed: (FirebaseAuthException e) {
          if (e.code == 'invalid-phone-number') {
            print('The provided phone number is not valid.');
          }
        },
        codeSent: (String verificationId, int resendToken) {
          verificationCode = verificationId;
          print("code sent" + verificationId);
          Get.to(GetOtp());
        },
        codeAutoRetrievalTimeout: (String verificationId) {
          verificationCode = verificationId;
        },
        timeout: Duration(seconds: 60));
  }
}
