import 'package:fastwheeler/components/default_button.dart';
import 'package:fastwheeler/size_config.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';

class CheckPermissionScreen extends StatefulWidget {
  const CheckPermissionScreen({Key? key}) : super(key: key);

  @override
  _CheckPermissionScreenState createState() => _CheckPermissionScreenState();
}

class _CheckPermissionScreenState extends State<CheckPermissionScreen> {
  void _checkPermission() async {
    LocationPermission status = await Geolocator.checkPermission();
    if (status == LocationPermission.denied ||
        status == LocationPermission.deniedForever) {
      LocationPermission statuss = await Geolocator.requestPermission();
      if (statuss != LocationPermission.denied &&
          statuss != LocationPermission.deniedForever) {
        Navigator.pushNamedAndRemoveUntil(
          context,
          "/startScreen",
          (route) => false,
        );
      }
    } else {
      Navigator.pushNamedAndRemoveUntil(
        context,
        "/startScreen",
        (route) => false,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: SizeConfig.screenWidth,
        height: SizeConfig.screenHeight,
        decoration: BoxDecoration(
          image: DecorationImage(
              image: AssetImage("assets/images/bg.png"), fit: BoxFit.cover),
        ),
        child: Padding(
          padding: EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: <Widget>[
              Padding(
                padding: EdgeInsets.all(20.0),
                child: Text(
                  "Let Mini-Go access your location to locate you and get rides easily with a comfortable ride experience",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                    color: Colors.black38,
                  ),
                ),
              ),
              Image.asset(
                "assets/images/location.png",
                height: SizeConfig.screenHeight * 0.4,
              ),
              DefaultFullButton(
                text: "Allow Permission",
                press: _checkPermission,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
