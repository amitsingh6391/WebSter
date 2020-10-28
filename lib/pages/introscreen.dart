import 'dart:io';

import 'package:youtube/contant.dart';
import 'package:youtube/loginandsignup/loginpgae.dart';
import 'package:youtube/pages/homepage.dart';
import "package:flutter/material.dart";
import 'package:intro_slider/intro_slider.dart';
import 'package:intro_slider/slide_object.dart';
import 'package:shared_preferences/shared_preferences.dart';

class IntroScreen extends StatefulWidget {
  @override
  IntroScreenState createState() => new IntroScreenState();
}

class IntroScreenState extends State<IntroScreen> {
  List<Slide> slides = new List();

  getintro() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    preferences.setString('email', "introcomp");
  }

  @override
  void initState() {
    getintro();

    super.initState();

    slides.add(
      new Slide(
        title: "Webster",
        description: "WebSter A New Way of Learning",
        pathImage: "images/intro1.png",
        backgroundColor: back1,
      ),
    );
    slides.add(
      new Slide(
        title: "Watch live video tutriols",
        description: "See Your All Your fav..",
        pathImage: "images/intro3.jpg",
        backgroundColor: back2,
      ),
    );
    slides.add(
      new Slide(
        title: "Easy To Access",
        description: "So Let's Start With WebSter",
        pathImage: "images/intro2.jpg",
        backgroundColor: back1,
      ),
    );
  }

  void onDonePress() {
// Do what you want

    //Splashscreen();
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => Loginpage()));
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () {
        return showDialog(
            context: context,
            barrierDismissible: false,
            builder: (BuildContext context) {
              return AlertDialog(
                title: Text("Confirm Exit"),
                content: Text("Are you sure you want to exit?"),
                actions: <Widget>[
                  FlatButton(
                    child: Text("YES"),
                    onPressed: () {
                      exit(0);
                    },
                  ),
                  FlatButton(
                    child: Text("NO"),
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                  )
                ],
              );
            });
      },
      child: new IntroSlider(
        slides: this.slides,
        onDonePress: this.onDonePress,
      ),
    );
  }
}
