import 'dart:math';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fastwheeler/components/common_widget.dart';
import 'package:fastwheeler/components/default_button.dart';
import 'package:fastwheeler/utils/authentication.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import '../constants.dart';
import '../size_config.dart';

class StartScreen extends StatefulWidget {
  const StartScreen({Key? key}) : super(key: key);

  @override
  _StartScreenState createState() => _StartScreenState();
}

class _StartScreenState extends State<StartScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  Authentication _auth = new Authentication();
  CollectionReference _ref = FirebaseFirestore.instance.collection("users");
  bool _flag = false;
  String _phone = "";
  String _otp1 = "1", _otp2 = "2", _otp3 = "3", _otp4 = "4";
  int _randomOtp = 1234;

  void _sendOtp() async {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      setState(() {
        _flag = true;
      });
    }
  }

  void _verifyOtp() async {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      int _motp = int.parse("$_otp1$_otp2$_otp3$_otp4");
      if (_motp == _randomOtp) {
        IsLoading(context);
        QuerySnapshot _snap =
            await _ref.where("number", isEqualTo: _phone).get();
        if (_snap.size > 0) {
          String _email = _snap.docs[0]["email"];
          String token = await _auth.signin(_email, "123456");
          if (token == "SignedIn") {
            if (_snap.docs[0]["type"] == "Car") {
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
          } else {
            Navigator.pop(context);
            ShowSnackBar(context, "Something went wrong");
          }
        } else {
          Navigator.pushNamedAndRemoveUntil(
            context,
            "/signupScreen",
            (route) => false,
            arguments: {"phone": _phone},
          );
        }
      } else {
        ShowSnackBar(context, "Invalid OTP");
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          padding:
              EdgeInsets.symmetric(horizontal: SizeConfig.screenWidth * 0.1),
          width: SizeConfig.screenWidth,
          height: SizeConfig.screenHeight,
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage("assets/images/bg.png"),
              fit: BoxFit.cover,
            ),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              Spacer(),
              Image.asset(
                "assets/images/startimg.png",
                height: SizeConfig.screenHeight * 0.3,
              ),
              SizedBox(height: 20),
              Text(
                "Explore new way to move with\nFast Wheeler",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                  color: Colors.black38,
                ),
              ),
              Spacer(),
              _flag
                  ? Text(
                      "Enter the OTP sent to +91-$_phone",
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                        color: Colors.black38,
                      ),
                      textAlign: TextAlign.center,
                    )
                  : Text(
                      "We will send you an OTP on this mobile number",
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                        color: Colors.black38,
                      ),
                      textAlign: TextAlign.center,
                    ),
              SizedBox(height: 20),
              Form(
                key: _formKey,
                child: _flag
                    ? Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          _singleOtpNode(true, false, 1),
                          _singleOtpNode(false, false, 2),
                          _singleOtpNode(false, false, 3),
                          _singleOtpNode(false, true, 4),
                        ],
                      )
                    : _phoneWidget(),
              ),
              SizedBox(height: 10),
              _flag
                  ? DefaultFullButton(text: "Verify", press: _verifyOtp)
                  : DefaultFullButton(text: "Send OTP", press: _sendOtp),
              Spacer(),
              RichText(
                textAlign: TextAlign.center,
                text: TextSpan(
                  text:
                      "By continue. You agree that you have read and accept our ",
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                    color: Colors.black38,
                  ),
                  children: [
                    TextSpan(
                      text: "Terms & Conditions",
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                        color: kPrimaryColor,
                      ),
                      recognizer: TapGestureRecognizer()..onTap = () {},
                    )
                  ],
                ),
              ),
              SizedBox(height: 50),
            ],
          ),
        ),
      ),
    );
  }

  Container _singleOtpNode(bool first, bool last, int index) {
    return Container(
      height: 60,
      width: 50,
      child: TextFormField(
        onChanged: (value) {
          if (value.length == 1 && last == false) {
            FocusScope.of(context).nextFocus();
          }
          if (value.length == 0 && first == false) {
            FocusScope.of(context).previousFocus();
          }
        },
        onSaved: (value) {
          if (index == 1) _otp1 = value!;
          if (index == 2) _otp2 = value!;
          if (index == 3) _otp3 = value!;
          if (index == 4) _otp4 = value!;
        },
        validator: (value) {
          if (value!.isEmpty) return "";
          return null;
        },
        autofocus: true,
        showCursor: false,
        textAlign: TextAlign.center,
        maxLength: 1,
        keyboardType: TextInputType.number,
        decoration: InputDecoration(
          errorStyle: TextStyle(height: 0),
          contentPadding: EdgeInsets.all(8),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide(color: Colors.black45),
          ),
          counter: Offstage(),
        ),
      ),
    );
  }

  TextFormField _phoneWidget() {
    return TextFormField(
      maxLength: 10,
      decoration: InputDecoration(
        prefixIcon: Icon(Icons.phone_outlined),
        border: OutlineInputBorder(),
        contentPadding: EdgeInsets.all(0),
        labelText: "Phone Number",
        counterText: "",
      ),
      keyboardType: TextInputType.number,
      textInputAction: TextInputAction.next,
      onSaved: (value) => _phone = value!,
      validator: (value) {
        if (value!.isEmpty)
          return kPhoneNullError;
        else if (value.length < 10) return kPhoneInvalidError;
        return null;
      },
    );
  }
}
