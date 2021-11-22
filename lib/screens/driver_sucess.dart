import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fastwheeler/utils/launcher_utils.dart';
import 'package:flutter/material.dart';

class BookingSuccess extends StatefulWidget {
  const BookingSuccess({Key? key}) : super(key: key);

  @override
  _BookingSuccessState createState() => _BookingSuccessState();
}

class _BookingSuccessState extends State<BookingSuccess> {
  bool _flag = false;
  String _id = "", _phone = "", _pickup = "";
  CollectionReference _ref = FirebaseFirestore.instance.collection('trips');


  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _setRequest();
  }

  void _setRequest() async {
    final arg = ModalRoute.of(context)!.settings.arguments as Map;
    String _id = arg["id"];
    _ref.doc(_id).get().then((doc) {
      if (doc.exists) {
        Map<String, dynamic> _data = doc.data() as Map<String, dynamic>;
        setState(() {
          _phone = _data["user"]["phone"];
          _pickup = _data["pickup"];
          _flag = true;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Booking Confirmed"),
        leading: IconButton(
          onPressed: () => Navigator.pop(context),
          icon: Icon(
            Icons.arrow_back_ios,
          ),
        ),
      ),
      body: _flag
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
                      "Car",
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
                      _pickup,
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
                        onPressed: () => LauncherUtils.openUrl("tel:$_phone"),
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
          : Center(
              child: CircularProgressIndicator(),
            ),
    );
  }
}
