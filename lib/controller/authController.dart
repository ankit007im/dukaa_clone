import 'package:dukaan_clone/models/user.dart';
import 'package:dukaan_clone/pages/Otp.dart';
import 'package:dukaan_clone/pages/RegisterPage.dart';
import 'package:dukaan_clone/pages/home.dart';
import 'package:dukaan_clone/utils/refrences.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

enum AppState { loading, authenticated, unauthenticated }

class AuthController extends GetxController {
  // Text Controller for text fields
  TextEditingController phoneNumberController = TextEditingController();
  TextEditingController pinPutController = TextEditingController();

  // Firebase Instance
  final FirebaseAuth auth = FirebaseAuth.instance;

  // Firebase States
  final isCodeSent = false.obs;
  UserStore userStore;
  final state = AppState.loading.obs;
  final verificationID = ''.obs;

  // Firebase user
  User get user => auth.currentUser;
  String get userId {
    return (user != null) ? auth.currentUser.uid : null;
  }

  Rx<User> firebaseUser = Rx<User>();

  @override
  void onInit() {
    super.onInit();
    // configure();
    _updateState();
  }

  void _updateState() async {
    if (user != null) {
      try {
        final snap = await References.usersRef.doc(userId).get();
        userStore = UserStore.fromMap(snap.data());
        final businessSnap = await References.productRef.doc(userId).get();
        // if (businessSnap.docs.isNotEmpty) {
        //   selectedBusiness = Business.fromMap(businessSnap.docs.first.data());
        // }
        state(AppState.authenticated);
      } catch (error) {
        state(AppState.unauthenticated);
      }
    } else {
      state(AppState.unauthenticated);
    }
  }

  void verifyOTPAndLogin({String smsCode}) async {
    final credential = PhoneAuthProvider.credential(
        verificationId: verificationID.value, smsCode: smsCode);
    verificationCompleted(credential);
    // printVal();
    // await auth.signInWithCredential(credential);
    // Get.offAll(HomePage());
  }

  Future<void> verifyPhoneNumber() async {
    await auth.verifyPhoneNumber(
        phoneNumber: "+91" + phoneNumberController.text,
        verificationCompleted: verificationCompleted,
        verificationFailed: (FirebaseAuthException e) {
          if (e.code == 'invalid-phone-number') {
            print('The provided phone number is not valid.');
          }
        },
        codeSent: (String verificationId, int resendToken) {
          isCodeSent(true);
          verificationID(verificationId);
          print("code sent" + verificationId);
          Get.to(GetOtp());
        },
        codeAutoRetrievalTimeout: (verificationId) {
          verificationID.value = verificationId;
        },
        timeout: Duration(seconds: 60));
  }

  void verificationCompleted(AuthCredential credential) async {
    try {
      final result = await auth.signInWithCredential(credential);
      final user = result.user;
      checkUser(user);
    } catch (error) {
      print(error);
    }
  }

  void checkUser(User user) async {
    try {
      final snap =
          await References.usersRef.where('uid', isEqualTo: user.uid).get();
      print(snap);
      if (snap.docs.isEmpty) {
        print("user empty");
        final storeUser = UserStore.fromUser(user);
        await References.usersRef.doc(storeUser.uid).set(storeUser.toMap());
      }
      Get.offAll(HomePage());
    } catch (e) {
      print("user Not Found" + e);
    }
  }

  void logout() async {
    await auth.signOut();
    Get.offAll(RegisterNumber());
  }
}
