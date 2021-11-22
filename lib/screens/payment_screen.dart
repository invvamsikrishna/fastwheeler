import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fastwheeler/components/default_button.dart';
import 'package:fastwheeler/utils/counter.dart';
import 'package:fastwheeler/utils/launcher_utils.dart';
import 'package:fastwheeler/utils/maps_counter.dart';
import 'package:fastwheeler/utils/models.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../constants.dart';

class PaymentScreen extends StatefulWidget {
  const PaymentScreen({Key? key}) : super(key: key);

  @override
  _PaymentScreenState createState() => _PaymentScreenState();
}

class _PaymentScreenState extends State<PaymentScreen> {
  late Timer timer;
  bool _flag = false, _flag1 = false;
  String _id = "", _driverPhone = "";
  CollectionReference _ref = FirebaseFirestore.instance.collection('trips');
  late StreamSubscription _subscription;

  @override
  void initState() {
    super.initState();
    _setRequest();
  }

  void _setRequest() async {
    MapsCounter _counter = context.read<MapsCounter>();
    Address _pickup = _counter.pickup;
    String _phone = context.read<Counter>().phone;
    String _name = context.read<Counter>().name;

    DocumentReference _doc = await _ref.add({
      "status": "1",
      "pickup": _pickup.placeFormattedAddress,
      "date": DateTime.now().toString(),
      "user": {
        "id": FirebaseAuth.instance.currentUser!.uid.toString(),
        "name": _name,
        "phone": _phone,
      },
      "driver": {
        "id": "",
        "name": "",
        "phone": "",
      },
    });

    setState(() {
      _flag = true;
      _id = _doc.id;
    });

    _startTimer();
    _subscription = _ref.doc(_doc.id).snapshots().listen((doc) {
      if (doc.exists) {
        Map<String, dynamic> _data = doc.data() as Map<String, dynamic>;
        if (_data["status"] == "2") {
          timer.cancel();
          setState(() {
            _driverPhone = _data["driver"]["phone"];
            _flag1 = true;
          });
        } else if (_data["status"] == "0") {
          _onMessageShow(
            false,
            "Request time out, Please try again after some time",
          );
        }
      }
    });
  }

  void _startTimer() {
    timer = Timer(Duration(minutes: 2), () async {
      timer.cancel();
      await FirebaseFirestore.instance.collection("trips").doc(_id).update({
        "status": "0",
      });
    });
  }

  @override
  void dispose() async {
    super.dispose();
    _subscription.cancel();
    timer.cancel();
    await FirebaseFirestore.instance.collection("trips").doc(_id).update({
      "status": "0",
    });
  }

  @override
  Widget build(BuildContext context) {
    int _price = context.read<MapsCounter>().amount -
        context.read<MapsCounter>().helperamt -
        context.read<MapsCounter>().gstamt;
    return Scaffold(
      appBar: AppBar(
        title: Text("Waiting for confirmation"),
        leading: IconButton(
          onPressed: () => Navigator.pop(context),
          icon: Icon(
            Icons.arrow_back_ios,
          ),
        ),
      ),
      body: _flag
          ? _flag1
              ? SingleChildScrollView(
                  child: Column(
                    children: [
                      Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Card(
                          color: Colors.green[100],
                          child: ListTile(
                            title: Text("Booking Confirmed"),
                            trailing: Icon(
                              Icons.check_circle,
                              color: Colors.green,
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 16),
                        child: Align(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            "Booking Details",
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                      ListTile(
                        visualDensity: VisualDensity(vertical: -2),
                        minLeadingWidth: 0,
                        leading: Icon(Icons.airport_shuttle_outlined),
                        title: Text(
                          "Vehicle",
                          style: TextStyle(fontSize: 14),
                        ),
                        subtitle: Text(
                          "Sniff Crane",
                          style: TextStyle(
                            fontWeight: FontWeight.w600,
                            color: Colors.black87,
                          ),
                        ),
                      ),
                      ListTile(
                        visualDensity: VisualDensity(vertical: -2),
                        minLeadingWidth: 0,
                        leading: Icon(Icons.location_on),
                        title: Text(
                          "Pickup",
                          style: TextStyle(fontSize: 14),
                        ),
                        subtitle: Text(
                          context
                              .read<MapsCounter>()
                              .pickup
                              .placeFormattedAddress,
                          style: TextStyle(
                            fontWeight: FontWeight.w600,
                            color: Colors.black87,
                          ),
                        ),
                      ),
                      SizedBox(height: 30),
                      Padding(
                        padding: EdgeInsets.all(8.0),
                        child: SizedBox(
                          width: double.infinity,
                          child: ElevatedButton(
                            onPressed: () =>
                                LauncherUtils.openUrl("tel:$_driverPhone"),
                            child: Text(
                              "CALL",
                              style: TextStyle(
                                fontWeight: FontWeight.w600,
                                fontSize: 16,
                              ),
                            ),
                            style: ElevatedButton.styleFrom(
                              padding: EdgeInsets.all(12),
                              primary: Colors.lightGreen,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                )
              : Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Image.asset(
                      "assets/images/vehicle_anim.gif",
                      fit: BoxFit.contain,
                    ),
                    Padding(
                      padding: EdgeInsets.all(20),
                      child: ClipRRect(
                        borderRadius: BorderRadius.all(Radius.circular(10)),
                        child: LinearProgressIndicator(
                          minHeight: 6,
                          color: Colors.indigoAccent[100],
                          backgroundColor: Colors.grey[300],
                        ),
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "Searching for the drivers near you",
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.w600,
                            color: Colors.indigoAccent[100],
                          ),
                        ),
                      ],
                    ),
                    Spacer(),
                    DefaultButton3(
                      text: "Cancel",
                      press: () {
                        Navigator.pop(context);
                      },
                      icon: Icons.close_outlined,
                    ),
                    Spacer(flex: 2)
                  ],
                )
          : Center(
              child: CircularProgressIndicator(),
            ),
    );
  }

  _onMessageShow(bool flag, String text) {
    showDialog(
      context: context,
      builder: (context) {
        return WillPopScope(
          onWillPop: () async => false,
          child: AlertDialog(
            contentPadding: EdgeInsets.all(20),
            content: Container(
              width: double.infinity,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(
                    flag ? Icons.cloud_done : Icons.cloud_off,
                    color: flag ? kPrimaryColor : Colors.redAccent,
                    size: 100,
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(vertical: 20),
                    child: Text(
                      text,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      Navigator.of(context)..pop()..pop();
                    },
                    child: Text(
                      "Ok",
                      style: TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: 16,
                      ),
                    ),
                    style: ElevatedButton.styleFrom(
                      padding: EdgeInsets.symmetric(horizontal: 40),
                      primary: flag ? Colors.lightGreen : Colors.redAccent,
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
