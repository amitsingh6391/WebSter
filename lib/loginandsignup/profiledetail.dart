// update   http://webster.wonsoft.co.in/API/Post.asmx/Update?IMEI1=867287036409857&IMEI2=867287036409840&Name=Jitesh%20Garg&Gender=Male&Mobile=9828172013&DOB=26-06-1983&City=Jodhpur

//login  http://webster.wonsoft.co.in/API/Post.asmx/Login?IMEI1=867287036409857&IMEI2=867287036409840&TokenID=e16KVWMqHkg:APA91bFfDzg9MYFsYh02C2PLTW_nPI27AOSmldPhnVWWJwmi01zEOWY90dTn7nAvneynqrgVsNF0C03Yt

//logout   http://webster.wonsoft.co.in/API/Post.asmx/Logout?IMEI1=867287036409857&IMEI2=867287036409840

//versin   http://webster.wonsoft.co.in/API/Post.asmx/CheckVersion?name=1.0&code=1

// http://webster.wonsoft.co.in/API/Post.asmx/Login?IMEI1=1.0&IMEI2=1&TokenID=1

import 'dart:convert';

import 'package:youtube/contant.dart';
import 'package:youtube/loginandsignup/loginpgae.dart';
import 'package:youtube/pages/homepage.dart';
import 'package:flutter/cupertino.dart';
import "package:flutter/material.dart";
import "package:http/http.dart" as http;

class Userdetail extends StatefulWidget {
  String id, imei1, imei2;
  Userdetail({@required this.id, @required this.imei1, @required this.imei2});
  @override
  _UserdetailState createState() => _UserdetailState();
}

class _UserdetailState extends State<Userdetail> {
  TextEditingController name = new TextEditingController();
  TextEditingController gender = new TextEditingController();
  TextEditingController mobile = new TextEditingController();

  TextEditingController city = new TextEditingController();
  String dob;
  bool loading = false;
  final formKey = GlobalKey<FormState>();
  String IMEI1, IMEI2;

  var username, usergender, usermobile, usercity;

  @override
  void initState() {
    super.initState();
    print(widget.imei1);
    print(widget.imei2);
    IMEI1 = widget.imei1;
    IMEI2 = widget.imei2;
  }

  updateprofile(BuildContext context) async {
    if (formKey.currentState.validate()) {
      String apiUrl =
          "http://webster.wonsoft.co.in/API/Post.asmx/Update?IMEI1=$IMEI1&IMEI2=$IMEI2&Name=$username&Gender=$usergender&Mobile=$usermobile&DOB=$dob&City=$usercity";

      print(
          "http://webster.wonsoft.co.in/API/Post.asmx/Update?IMEI1=$IMEI1&IMEI2=$IMEI2&Name=$username&Gender=$usergender&Mobile=$usermobile&DOB=$dob&City=$usercity");
      http.Response response = await http.get(
        apiUrl,
      );

      var x = response.body;
      print(response.body);

      if (x == "[{'Status':'Done'}]") {
        setState(() {
          loading = false;
        });
        // Navigator.push(
        //     context,
        //     MaterialPageRoute(
        //         builder: (context) => Loginpage(
        //             // id: y,

        //             )));
        showloginmessage();
      } else {
        showservererror();
      }
    } else {
      showAlertDialog();
    }
  }

  bool com = false;

//showloginmessage

  showloginmessage() {
    Widget okbtn = FlatButton(
      child: Text("Sign in"),
      onPressed: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => Loginpage(
                    // id: y,

                    )));
      },
    );

    AlertDialog alert = AlertDialog(
      backgroundColor: back1,
      title: Text(""),
      content: Text("Your Account is Successfully Updated Please Sign in Now .",
          style: thinfont),
      actions: [okbtn],
    );

    showDialog(
        context: context,
        builder: (BuildContext context) {
          return alert;
        });
  }

  showservererror() {
    Widget okbtn = FlatButton(
      child: Text("retry"),
      onPressed: () {
        Navigator.pop(context);
      },
    );

    AlertDialog alert = AlertDialog(
      title: Text("Failed"),
      content: Text("Internal server error"),
      actions: [okbtn],
    );

    showDialog(
        context: context,
        builder: (BuildContext context) {
          return alert;
        });
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
      content: Text("Please fill eah filled"),
      actions: [okbtn],
    );

    showDialog(
        context: context,
        builder: (BuildContext context) {
          return alert;
        });
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: back1,
      resizeToAvoidBottomPadding: false,
      appBar: AppBar(
          title: Text("Update Your profile details", style: thinfont),
          backgroundColor: back1),
      body: SingleChildScrollView(
        child: Container(
          width: size.width * 1,
          child: Column(
            children: [
              SizedBox(height: size.height * 0.1),
              SingleChildScrollView(
                child: Container(
                  padding: EdgeInsets.only(left: 20, right: 20),
                  child: Form(
                    key: formKey,
                    child: Column(
                      children: [
                        Column(
                          children: <Widget>[
                            Container(
                              margin: EdgeInsets.symmetric(vertical: 10),
                              padding: EdgeInsets.symmetric(
                                horizontal: 10,
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
                                  ]),
                              child: TextFormField(
                                onChanged: (value) {
                                  setState(() {
                                    username = value;
                                  });
                                },
                                validator: (val) {
                                  return val.length > 2
                                      ? null
                                      : "Enter user name 2+ char";
                                },
                                controller: name,
                                decoration: InputDecoration(
                                    icon: Icon(Icons.person),
                                    hintText: "Name",
                                    border: InputBorder.none),
                              ),
                            ),
                            Container(
                              margin: EdgeInsets.symmetric(vertical: 5),
                              padding: EdgeInsets.symmetric(
                                horizontal: 10,
                              ),
                              width: size.width * 0.8,
                              decoration: BoxDecoration(
                                color: Colors.white,
                                boxShadow: [
                                  BoxShadow(
                                      color: Colors.grey.withOpacity(0.5),
                                      spreadRadius: 5,
                                      blurRadius: 7,
                                      offset: Offset(0, 3))
                                ],
                                borderRadius: BorderRadius.circular(29),
                              ),
                              child: TextFormField(
                                onChanged: (value) {
                                  setState(() {
                                    usergender = value;
                                  });
                                },
                                validator: (val) {
                                  return val.length > 1
                                      ? null
                                      : "Enter valid gender";
                                },
                                controller: gender,
                                decoration: InputDecoration(
                                    icon: Icon(Icons.person_add),
                                    hintText: "Gender",
                                    border: InputBorder.none),
                              ),
                            ),
                            Container(
                              margin: EdgeInsets.symmetric(vertical: 5),
                              padding: EdgeInsets.symmetric(
                                horizontal: 10,
                              ),
                              width: size.width * 0.8,
                              decoration: BoxDecoration(
                                color: Colors.white,
                                boxShadow: [
                                  BoxShadow(
                                      color: Colors.grey.withOpacity(0.5),
                                      spreadRadius: 5,
                                      blurRadius: 7,
                                      offset: Offset(0, 3))
                                ],
                                borderRadius: BorderRadius.circular(29),
                              ),
                              child: TextFormField(
                                onChanged: (value) {
                                  setState(() {
                                    usermobile = value;
                                  });
                                },
                                keyboardType: TextInputType.number,
                                validator: (val) {
                                  return val.length == 10
                                      ? null
                                      : "Enter valid  mobile number";
                                },
                                controller: mobile,
                                decoration: InputDecoration(
                                    icon: Icon(Icons.phone_android),
                                    hintText: "Mobile No.",
                                    border: InputBorder.none),
                              ),
                            ),
                          ],
                        ),
                        Container(
                          margin: EdgeInsets.symmetric(vertical: 5),
                          padding: EdgeInsets.symmetric(
                            horizontal: 10,
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
                          child: TextFormField(
                            onChanged: (value) {
                              setState(() {
                                usercity = value;
                              });
                            },
                            validator: (val) {
                              return val.length > 2
                                  ? null
                                  : "Enter Correct City name";
                            },
                            controller: city,
                            decoration: InputDecoration(
                                icon: Icon(Icons.location_city),
                                hintText: "City",
                                border: InputBorder.none),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text("Select your DOB", style: thinfont),
                        ),
                        Container(
                            decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius:
                                    BorderRadiusDirectional.circular(30)),
                            height: 100,
                            child: CupertinoDatePicker(
                                mode: CupertinoDatePickerMode.date,
                                initialDateTime: DateTime(1997, 1, 1),
                                onDateTimeChanged: (DateTime newDateTime) {
                                  setState(() {
                                    dob = newDateTime.toString();
                                  });
                                  print(newDateTime.toString());
                                })),
                      ],
                    ),
                  ),
                ),
              ),
              com ? CircularProgressIndicator() : Text(""),
              GestureDetector(
                onTap: () {
                  updateprofile(context);
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
            ],
          ),
        ),
      ),
    );
  }
}
