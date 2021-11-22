import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fastwheeler/components/navbar_widget.dart';
import 'package:fastwheeler/utils/counter.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:provider/provider.dart';
import '../constants.dart';
import '../size_config.dart';

class DriverScreen extends StatefulWidget {
  const DriverScreen({Key? key}) : super(key: key);

  @override
  _DriverScreenState createState() => _DriverScreenState();
}

class _DriverScreenState extends State<DriverScreen> {
  bool _flag = false;
  final CollectionReference _ref =
      FirebaseFirestore.instance.collection('trips');
  final CollectionReference _ref1 =
      FirebaseFirestore.instance.collection('users');
  late StreamSubscription _subscription;
  late List<DocumentSnapshot> _snapshot = [];
  bool _isOnline = false;

  @override
  void initState() {
    super.initState();
    _checkData();
  }

  void _checkData() async {
    context.read<Counter>().getUserData();
    _subscription =
        _ref.where("status", isEqualTo: "1").snapshots().listen((query) {
      List<QueryDocumentSnapshot> document = [];
      if (query.size != 0) {
        query.docs.map((doc) {
          document.add(doc);
        }).toList();
      }
      setState(() {
        _snapshot = document;
      });
    });

    setState(() {
      _flag = true;
    });
  }

  void _locatePosition() async {
    Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);
  }

  void _acceptRide(DocumentSnapshot document) {
    _ref.doc(document.id).update({
      "status": "2",
      "driver.id": FirebaseAuth.instance.currentUser!.uid,
      "driver.name": context.read<Counter>().name,
      "driver.phone": context.read<Counter>().phone,
    }).then((value) {
      Navigator.pushNamed(context, "/bookingScreen",
          arguments: {"id": document.id});
    });
  }

  @override
  void dispose() {
    super.dispose();
    if (_flag) _subscription.cancel();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: _onBackPressed,
      child: Scaffold(
        drawer: NavBarWidget(),
        appBar: AppBar(
          backgroundColor: kPrimaryColor,
          elevation: 1,
          centerTitle: true,
          title: Text(
            _isOnline ? "Online" : "Offline",
            style: TextStyle(color: Colors.white),
          ),
          iconTheme: IconThemeData(color: Colors.white),
          actions: [
            Switch(
              activeColor: Colors.teal[700],
              value: _isOnline,
              onChanged: (value) async {
                await _ref1
                    .doc(FirebaseAuth.instance.currentUser!.uid)
                    .update({"status": value ? "1" : "0"});
                setState(() {
                  _isOnline = value;
                });
              },
            ),
          ],
        ),
        body: SafeArea(
          child: _flag
              ? Stack(
                  children: [
                    Positioned(
                      bottom: 0,
                      child: Image.asset(
                        'assets/images/map.jpg',
                        fit: BoxFit.fill,
                      ),
                    ),
                    if (_isOnline && _snapshot.length > 0)
                      Align(
                        alignment: Alignment.bottomCenter,
                        child: SingleChildScrollView(
                          scrollDirection: Axis.horizontal,
                          physics: BouncingScrollPhysics(),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: _snapshot.map((DocumentSnapshot docc) {
                              String _vehicle = "Need Crane";
                              return OrderWidget(
                                vehicle: "$_vehicle",
                                pickup: docc["pickup"],
                                press: () => _acceptRide(docc),
                              );
                            }).toList(),
                          ),
                        ),
                      )
                  ],
                )
              : Center(child: CircularProgressIndicator()),
        ),
      ),
    );
  }

  Future<bool> _onBackPressed() async {
    return (await showDialog(
      context: context,
      builder: (context) => new AlertDialog(
        content: Text('Do you want to exit an App'),
        actions: <Widget>[
          TextButton(
            onPressed: () => Navigator.of(context).pop(false),
            child: Text('No'),
          ),
          TextButton(
            onPressed: () => Navigator.of(context).pop(true),
            child: Text('Yes'),
          ),
        ],
      ),
    ));
  }
}

class OrderWidget extends StatelessWidget {
  final String vehicle;
  final String pickup;
  final Function press;
  const OrderWidget({
    Key? key,
    required this.vehicle,
    required this.pickup,
    required this.press,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          color: Colors.white, borderRadius: BorderRadius.circular(20)),
      width: SizeConfig.screenWidth * 0.9,
      margin: EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          ListTile(
            title: Text(
              vehicle,
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          Divider(height: 0),
          SizedBox(height: 10),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 2),
            child: Text(
              "PICK UP",
              style: TextStyle(color: Colors.black45, fontSize: 12),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 2),
            child: Text(
              pickup,
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
            ),
          ),
          SizedBox(height: 20),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 20.0),
            child: Align(
              alignment: Alignment.centerRight,
              child: ElevatedButton(
                onPressed: () {
                  press();
                },
                style: ElevatedButton.styleFrom(
                    primary: kPrimaryColor,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(50.0),
                    ),
                    padding: EdgeInsets.symmetric(horizontal: 30)),
                child: Text(
                  "Accept",
                  style: TextStyle(
                      fontSize: 16,
                      color: Colors.white,
                      fontWeight: FontWeight.bold),
                ),
              ),
            ),
          ),
          SizedBox(height: 20)
        ],
      ),
    );
  }
}
