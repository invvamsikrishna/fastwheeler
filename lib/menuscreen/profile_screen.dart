import 'package:fastwheeler/utils/counter.dart';
import 'package:flutter/material.dart';
import '../size_config.dart';
import 'package:provider/provider.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Profile"),
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(
            Icons.arrow_back_ios,
          ),
        ),
      ),
      body: Column(
        children: <Widget>[
          Image.asset(
            "assets/images/logo.png",
            height: SizeConfig.screenHeight * 0.2,
            fit: BoxFit.cover,
          ),
          ListTile(
            leading: Container(
              height:double.infinity,
              child: Icon(
                Icons.person_pin,
                color: Colors.lightGreen,
                size: 30,
              ),
            ),
            title: Text("Name", style: TextStyle(fontSize: 14)),
            subtitle: Text(context.read<Counter>().name, style: TextStyle(fontSize: 18)),
          ),
          ListTile(
            leading: Container(
              height:double.infinity,
              child: Icon(
                Icons.phone_android_outlined,
                color: Colors.lightGreen,
                size: 30,
              ),
            ),
            title: Text("Phone Number", style: TextStyle(fontSize: 14)),
             subtitle: Text(context.read<Counter>().phone, style: TextStyle(fontSize: 18)),
          ),
          ListTile(
            leading: Container(
              height:double.infinity,
              child: Icon(
                Icons.mail_outlined,
                color: Colors.lightGreen,
                size: 30,
              ),
            ),
            title: Text("Email Address", style: TextStyle(fontSize: 14)),
             subtitle: Text(context.read<Counter>().email, style: TextStyle(fontSize: 18)),
          ),
        ],
      ),
    );
  }
}
