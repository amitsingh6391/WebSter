import 'dart:async';

import 'package:youtube/contant.dart';
import 'package:youtube/loginandsignup/loginpgae.dart';
import 'package:youtube/pages/homepage.dart';
import 'package:youtube/pages/introscreen.dart';
import "package:flutter/material.dart";
import 'package:shared_preferences/shared_preferences.dart';

class Splashscreen extends StatefulWidget {
  @override
  _SplashscreenState createState() => _SplashscreenState();
}

class _SplashscreenState extends State<Splashscreen> {
  String intro;

  @override
  void initState() {
    super.initState();

    Timer(
      Duration(seconds: 5),
      () async {
        WidgetsFlutterBinding.ensureInitialized();
        SharedPreferences preferences = await SharedPreferences.getInstance();

        var email = preferences.getString('email');

        var introexit = preferences.getString("logout");
        print(introexit);
        print(email);
        print("aooooo");

        if (email == "introcomp") {
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => Loginpage()));
        }
        if (email == "loggedin") {
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => Homepage()));
        }

        if (email != "loggedin" && email == null) {
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => IntroScreen()));
        }
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      // backgroundColor: Color(0xfff5a623),
      backgroundColor: back1,
      body: Container(
          height: size.height * 1,
          width: MediaQuery.of(context).size.width,
          child: Padding(
            padding: const EdgeInsets.only(top: 100),
            child: Container(
                child: Column(children: [
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: CircleAvatar(
                  backgroundColor:back1,
                  child: Image(image: AssetImage("images/logo.png")),
                  radius: 150,
                ),
              ),
              SizedBox(
                height: size.height * 0.07,
              ),
              CircularProgressIndicator(
                strokeWidth: 5,
                backgroundColor: Colors.white,
              )
            ])),
          )),
    );
  }
}
