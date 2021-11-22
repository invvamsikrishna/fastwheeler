import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:geolocator/geolocator.dart';
import '../size_config.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => new _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  CollectionReference _ref = FirebaseFirestore.instance.collection("users");
  @override
  void initState() {
    super.initState();
    _checkPermission();
  }

  void _checkPermission() async {
    LocationPermission status = await Geolocator.checkPermission();
    Timer(Duration(seconds: 3), () {
      if (status == LocationPermission.denied ||
          status == LocationPermission.deniedForever) {
        Navigator.pushNamedAndRemoveUntil(
          context,
          "/permissionScreen",
          (route) => false,
        );
      } else {
        User? auth = FirebaseAuth.instance.currentUser;
        if (auth != null) {
          _ref
              .doc(FirebaseAuth.instance.currentUser!.uid)
              .get()
              .then((DocumentSnapshot doc) {
            if (doc.exists) {
              Map<String, dynamic> userData =
                  doc.data() as Map<String, dynamic>;
              String _type = userData["type"];
              if (_type == "Car") {
                Navigator.pushNamedAndRemoveUntil(
                  context,
                  "/homeScreen",
                  (route) => false,
                );
              } else {
                Navigator.pushNamedAndRemoveUntil(
                  context,
                  "/driverScreen",
                  (route) => false,
                );
              }
            }
          });
        } else {
          Navigator.pushNamedAndRemoveUntil(
            context,
            "/startScreen",
            (route) => false,
          );
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Container(
            margin: EdgeInsets.symmetric(vertical: 20),
            width: double.infinity,
            child: Image.asset(
              "assets/images/logo.png",
              height: SizeConfig.screenHeight * 0.3,
            ),
          ),
        ],
      ),
    );
  }
}
