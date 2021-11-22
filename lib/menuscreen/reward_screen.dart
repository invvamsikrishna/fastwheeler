import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import '../constants.dart';
import '../size_config.dart';

class RewardScreen extends StatefulWidget {
  const RewardScreen({Key? key}) : super(key: key);

  @override
  _RewardScreenState createState() => _RewardScreenState();
}

class _RewardScreenState extends State<RewardScreen> {
  List<String> _rewards = [];
  int _refpoints = 0;
  CollectionReference _ref = FirebaseFirestore.instance.collection("users");
  bool _flag = false;

  @override
  void initState() {
    super.initState();
    _getRewardPointsData();
  }

  void _getRewardPointsData() async {
    DocumentSnapshot _snap = await _ref.doc(FirebaseAuth.instance.currentUser!.uid).get();
    List _refdata = _snap["refdata"];
    _refpoints = _refdata.length * 100;
    if (_refdata.length > 0) {
      _refdata.forEach((value) {
        _rewards.add(value.toString());
      });
    }
    setState(() {
      _flag = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Reward Points"),
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(
            Icons.arrow_back_ios,
          ),
        ),
      ),
      body: _flag
          ? SingleChildScrollView(
              physics: BouncingScrollPhysics(),
              child: Column(
                children: <Widget>[
                  Image.asset(
                    "assets/images/rewards.png",
                    height: 150,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      "$_refpoints Points",
                      style: TextStyle(
                        color: kPrimaryColor,
                        fontWeight: FontWeight.bold,
                        fontSize: 30,
                      ),
                    ),
                  ),
                  Divider(indent: 12),
                  Padding(
                    padding:
                        EdgeInsets.symmetric(vertical: 8.0, horizontal: 16),
                    child: Row(
                      children: [
                        Text(
                          "Rewards History",
                          style: TextStyle(
                            fontWeight: FontWeight.w600,
                            color: Colors.black54,
                          ),
                          textAlign: TextAlign.left,
                        ),
                      ],
                    ),
                  ),
                  _rewards.length == 0
                      ? Container(
                          height: SizeConfig.screenHeight * 0.5,
                          child: Center(
                            child: Text(
                              "No referrals available",
                              style: TextStyle(
                                fontWeight: FontWeight.w600,
                                color: Colors.black54,
                              ),
                            ),
                          ),
                        )
                      : ListView.builder(
                          physics: NeverScrollableScrollPhysics(),
                          shrinkWrap: true,
                          itemBuilder: (context, int index) {
                            return Card(
                              child: ListTile(
                                leading: CircleAvatar(
                                  child: Text("R"),
                                ),
                                title: Text(
                                  _rewards[index],
                                  style: TextStyle(fontSize: 15),
                                ),
                                trailing: Text(
                                  "+100",
                                  style: TextStyle(fontSize: 15),
                                ),
                              ),
                            );
                          },
                          itemCount: _rewards.length,
                        ),
                ],
              ),
            )
          : Center(child: CircularProgressIndicator()),
    );
  }
}
