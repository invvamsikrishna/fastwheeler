import 'package:flutter/material.dart';

const kPrimaryColor = Colors.lightBlue;
const kLightColor = Color(0xfff6f6f6);

const kPrimaryLightColor = Color(0xFFFFECDF);
const kPrimaryGradientColor = LinearGradient(
  begin: Alignment.topLeft,
  end: Alignment.bottomRight,
  colors: [Color(0xFFFFA53E), Color(0XFFFF7643)],
);
const kSecondaryColor = Color(0xFF979797);
const kTextColor = Color(0xFF757575);
const kAnimationDuration = Duration(milliseconds: 5000);

final RegExp emailValidatorRegExp = RegExp(
    r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+");

const String kNameNullError = "Please Enter your Name";
const String kNameInvalidError = "Name is too short, must be 3 characters";
const String kPhoneNullError = "Please Enter your Phone Number";
const String kPhoneInvalidError = "Please Enter valid Phone Number";
const String kEmailNullError = "Please Enter your Email";
const String kEmailInavalidError = "Please Enter Valid Email";
const String kPassNullError = "Please Enter your Password";
const String kPassShortError = "Password is too short, must be 6 characters";
const String kMatchPassError = "Password don't match";
const String kVehicleNullError = "Please select your vehicle";

const String mapKey = "AIzaSyCjS8h-FCLamEarOtZG4eofwbCcUnmMw2w";
const int cradius = 50000;
const double clatitude = 17.7267862;
const double clongitude = 83.3035373;
