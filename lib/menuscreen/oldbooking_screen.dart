// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:flutter/material.dart';

// class OldBookingScreen extends StatefulWidget {
//   const OldBookingScreen({Key? key}) : super(key: key);

//   @override
//   _OldBookingScreenState createState() => _OldBookingScreenState();
// }

// class _OldBookingScreenState extends State<OldBookingScreen> {
//   CollectionReference _reference = MiniGo.firestore.collection('trips');
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text("Booking Summary"),
//         leading: IconButton(
//           onPressed: () => Navigator.pop(context),
//           icon: Icon(Icons.arrow_back_ios),
//         ),
//       ),
//       body: FutureBuilder<QuerySnapshot>(
//         future: _reference
//             .where("user.id", isEqualTo: MiniGo.auth.currentUser!.uid)
//             .orderBy('date', descending: true)
//             .limit(25)
//             .get(),
//         builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
//           if (snapshot.hasError) {
//             return Text('Something went wrong');
//           }

//           if (snapshot.connectionState == ConnectionState.waiting) {
//             return Center(child: CircularProgressIndicator());
//           }

//           if (snapshot.data!.docs.length == 0) {
//             return Center(child: Text("No rides available"));
//           }

//           return ListView(
//             physics: BouncingScrollPhysics(),
//             children: snapshot.data!.docs.map((DocumentSnapshot docc) {
//               Map<String, dynamic> data = docc.data()! as Map<String, dynamic>;
//               String _datee = data["date"];
//               DateTime _dateee = DateTime.parse(_datee);
//               int date = DateTime.now().difference(_dateee).inDays;
//               String _days = (date == 0)
//                   ? "Today"
//                   : (date == 1)
//                       ? "Yesterday"
//                       : "$date days ago";
//               return Card(
//                 margin: EdgeInsets.symmetric(horizontal: 12, vertical: 4),
//                 elevation: 2,
//                 child: Container(
//                   child: Column(
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: [
//                       ListTile(
//                         visualDensity:
//                             VisualDensity(horizontal: -4, vertical: -4),
//                         title: Text("${data["vehicle"]} - $_days"),
//                         subtitle: Text(
//                           (data["status"] == "2")
//                               ? "Dropped"
//                               : (data["status"] == "0")
//                                   ? "Cancelled"
//                                   : "Running",
//                           style: TextStyle(
//                             color: (data["status"] == "0")
//                                 ? Colors.red
//                                 : Colors.green,
//                           ),
//                         ),
//                         trailing: Text("\u{20B9}${data["amount"]} + \u{20B9}${data["history"]["latecharges"]}", textAlign: TextAlign.right,),
//                       ),
//                       Divider(height: 0),
//                       ListTile(
//                         horizontalTitleGap: -10,
//                         dense: true,
//                         visualDensity: VisualDensity(
//                           horizontal: -4,
//                           vertical: -4,
//                         ),
//                         title: Text(data["pickup"]["name"]),
//                         leading: Icon(
//                           Icons.circle,
//                           size: 10,
//                           color: Colors.green,
//                         ),
//                       ),
//                       ListTile(
//                         horizontalTitleGap: -10,
//                         dense: true,
//                         visualDensity: VisualDensity(
//                           horizontal: -4,
//                           vertical: -4,
//                         ),
//                         title: Text(data["drop"]["name"]),
//                         leading: Icon(
//                           Icons.circle,
//                           size: 10,
//                           color: Colors.red,
//                         ),
//                       ),
//                     ],
//                   ),
//                 ),
//               );
//             }).toList(),
//           );
//         },
//       ),
//     );
//   }
// }
