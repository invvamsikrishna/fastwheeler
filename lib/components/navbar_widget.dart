import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../size_config.dart';

class NavBarWidget extends StatelessWidget {
  const NavBarWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    List<String> _name = [
      "Profile",
      "Reward Points",
      "Refer & Earn",
      "Contact us",
      "About us",
      "Logout",
    ];
    List<IconData> _icons = [
      Icons.person_outlined,
      Icons.wallet_giftcard,
      Icons.supervised_user_circle_outlined,
      Icons.contact_phone_outlined,
      Icons.info_outline_rounded,
      Icons.logout_outlined,
    ];

    List<String> _screens = [
      "/profileScreen",
      "/rewardScreen",
      "/referScreen",
      "/contactScreen",
      "/aboutScreen",
    ];

    void _logout() {
      FirebaseAuth.instance.signOut();
      Navigator.pushNamedAndRemoveUntil(
        context,
        "/startScreen",
        (route) => false,
      );
    }

    return Drawer(
      child: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Container(
              height: SizeConfig.screenHeight * 0.25,
              child: Image.asset('assets/images/logo.png'),
            ),
            ListView.builder(
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              itemCount: _name.length,
              itemBuilder: (BuildContext context, index) {
                return ListTile(
                  title: Text(_name[index]),
                  leading: Icon(_icons[index]),
                  onTap: () {
                    (_name[index] == "Logout")
                        ? _logout()
                        : Navigator.pushNamed(context, _screens[index]);
                  },
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
