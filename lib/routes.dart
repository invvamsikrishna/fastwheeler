import 'package:fastwheeler/screens/driver_screen.dart';
import 'package:fastwheeler/screens/driver_sucess.dart';
import 'package:fastwheeler/screens/home_screen.dart';
import 'package:fastwheeler/screens/location_screen.dart';
import 'package:fastwheeler/screens/payment_screen.dart';
import 'package:fastwheeler/screens/permission_screen.dart';
import 'package:fastwheeler/screens/signup_screen.dart';
import 'package:fastwheeler/screens/splash_screen.dart';
import 'package:fastwheeler/screens/start_screen.dart';
import 'package:fastwheeler/screens/vehicle_screen.dart';
import 'package:flutter/widgets.dart';

import 'menuscreen/about_screen.dart';
import 'menuscreen/contact_screen.dart';
import 'menuscreen/profile_screen.dart';
import 'menuscreen/refer_screen.dart';
import 'menuscreen/reward_screen.dart';

final Map<String, WidgetBuilder> routes = {
  "/": (context) => SplashScreen(),
  "/startScreen": (context) => StartScreen(),
  "/permissionScreen": (context) => CheckPermissionScreen(),
  "/signupScreen": (context) => SignUpScreen(),
  "/homeScreen": (context) => HomeScreen(),
  "/vehicleScreen": (context) => VehicleScreen(),
  "/paymentScreen": (context) => PaymentScreen(),
  "/locationScreen": (context) => LocationScreen(),
  "/profileScreen": (context) => ProfileScreen(),
  "/rewardScreen": (context) => RewardScreen(),
  "/referScreen": (context) => ReferScreen(),
  "/contactScreen": (context) => ContactScreen(),
  "/aboutScreen": (context) => AboutScreen(),
  "/driverScreen":(context) => DriverScreen(),
  "/bookingScreen":(context) => BookingSuccess(),
};
