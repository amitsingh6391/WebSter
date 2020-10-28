import 'dart:convert';

import 'package:youtube/contant.dart';
import 'package:youtube/loginandsignup/profiledetail.dart';
import 'package:youtube/pages/homepage.dart';
import "package:flutter/material.dart";
import 'package:flutter/services.dart';
import "package:http/http.dart" as http;

import 'package:imei_plugin/imei_plugin.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:io';

class Loginpage extends StatefulWidget {
  @override
  _LoginpageState createState() => _LoginpageState();
}

class _LoginpageState extends State<Loginpage> {
  String _platformImei = 'Unknown';
  String uniqueId = "Unknown";
  String imei1;
  String imei2;
  TextEditingController phone = TextEditingController();
  TextEditingController password = TextEditingController();
  bool loading = false;

  //login    http://webster.wonsoft.co.in/API/Post.asmx/Login?IMEI1=1.0&IMEI2=1&TokenID=1

  //version    http://webster.wonsoft.co.in/API/Post.asmx/CheckVersion?name=1.0&code=1

  login(BuildContext context) async {
    if (phone.text.length > 9) {
      // String fcmToken = await firebaseMessaging.getToken();
      // print(fcmToken);

      setState(() {
        loading = true;
      });

      String apiUrl =
          "http://webster.wonsoft.co.in/API/Post.asmx/Login?IMEI1=$imei1&IMEI2=$imei2&TokenID=$uniqueId";

      final response = await http.get(apiUrl);

      var data = json.decode(response.body);
      String x = data[0]["Status"];
      String y = data[0]["Id"];
      String name = data[0]["Name"];
      String gender = data[0]["Gender"];
      String mobile = data[0]["Mobile"];
      String dob = data[0]["DOB"];
      String city = data[0]["City"];
      print("error");
      print(phone.text);
      print(data);
      // print("*********** status*******************$x");
      print("*************** Statuscode************$response.statusCode");
      print("***********response body *********** $response.body");

      print(response.body);
      if (x == "fail") {
        setState(() {
          loading = false;
        });
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => Userdetail(
                      id: y,
                      imei1: imei1,
                      imei2: imei2,
                    )));
      } else {
        SharedPreferences preferences = await SharedPreferences.getInstance();
        preferences.setString('email', "loggedin");

        preferences.setString('name', name);

        preferences.setString('mobile', mobile);

        preferences.setString('city', city);

        preferences.setString('dob', dob);
        preferences.setString('gender', gender);
        preferences.setString('imei1', imei1);

        preferences.setString('imei2', imei2);
        preferences.setString('id', y);

        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => Homepage(
                    // id: y,
                    // imei1: imei1,
                    // imei2: imei2,
                    // name: name,
                    // gender: gender,
                    // mobile: mobile,
                    // city: city,
                    // dob: dob
                    )));
      }
    } else {
      print("missing");
      showAlertDialog();
      setState(() {
        loading = false;
      });
      //  showAlertDialog();
    }
  }

  showAlertDialog() {
    Widget okbtn = FlatButton(
      child: Text("retry"),
      onPressed: () {
        Navigator.pop(context);
      },
    );

    AlertDialog alert = AlertDialog(
      title: Text("Failed"),
      content: Text("Please enter phone number and password"),
      actions: [okbtn],
    );

    showDialog(
        context: context,
        builder: (BuildContext context) {
          return alert;
        });
  }

  @override
  void initState() {
    super.initState();
    initPlatformState();
  }

  // Platform messages are asynchronous, so we initialize in an async method.
  Future<void> initPlatformState() async {
    String platformImei;
    String idunique;

    try {
      platformImei =
          await ImeiPlugin.getImei(shouldShowRequestPermissionRationale: false);
      List<String> multiImei = await ImeiPlugin.getImeiMulti();

      setState(() {
        imei1 = multiImei[0];
        imei2 = multiImei[1];
        print(imei1);
        print(imei2);
      });
      idunique = await ImeiPlugin.getId();
    } on PlatformException {
      platformImei = 'Failed to get platform version.';
    }

    if (!mounted) return;

    setState(() {
      _platformImei = platformImei;

      uniqueId = idunique;
    });
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
          backgroundColor: back1,
          appBar: AppBar(
            leading: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Image(image: AssetImage("images/logo.png")),
            ),
            backgroundColor: back1,
            title: Text("WebSter"),
          ),
          body: loading
              ? Center(child: CircularProgressIndicator())
              : Center(
                  child: Column(children: [
                  SizedBox(height: size.height * 0.16),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 25.0),
                    child: Text("SIGN IN", style: boldfont),
                  ),
                  Container(
                    margin: EdgeInsets.symmetric(vertical: 5),
                    padding: EdgeInsets.all(
                      10,
                    ),
                    width: size.width * 0.8,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(29),
                      boxShadow: [
                        BoxShadow(
                            color: Colors.grey.withOpacity(0.5),
                            spreadRadius: 5,
                            blurRadius: 7,
                            offset: Offset(0, 3))
                      ],
                    ),
                    child: TextField(
                      keyboardType: TextInputType.number,
                      controller: phone,
                      decoration: InputDecoration(
                          icon: Icon(Icons.phone_android),
                          hintText: "Enter phone no.",
                          border: InputBorder.none),
                    ),
                  ),
                  // Container(
                  //   margin: EdgeInsets.symmetric(vertical: 5),
                  //   padding: EdgeInsets.all(
                  //     10,
                  //   ),
                  //   width: size.width * 0.8,
                  //   decoration: BoxDecoration(
                  //     color: Colors.white,
                  //     borderRadius: BorderRadius.circular(29),
                  //     boxShadow: [
                  //       BoxShadow(
                  //           color: Colors.grey.withOpacity(0.5),
                  //           spreadRadius: 5,
                  //           blurRadius: 7,
                  //           offset: Offset(0, 3))
                  //     ],
                  //   ),
                  //   child: TextField(
                  //     obscureText: true,
                  //     // validator: (val) {
                  //     //   return val.length == 10 || val.length == 11
                  //     //       ? null
                  //     //       : "Enter Correct Password";
                  //     // },
                  //     controller: password,
                  //     decoration: InputDecoration(
                  //         icon: Icon(Icons.remove_red_eye),
                  //         hintText: "Password",
                  //         border: InputBorder.none),
                  //   ),
                  // ),
                  GestureDetector(
                    onTap: () {
                      login(context);
                    },
                    child: Padding(
                      padding: const EdgeInsets.all(28.0),
                      child: CircleAvatar(
                        radius: 30,
                        backgroundColor: Colors.white,
                        child: Icon(Icons.arrow_forward),
                      ),
                    ),
                  ),
                ])),
        ));
  }
}

// class Loginpage extends StatefulWidget {
//   @override
//   _LoginpageState createState() => _LoginpageState();
// }

// class _LoginpageState extends State<Loginpage> {
//   String _platformImei = 'Unknown';
//   String uniqueId = "Unknown";
//   String imei1;
//   String imei2;
//   TextEditingController phone = TextEditingController();
//   TextEditingController password = TextEditingController();
//   bool loading = false;

//   //login    http://webster.wonsoft.co.in/API/Post.asmx/Login?IMEI1=1.0&IMEI2=1&TokenID=1

//   //version    http://webster.wonsoft.co.in/API/Post.asmx/CheckVersion?name=1.0&code=1

//   login(BuildContext context) async {
//     if (phone.text.length > 9) {
//       print("y hamara imei number");
//       print(imei1);
//       print(imei2);

//       setState(() {
//         loading = true;
//       });

//       String apiUrl =
//           "https://webster.wonsoft.co.in/API/Post.asmx/Login?IMEI1=1.0&IMEI2=1&TokenID=1";

//       final response = await http.get(apiUrl);

//       var data = json.decode(response.body);
//       String x = data[0]["Status"];
//       String y = data[0]["Id"];
//       String name = data[0]["Name"];
//       String gender = data[0]["Gender"];
//       String mobile = data[0]["Mobile"];
//       String dob = data[0]["DOB"];
//       String city = data[0]["City"];
//       print("error");
//       print(phone.text);
//       print(data);
//       // print("*********** status*******************$x");
//       print("*************** Statuscode************$response.statusCode");
//       print("***********response body *********** $response.body");

//       print(response.body);
//       if (x == "fail") {
//         setState(() {
//           loading = false;
//         });
//         Navigator.push(
//             context,
//             MaterialPageRoute(
//                 builder: (context) => Userdetail(
//                       id: y,
//                       imei1: imei1,
//                       imei2: imei2,
//                     )));
//       } else {
//         SharedPreferences preferences = await SharedPreferences.getInstance();
//         preferences.setString('email', "loggedin");

//         preferences.setString('name', name);

//         preferences.setString('mobile', mobile);

//         preferences.setString('city', city);

//         preferences.setString('dob', dob);
//         preferences.setString('imei1', imei1);

//         preferences.setString('imei2', imei2);

//         Navigator.push(
//             context, MaterialPageRoute(builder: (context) => Homepage()));
//       }
//     } else {
//       print("missing");
//       showAlertDialog();
//       setState(() {
//         loading = false;
//       });
//       //  showAlertDialog();
//     }
//   }

//   showAlertDialog() {
//     Widget okbtn = FlatButton(
//       child: Text("retry"),
//       onPressed: () {
//         Navigator.pop(context);
//       },
//     );

//     AlertDialog alert = AlertDialog(
//       title: Text("Failed"),
//       content: Text("Please enter phone number and password"),
//       actions: [okbtn],
//     );

//     showDialog(
//         context: context,
//         builder: (BuildContext context) {
//           return alert;
//         });
//   }

//   @override
//   void initState() {
//     super.initState();
//     initPlatformState();
//   }

//   // Platform messages are asynchronous, so we initialize in an async method.
//   Future<void> initPlatformState() async {
//     String platformImei;
//     String idunique;

//     try {
//       platformImei =
//           await ImeiPlugin.getImei(shouldShowRequestPermissionRationale: false);
//       List<String> multiImei = await ImeiPlugin.getImeiMulti();

//       setState(() {
//         imei1 = multiImei[0];
//         imei2 = multiImei[1];
//         print(imei1);
//         print(imei2);
//       });
//       idunique = await ImeiPlugin.getId();
//     } on PlatformException {
//       platformImei = 'Failed to get platform version.';
//     }

//     if (!mounted) return;

//     setState(() {
//       _platformImei = platformImei;

//       uniqueId = idunique;
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     Size size = MediaQuery.of(context).size;
//     return Scaffold(
//       backgroundColor: back1,
//       appBar: AppBar(
//           leading: Text(""),
//           backgroundColor: back1,
//           title: Text("             WebSter")),
//       body: loading
//           ? Center(child: CircularProgressIndicator())
//           : Center(
//               child: Column(children: [
//               SizedBox(height: size.height * 0.16),
//               Padding(
//                 padding: const EdgeInsets.only(bottom: 25.0),
//                 child: Text("SIGN IN", style: boldfont),
//               ),
//               Container(
//                 margin: EdgeInsets.symmetric(vertical: 5),
//                 padding: EdgeInsets.all(
//                   10,
//                 ),
//                 width: size.width * 0.8,
//                 decoration: BoxDecoration(
//                   color: Colors.white,
//                   borderRadius: BorderRadius.circular(29),
//                   boxShadow: [
//                     BoxShadow(
//                         color: Colors.grey.withOpacity(0.5),
//                         spreadRadius: 5,
//                         blurRadius: 7,
//                         offset: Offset(0, 3))
//                   ],
//                 ),
//                 child: TextField(
//                   keyboardType: TextInputType.number,
//                   controller: phone,
//                   decoration: InputDecoration(
//                       icon: Icon(Icons.phone_android),
//                       hintText: "Enter phone no.",
//                       border: InputBorder.none),
//                 ),
//               ),
//               GestureDetector(
//                 onTap: () {
//                   login(context);
//                 },
//                 child: Padding(
//                   padding: const EdgeInsets.all(28.0),
//                   child: CircleAvatar(
//                     radius: 30,
//                     backgroundColor: Colors.white,
//                     child: Icon(Icons.arrow_forward),
//                   ),
//                 ),
//               ),
//             ])),
//     );
//   }
// }
