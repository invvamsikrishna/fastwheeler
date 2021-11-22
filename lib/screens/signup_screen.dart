import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fastwheeler/components/common_widget.dart';
import 'package:fastwheeler/components/default_button.dart';
import 'package:fastwheeler/utils/authentication.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import '../constants.dart';
import '../size_config.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({Key? key}) : super(key: key);
  @override
  _SignUpScreenState createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  late String _name, _email, _phone, _reffId, _vehicle = "";
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  Authentication _auth = new Authentication();
  CollectionReference _ref = FirebaseFirestore.instance.collection("users");
  List<String> _vehicles = [
    "Crane",
    "Car",
  ];

  void _signUp() async {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      IsLoading(context);
      String token = await _auth.signup(_email, "123456");
      if (token == "SignedUp") {
        if (_reffId.isNotEmpty) {
          QuerySnapshot _snap =
              await _ref.where("refId", isEqualTo: _reffId).get();
          if (_snap.size > 0) {
            await _ref.doc(_snap.docs[0].id).update({
              "refdata": FieldValue.arrayUnion([_name])
            });
          }
        }
        String refId =
            _name.substring(0, 3).toLowerCase() + _phone.substring(6, 10);
        if (refId.contains(" ")) refId = refId.replaceAll(" ", "v");
        _ref.doc(FirebaseAuth.instance.currentUser!.uid).set({
          "name": _name,
          "email": _email,
          "number": _phone,
          "refId": refId,
          "refdata": [],
          "token": "",
          "type": _vehicle,
          "status": "1",
        }).then((value) {
          if (_vehicle == "Car") {
            Navigator.pushNamedAndRemoveUntil(
              context,
              "/homeScreen",
              (route) => false,
            );
          } else {
            Navigator.pushNamedAndRemoveUntil(
              context,
              "/driverScreen",
              (route) => false,
            );
          }
        });
      } else {
        Navigator.pop(context);
        String error = "Something went wrong";
        if (token == 'weak-password') {
          error = "Weak Password";
        } else if (token == 'email-already-in-use') {
          error = "Email address is already in use";
        }
        ShowSnackBar(context, error);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final args = ModalRoute.of(context)?.settings.arguments as Map;
    _phone = args['phone'];
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          padding:
              EdgeInsets.symmetric(horizontal: SizeConfig.screenWidth * 0.1),
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                SizedBox(height: 40),
                Image.asset(
                  "assets/images/startimg.png",
                  height: SizeConfig.screenHeight * 0.2,
                ),
                SizedBox(height: 20),
                Text(
                  "Complete your profile",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                    color: Colors.black38,
                  ),
                ),
                SizedBox(height: 30),
                TextFormField(
                  maxLength: 20,
                  decoration: InputDecoration(
                      prefixIcon: Icon(Icons.person_outline),
                      border: OutlineInputBorder(),
                      contentPadding: EdgeInsets.all(0),
                      labelText: "Name",
                      counterText: ""),
                  textInputAction: TextInputAction.next,
                  onSaved: (value) => _name = value!,
                  validator: (value) {
                    if (value!.isEmpty) return kNameNullError;
                    if (value.trim().length < 3) return kNameInvalidError;
                    return null;
                  },
                ),
                SizedBox(height: 20),
                TextFormField(
                  decoration: InputDecoration(
                    prefixIcon: Icon(Icons.mail_outlined),
                    border: OutlineInputBorder(),
                    contentPadding: EdgeInsets.all(0),
                    labelText: "Email Address",
                  ),
                  keyboardType: TextInputType.emailAddress,
                  textInputAction: TextInputAction.next,
                  onSaved: (value) => _email = value!,
                  validator: (value) {
                    if (value!.isEmpty)
                      return kEmailNullError;
                    else if (!emailValidatorRegExp.hasMatch(value))
                      return kEmailInavalidError;
                    return null;
                  },
                ),
                SizedBox(height: 20),
                TextFormField(
                  decoration: InputDecoration(
                    prefixIcon: Icon(Icons.mail_outlined),
                    border: OutlineInputBorder(),
                    contentPadding: EdgeInsets.all(0),
                    labelText: "Referral Id (optional)",
                  ),
                  keyboardType: TextInputType.text,
                  textInputAction: TextInputAction.next,
                  onSaved: (value) => _reffId = value!,
                ),
                SizedBox(height: 20),
                TextFormField(
                  controller: TextEditingController()..text = _vehicle,
                  onTap: _onVehicleButtonPressed,
                  showCursor: false,
                  readOnly: true,
                  decoration: InputDecoration(
                    prefixIcon: Icon(Icons.directions_bus_filled_outlined),
                    border: OutlineInputBorder(),
                    contentPadding: EdgeInsets.only(top: 10),
                    labelText: "Select Vehicle",
                  ),
                  textInputAction: TextInputAction.next,
                  onSaved: (value) => _vehicle = value!,
                  validator: (value) {
                    if (value!.isEmpty) return kVehicleNullError;
                    return null;
                  },
                ),
                SizedBox(height: 20),
                DefaultFullButton(text: "Sign Up", press: _signUp),
              ],
            ),
          ),
        ),
      ),
    );
  }

  _onVehicleButtonPressed() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (context) {
        return Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ListTile(
              visualDensity: VisualDensity(vertical: -4),
              title: Center(
                  child: Text(
                "Select Vehicle",
                style: TextStyle(color: Colors.black45),
              )),
            ),
            Divider(),
            Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                ListView.separated(
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  separatorBuilder: (context, index) => Divider(),
                  itemCount: _vehicles.length,
                  itemBuilder: (context, index) {
                    return ListTile(
                      selected: (_vehicle == _vehicles[index]) ? true : false,
                      visualDensity: VisualDensity(vertical: -4),
                      title: Text(_vehicles[index]),
                      leading: Icon(
                        Icons.directions_bus_filled_outlined,
                        color: kPrimaryColor,
                      ),
                      onTap: () {
                        setState(() {
                          _vehicle = _vehicles[index];
                        });
                        Navigator.pop(context);
                      },
                    );
                  },
                ),
              ],
            ),
          ],
        );
      },
    );
  }
}
