import 'package:flutter/material.dart';

import '../size_config.dart';

class AboutScreen extends StatefulWidget {
  const AboutScreen({Key? key}) : super(key: key);

  @override
  _AboutScreenState createState() => _AboutScreenState();
}

class _AboutScreenState extends State<AboutScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("About us"),
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(
            Icons.arrow_back_ios,
          ),
        ),
      ),
      body: Container(
        padding: EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          children: <Widget>[
            Image.asset(
              "assets/images/logo.png",
              height: SizeConfig.screenHeight * 0.2,
              fit: BoxFit.cover,
            ),
            SizedBox(
              height: 20,
            ),
            Text(
              "",
              style: TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.w600,
              ),
              textAlign: TextAlign.justify,
            ),
          ],
        ),
      ),
    );
  }
}
