import 'package:fastwheeler/routes.dart';
import 'package:fastwheeler/theme.dart';
import 'package:fastwheeler/utils/counter.dart';
import 'package:fastwheeler/utils/maps_counter.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.dark);
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]).then(
    (value) => runApp(
      MultiProvider(
        providers: [
          ChangeNotifierProvider(create: (_) => Counter()),
          ChangeNotifierProvider(create: (_) => MapsCounter()),
        ],
        child: MyApp(),
      ),
    ),
  );
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Fast Wheeler',
      theme: theme(),
      debugShowCheckedModeBanner: false,
      initialRoute: "/",
      routes: routes,
    );
  }
}
