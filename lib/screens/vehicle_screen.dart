import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fastwheeler/components/default_button.dart';
import 'package:fastwheeler/utils/maps_counter.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class VehicleScreen extends StatefulWidget {
  const VehicleScreen({Key? key}) : super(key: key);

  @override
  _VehicleScreenState createState() => _VehicleScreenState();
}

class _VehicleScreenState extends State<VehicleScreen> {
  CollectionReference _ref = FirebaseFirestore.instance.collection('users');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Nearby Vehicles",
        ),
        leading: IconButton(
          onPressed: () => Navigator.pop(context),
          icon: Icon(
            Icons.arrow_back_ios,
          ),
        ),
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: _ref
            .where("type", isEqualTo: "Crane")
            .where("status", isEqualTo: "1")
            .snapshots(),
        builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.hasError) {
            return Center(child: Text('Something went wrong'));
          }

          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          }

          if (snapshot.data!.docs.length <= 0) {
            return Center(child: Text("No cranes available"));
          }
          return ListView(
            children: snapshot.data!.docs.map((DocumentSnapshot document) {
              Map<String, dynamic> _data =
                  document.data()! as Map<String, dynamic>;
              return Padding(
                padding: EdgeInsets.symmetric(horizontal: 3.0),
                child: Card(
                  child: ExpansionTile(
                    leading: ClipOval(
                      child: Image.asset(
                        'assets/vehicles/v1.png',
                        fit: BoxFit.cover,
                        width: 70,
                        height: 70,
                      ),
                    ),
                    title: Text("Stiff Crane"),
                    children: <Widget>[
                      ListTile(
                        visualDensity: VisualDensity(vertical: -4),
                        leading: Icon(Icons.card_travel_outlined),
                        title: Text('Maximum Load : '),
                        trailing: Text("450"),
                      ),
                      ListTile(
                        visualDensity: VisualDensity(vertical: -4),
                        leading: Icon(Icons.airport_shuttle),
                        title: Text('Vehicle Size : '),
                        trailing: Text("286 * 286"),
                      ),
                      Container(
                        padding: EdgeInsets.symmetric(
                          horizontal: 20,
                          vertical: 20,
                        ),
                        child: DefaultFullButton(
                          text: "Book Now",
                          press: () {
                            context.read<MapsCounter>().setData(document.id);
                            Navigator.pushNamed(context, "/paymentScreen");
                          },
                        ),
                      ),
                    ],
                  ),
                ),
              );
            }).toList(),
          );
        },
      ),
    );
  }
}
