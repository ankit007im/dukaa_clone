import 'package:firebase_auth/firebase_auth.dart';

class UserStore {
  final String uid;
  final String phoneNumber;

  UserStore({this.uid, this.phoneNumber});

  UserStore.fromMap(data)
      : uid = data['uid'],
        phoneNumber = data['phoneNumber'];

  UserStore.fromUser(User user)
      : uid = user.uid,
        phoneNumber = user.phoneNumber;

  Map<String, dynamic> toMap() => {
        'uid': this.uid,
        'number': this.phoneNumber,
      };
}
