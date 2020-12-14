import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dukaan_clone/pages/home.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AuthController extends GetxController {
  TextEditingController phoneNumberController = TextEditingController();
  final FirebaseAuth _auth = FirebaseAuth.instance;
  String actualCode;
  bool hasError = false.obs();
  String currentText = "".obs();
  // Firebase user one-time fetch
  Future<User> get getUser async => _auth.currentUser;

  // Firebase user a realtime stream
  Stream<User> get user => _auth.authStateChanges();

  // final FirebaseFirestore _db = FirebaseFirestore.instance;
  // Rx<User> firebaseUser = Rx<User>();

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
  // Future<User> get getUser async => _auth.currentUser;

  // // Firebase user a realtime stream
  // Stream<User> get user => _auth.authStateChanges();

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
    print(_auth.currentUser);
    print(user);
  }

  void verifyOTPAndLogin({String smsCode}) async {
    PhoneAuthCredential phoneAuthCredential = PhoneAuthProvider.credential(
        verificationId: actualCode, smsCode: smsCode);

    await _auth.signInWithCredential(phoneAuthCredential);
    Get.offAll(HomePage());
  }

  void verifyPhoneNumber() {
    final PhoneCodeSent codeSent =
        (String verificationId, [int forceResendingToken]) async {
      actualCode = verificationId;
      print("\nEnter the code sent to " + phoneNumberController.text);
      // String smsCode = '123456';

      // // Create a PhoneAuthCredential with the code
      // PhoneAuthCredential phoneAuthCredential = PhoneAuthProvider.credential(
      //     verificationId: verificationId, smsCode: smsCode);

      // // Sign the user in (or link) with the credential
      // await _auth.signInWithCredential(phoneAuthCredential);
      // _addStatus(PhoneAuthState.CodeSent);
      // if (onCodeSent != null) onCodeSent();
    };

    final PhoneCodeAutoRetrievalTimeout codeAutoRetrievalTimeout =
        (String verificationId) {
      actualCode = verificationId;
      print("\nAuto retrieval time out");
      // _addStatus(PhoneAuthState.AutoRetrievalTimeOut);
      // if (onAutoRetrievalTimeout != null) onAutoRetrievalTimeout();
    };

    final PhoneVerificationFailed verificationFailed =
        (FirebaseAuthException error) {
      print("Verifaction Failed");
    };

    final PhoneVerificationCompleted verificationCompleted =
        (AuthCredential auth) {
      print("Completed");
    };

    _auth
        .verifyPhoneNumber(
            phoneNumber: phoneNumberController.text,
            verificationCompleted: verificationCompleted,
            verificationFailed: verificationFailed,
            codeSent: codeSent,
            codeAutoRetrievalTimeout: codeAutoRetrievalTimeout)
        .then((value) => {printVal()});
  }
}
