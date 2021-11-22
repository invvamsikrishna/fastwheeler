import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';

class Counter with ChangeNotifier {
  String _name = "";
  String _email = "";
  String _phone = "";
  String _refId = "";
  String _token = "";
  CollectionReference _ref = FirebaseFirestore.instance.collection("users");

  String get name => _name;
  String get email => _email;
  String get phone => _phone;
  String get refer => _refId;
  String get token => _token;

  void setData(String phone) {
    _phone = phone;
  }

  void getUserData() {
    _ref.doc(FirebaseAuth.instance.currentUser!.uid).get().then((DocumentSnapshot doc) {
      if (doc.exists) {
        Map<String, dynamic> userData = doc.data() as Map<String, dynamic>;
        _name = userData["name"];
        _email = userData["email"];
        _phone = userData["number"];
        _refId = userData["refId"];
        notifyListeners();
      }
    });
  }
}
