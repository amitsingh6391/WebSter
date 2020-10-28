import 'package:flutter/services.dart';
import 'package:youtube/pages/homepage.dart';
import 'package:youtube/splashscreen.dart';
import "package:flutter/material.dart";

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp])
      .then((_) {
    runApp(MyApp());
  });
  // runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        title: "Webcone",
        home: Splashscreen());
  }
}
