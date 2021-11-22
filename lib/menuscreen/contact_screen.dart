import 'package:flutter/material.dart';
import '../constants.dart';

class ContactScreen extends StatefulWidget {
  const ContactScreen({Key? key}) : super(key: key);

  @override
  _ContactScreenState createState() => _ContactScreenState();
}

class _ContactScreenState extends State<ContactScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Contact us"),
        leading: IconButton(
          onPressed: () => Navigator.pop(context),
          icon: Icon(
            Icons.arrow_back_ios,
          ),
        ),
      ),
      body: Column(
        children: <Widget>[
          ListTile(
            title: Text(
              'Get In Touch!',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w600,
                color: kPrimaryColor,
              ),
            ),
            subtitle: Text("Always within your reach"),
          ),
          ListTile(
            leading: Icon(Icons.call, color: kPrimaryColor),
            title: Text(
              '1234567890',
              style: TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.w500,
              ),
            ),
            onTap: (){},
          ),
          ListTile(
            leading: Icon(Icons.mail, color: kPrimaryColor),
            title: Text(
              'support@fastwheeler.in',
              style: TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.w500,
              ),
            ),
            onTap: () {},
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 20),
            child: Text(
              'Follow us on',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w600,
                color: kPrimaryColor,
              ),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              IconButton(
                onPressed: (){},
                icon: Icon(
                  Icons.facebook_outlined,
                  size: 36,
                  color: Colors.blue,
                ),
              ),
              SizedBox(width: 10),
              IconButton(
                onPressed: (){},
                icon: Image.asset("assets/images/twitter.png"),
              ),
              SizedBox(width: 10),
              IconButton(
                onPressed: () {},
                icon: Image.asset("assets/images/linkedin.png"),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
