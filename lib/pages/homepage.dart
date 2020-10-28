import 'dart:convert';
import 'dart:io';

import 'package:youtube/contant.dart';
import 'package:youtube/loginandsignup/loginpgae.dart';
import 'package:youtube/pages/Account.dart';
import 'package:youtube/pages/navdrawer.dart';
import 'package:youtube/pages/video.dart';
import 'package:flutter/material.dart';
import "package:http/http.dart" as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:carousel_slider/carousel_slider.dart';

//http://webster.wonsoft.co.in/API/Post.asmx/Logout?IMEI1=867287036409857&IMEI2=867287036409840
//http://webster.wonsoft.co.in/API/Post.asmx/GetBanner?IMEI1=867287036409857&IMEI2=867287036409840

class Homepage extends StatefulWidget {
  @override
  _HomepageState createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  String IMEI1, IMEI2;

  @override
  void initState() {
    super.initState();
    getdata();
  }

  getdata() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();

    setState(() {
      IMEI1 = preferences.getString('imei1');
      IMEI2 = preferences.getString('imei2');
      print("*************$IMEI2***********");
      print("*************$IMEI1***********");
      fetchcat();
      fetchdata();
    });
  }

  logout() async {
    String apiUrl =
        "http://webster.wonsoft.co.in/API/Post.asmx/Logout?IMEI1=$IMEI1&IMEI2=$IMEI2";

    final response = await http.get(apiUrl);

//var data = json.decode(response.body)    ;

    SharedPreferences preferences = await SharedPreferences.getInstance();
    preferences.setString('email', "introcomp");

    print(response.body);

    print("*************** Statuscode************$response.statusCode");
    print("***********response body *********** $response.body");

    Navigator.pushReplacement(
        context, MaterialPageRoute(builder: (context) => Loginpage()));
    //showAlertDialog();
  }

//showlogoutalert

  showAlertlogout() {
    Widget okbtn = FlatButton(
      child: Text("OK"),
      onPressed: () {
        logout();
      },
    );
    Widget nobtn = FlatButton(
      child: Text("no"),
      onPressed: () {
        Navigator.pop(context);
      },
    );

    AlertDialog alert = AlertDialog(
      backgroundColor: back1,
      title: Text(""),
      content: Text("Are You sure You want logout?", style: thinfont),
      actions: [okbtn, nobtn],
    );

    showDialog(
        context: context,
        builder: (BuildContext context) {
          return alert;
        });
  }

  // showAlertDialog() {
  //   Widget okbtn = FlatButton(
  //     child: Text("OK"),
  //     onPressed: () {
  //       Navigator.pushReplacement(
  //           context, MaterialPageRoute(builder: (context) => Loginpage()));
  //     },
  //   );

  //   AlertDialog alert = AlertDialog(
  //     backgroundColor: back1,
  //     title: Text(""),
  //     content: Text(
  //       "You are Successfully Logout",
  //       style: thinfont,
  //     ),
  //     actions: [okbtn],
  //   );

  //   showDialog(
  //       context: context,
  //       builder: (BuildContext context) {
  //         return alert;
  //       });
  // }

  List banners;
  List category;

  Future fetchdata() async {
    print("888888888888888888888888888888*************$IMEI2***********");
    print("888888888888888888888888888888*************$IMEI1***********");

    print(IMEI2);
    http.Response response = await http.get(
        "http://webster.wonsoft.co.in/API/Post.asmx/GetBanner?IMEI1=$IMEI1&IMEI2=$IMEI2");
    banners = json.decode(response.body);
    print(response.statusCode);
    print("hii");

    print(banners);

    if (response.statusCode == 200) {
      print(response.statusCode);
      print("bnners");

      print(banners);

      //print(pendingitem[0]["transaction_uid"]);
    } else {
      print("345");
    }
  }

  Future fetchcat() async {
    http.Response response = await http.get(
        "http://webster.wonsoft.co.in/API/Post.asmx/GetCat?IMEI1=$IMEI1&IMEI2=$IMEI2");
    category = json.decode(response.body);
    print(response.statusCode);
    print("hii");

    print(category);

    if (response.statusCode == 200) {
      print(response.statusCode);
      print("category");

      print(category);

      setState(() {
        category = category;
        // print(allitem);
      });

      //print(pendingitem[0]["transaction_uid"]);
    } else {
      print("345");
    }
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return WillPopScope(
      onWillPop: () {
        return showDialog(
            context: context,
            barrierDismissible: false,
            builder: (BuildContext context) {
              return AlertDialog(
                backgroundColor: back1,
                title: Text("", style: TextStyle(color: Colors.white)),
                content: Text("Are you sure you want to exit?",
                    style: TextStyle(color: Colors.white)),
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
      child: Scaffold(
          drawer: NavDrawer(),
          backgroundColor: back2,
          appBar: AppBar(
            // leading: Icon(Icons.menu, color: Colors.white),

            backgroundColor: back1,
            title: Image(image: AssetImage("images/logo1.png")),
            actions: [
              IconButton(
                icon: Icon(Icons.logout),
                onPressed: () {
                  showAlertlogout();
                },
              )
            ],
          ),
          body: SingleChildScrollView(
              child: Column(children: [
            SizedBox(height: 20),
            banners == null
                ? Container()
                : CarouselSlider(
                    options: CarouselOptions(
                        height: size.height * 0.17,
                        autoPlay: true,
                        autoPlayInterval: Duration(seconds: 3),
                        autoPlayAnimationDuration: Duration(milliseconds: 800),
                        autoPlayCurve: Curves.fastOutSlowIn,
                        enlargeCenterPage: true,
                        scrollDirection: Axis.horizontal),
                    items: banners.map((i) {
                      return Builder(
                        builder: (BuildContext context) {
                          return GestureDetector(
                            child: Container(
                                width: MediaQuery.of(context).size.width,
                                margin: EdgeInsets.symmetric(horizontal: 5.0),
                                decoration: BoxDecoration(color: back1),
                                child: Image(
                                    image: NetworkImage(i), fit: BoxFit.fill)),
                          );
                        },
                      );
                    }).toList(),
                  ),
            category == null
                ? Center(
                    child: Column(children: [
                    SizedBox(
                      height: 200,
                    ),
                    CircularProgressIndicator(
                      strokeWidth: 5,
                      backgroundColor: Colors.white,
                    )
                  ]))
                : ListView.builder(
                    reverse: true,
                    physics: NeverScrollableScrollPhysics(),
                    padding: EdgeInsets.symmetric(horizontal: 16),
                    shrinkWrap: true,
                    itemCount: category == null ? 0 : category.length,
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Container(
                            child: Column(
                          children: [
                            Row(children: [
                              Container(
                                  height: 100,
                                  width: 100,
                                  child: Image(
                                      image: NetworkImage(
                                          category[index]["Path"]))),
                              Column(children: [
                                GestureDetector(
                                  onTap: () {
                                    var id = category[index]["ID"];
                                    var title = category[index]["Name"];
                                    print(id);

                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) => Videolist(
                                                id: id, title: title)));
                                  },
                                  child: Padding(
                                    padding: const EdgeInsets.only(left: 38.0),
                                    child: Text(
                                      category[index]["Name"],
                                      style: TextStyle(
                                          color: Colors.white, fontSize: 20),
                                    ),
                                  ),
                                ),
                              ])
                            ]),
                          ],
                        )),
                      );
                    },
                  )
          ]))),
    );
  }
}
