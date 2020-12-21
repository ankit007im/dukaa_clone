import 'package:cloud_firestore/cloud_firestore.dart';

class Business {
  String name;
  String category;

  Business.fromMap(DocumentSnapshot data) {
    name = data['name'];
    category = data['category'];
  }
}
