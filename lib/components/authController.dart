import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AuthController extends GetxController {
  TextEditingController phoneNumberController = TextEditingController();
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _db = FirebaseFirestore.instance;
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
}
