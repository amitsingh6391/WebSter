import 'package:youtube/contant.dart';
import 'package:flutter/cupertino.dart';
import "package:flutter/material.dart";

import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:esys_flutter_share/esys_flutter_share.dart';
import 'package:youtube/pages/Account.dart';

class NavDrawer extends StatefulWidget {
  // String name, dob, gender, mobile, city;
  // NavDrawer({this.name, this.gender, this.dob, this.mobile, this.city});
  @override
  _NavDrawerState createState() => _NavDrawerState();
}

class _NavDrawerState extends State<NavDrawer> {
  launchurl() async {
    const url =
        "https://play.google.com/store/apps/details?id=com.academic.master";
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw "could not launch $url";
    }
  }

  Future<void> sharelink() async {
    try {
      Share.text(
          'WebSter',
          'https://play.google.com/store/apps/details?id=com.academic.master',
          'text/plain');
    } catch (e) {
      print('error: $e');
    }
  }

  String name, dob, mobile, city;

  @override
  void initState() {
    // TODO: implement initState
    getdata();
    super.initState();
  }

  getdata() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();

    setState(() {
      name = preferences.getString('name');
      mobile = preferences.getString('mobile');
      city = preferences.getString('city');
      dob = preferences.getString('dob');
    });
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        children: <Widget>[
          DrawerHeader(
            child: Center(
                child: Column(children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  children: [
                    Image(
                      image: AssetImage("images/logo.png"),
                      height: 50,
                      width: 50,
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text("WebSter", style: boldfont),
                    ),
                  ],
                ),
              ),

              GestureDetector(
                  onTap: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => Account()));
                  },
                  child: Icon(Icons.person, size: 70, color: Colors.white))
              // Row(
              //   children: [
              //     Padding(
              //       padding: const EdgeInsets.all(4.0),
              //       child: Icon(Icons.person, color: Colors.white),
              //     ),
              //     Text(name,
              //         style: TextStyle(fontSize: 20, color: Colors.white)),
              //     SizedBox(width: 50),
              //     Padding(
              //       padding: const EdgeInsets.all(4.0),
              //       child: Icon(Icons.mobile_friendly, color: Colors.white),
              //     ),
              //     Text(mobile,
              //         style: TextStyle(fontSize: 20, color: Colors.white))
              //   ],
              // ),
              // Row(
              //   children: [
              //     Padding(
              //       padding: const EdgeInsets.all(4.0),
              //       child: Icon(Icons.home, size: 20, color: Colors.white),
              //     ),
              //     Text(city,
              //         style: TextStyle(fontSize: 20, color: Colors.white)),
              //     SizedBox(width: 10),
              //     Padding(
              //       padding: const EdgeInsets.all(4.0),
              //       child:
              //           Icon(Icons.date_range, size: 20, color: Colors.white),
              //     ),
              //     Text(dob, style: TextStyle(fontSize: 20, color: Colors.white))
              //   ],
              // )
            ])),
            decoration: BoxDecoration(color: back1),
          ),
          Container(
            color: back1,
            child: ListTile(
              leading: Icon(
                Icons.star,
                color: Colors.white,
              ),
              title: Text(
                "Rate us",
                style: TextStyle(color: Colors.white),
              ),
              onTap: () {
                launchurl();
              },
            ),
          ),
          Container(
            color: back1,
            child: ListTile(
              leading: Icon(Icons.share, color: Colors.white),
              title: Text(
                "Share",
                style: TextStyle(color: Colors.white),
              ),
              onTap: () {
                sharelink();
              },
            ),
          ),
          Container(
            color: back1,
            child: ListTile(
              leading: Icon(Icons.security, color: Colors.white),
              title: Text(
                "privacy",
                style: TextStyle(color: Colors.white),
              ),
              onTap: () {
                // Navigator.push(context,
                //     MaterialPageRoute(builder: (context) => Privacy()));
              },
              //trailing: Icon(Icons.dashboard),
            ),
          ),
          Container(
            color: back1,
            child: ListTile(
              leading: Icon(Icons.update, color: Colors.white),
              title: Text(
                "Update app",
                style: TextStyle(color: Colors.white),
              ),
              onTap: () {
                launchurl();
              },
            ),
          ),
          Container(color: back1, height: 4900)
        ],
      ),
    );
  }
}
