import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fastwheeler/components/default_button.dart';
import 'package:fastwheeler/components/navbar_widget.dart';
import 'package:fastwheeler/components/textfield_widget.dart';
import 'package:fastwheeler/utils/assistance.dart';
import 'package:fastwheeler/utils/counter.dart';
import 'package:fastwheeler/utils/maps_counter.dart';
import 'package:fastwheeler/utils/models.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:provider/provider.dart';
import '../constants.dart';
import '../size_config.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  TextEditingController _controller1 = new TextEditingController();
  TextEditingController _controller2 = new TextEditingController();

  final CollectionReference _ref =
      FirebaseFirestore.instance.collection('trips');

  @override
  void initState() {
    super.initState();
    context.read<MapsCounter>().clearValues();
    context.read<Counter>().getUserData();
    // _checkBookings();
    _locatePosition();
  }

  void _locatePosition() async {
    Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);
    Address address = await AssistantMethods.searchCoordinateAddress(position);
    context.read<MapsCounter>().setPickUp(address);
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: _onBackPressed,
      child: Scaffold(
        drawer: NavBarWidget(),
        appBar: AppBar(
          backgroundColor: kPrimaryColor,
          title: Text(
            "Fast Wheeler",
            style: TextStyle(color: Colors.white),
          ),
          iconTheme: IconThemeData(color: Colors.white),
        ),
        body: Stack(
          children: <Widget>[
            Positioned(
              bottom: 0,
              child: Image.asset(
                'assets/images/map.jpg',
                fit: BoxFit.fill,
              ),
            ),
            Align(
              alignment: Alignment.topCenter,
              child: Padding(
                padding: EdgeInsets.only(top: 10.0),
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.white70,
                    borderRadius: BorderRadius.all(
                      Radius.circular(20.0),
                    ),
                  ),
                  width: SizeConfig.screenWidth * 0.9,
                  child: Padding(
                    padding: EdgeInsets.only(top: 10.0, bottom: 10.0),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: <Widget>[
                        SizedBox(height: 10),
                        LocationTextField(
                          controller: _controller1
                            ..text = context
                                .watch<MapsCounter>()
                                .pickup
                                .placeFormattedAddress,
                          lable: "Pickup",
                          function: () => _onTapEditing(true),
                        ),
                        SizedBox(height: 10),
                        Visibility(
                          visible: (context.watch<MapsCounter>().distance > 0)
                              ? true
                              : false,
                          child: Text(
                            'Distance: ${context.watch<MapsCounter>().distance} Km',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                        SizedBox(height: 5),
                        Visibility(
                          visible: (context
                                  .watch<MapsCounter>()
                                  .pickup
                                  .placeId
                                  .isNotEmpty)
                              ? true
                              : false,
                          child: DefaultButton(
                            text: "Confirm",
                            press: () {
                              Navigator.pushNamed(context, "/vehicleScreen");
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
            Align(
              alignment: Alignment.bottomRight,
              child: Padding(
                padding: EdgeInsets.only(right: 10.0, bottom: 10.0),
                child: ClipOval(
                  child: InkWell(
                    child: Container(
                      width: 56,
                      height: 56,
                      color: Colors.lightGreen,
                      child: Icon(
                        Icons.my_location,
                        color: Colors.white,
                      ),
                    ),
                    onTap: _locatePosition,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _onTapEditing(bool flag) async {
    await Navigator.pushNamed(
      context,
      "/locationScreen",
      arguments: {"flag": flag},
    );
  }

  Future<bool> _onBackPressed() async {
    return (await showDialog(
      context: context,
      builder: (context) => new AlertDialog(
        content: Text('Do you really want to exit an App ?'),
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
