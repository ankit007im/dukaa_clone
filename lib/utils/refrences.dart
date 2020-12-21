import 'package:cloud_firestore/cloud_firestore.dart';

class References {
  static CollectionReference usersRef =
      FirebaseFirestore.instance.collection('users');
  static CollectionReference productRef =
      FirebaseFirestore.instance.collection('products');
  static CollectionReference bussinessRef =
      FirebaseFirestore.instance.collection('categories');
}
