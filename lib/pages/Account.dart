import 'package:shared_preferences/shared_preferences.dart';
import 'package:youtube/contant.dart';
import "package:flutter/material.dart";
import 'package:youtube/loginandsignup/loginpgae.dart';
import 'package:youtube/loginandsignup/profiledetail.dart';

class Account extends StatefulWidget {
  @override
  _AccountState createState() => _AccountState();
}

class _AccountState extends State<Account> {
  String name, city, gender, dob, mobile, id, iemi1, iemi2;

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
      gender = preferences.getString('gender');
      id = preferences.getString('id');
      iemi1 = preferences.getString('imei1');
      iemi2 = preferences.getString('imei2');
    });
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: back1,
      body: SingleChildScrollView(
        child: Container(
          width: size.width * 1,
          child: Column(
            children: <Widget>[
              Container(
                color: back1,
                width: size.width * 1,
                child: Align(
                  alignment: Alignment.topCenter,
                  child: Padding(
                    padding: const EdgeInsets.only(top: 66.0),
                    child: Text("PROFILE",
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 20,
                            fontWeight: FontWeight.bold)),
                  ),
                ),
              ),
              Container(
                color: back1,
                // height: size.height * 0.4,
                width: size.width * 1,
                child: Stack(
                  children: [
                    Container(
                      height: size.height * 0.235,
                      width: size.width * 1,
                      child: Container(
                        decoration: BoxDecoration(
                          color: back1,
                        ),
                      ),
                    ),
                    Align(
                      alignment: Alignment.center,
                      child: Padding(
                        padding: const EdgeInsets.all(18.0),
                        child: Container(
                          // height: size.height * 0.3,
                          width: size.width * 1,
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(30),
                              boxShadow: [
                                BoxShadow(
                                    color: Colors.grey.withOpacity(0.5),
                                    spreadRadius: 5,
                                    blurRadius: 7,
                                    offset: Offset(0, 3))
                              ]),
                          child: Container(
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(30)),
                            child: Column(
                              children: [
                                SizedBox(height: size.height * 0.05),
                                Row(children: [
                                  SizedBox(width: size.width * 0.28),
                                  CircleAvatar(
                                    radius: size.width * 0.15,
                                    backgroundImage:
                                        AssetImage("images/logo.png"),
                                  ),
                                ]),
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Text(name,
                                      style: TextStyle(
                                          fontSize: 20,
                                          fontWeight: FontWeight.bold)),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Text(mobile,
                                      style: TextStyle(
                                          fontSize: 15,
                                          fontWeight: FontWeight.bold)),
                                ),
                                SizedBox(height: 10)
                              ],
                            ),
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              ),
              // SizedBox(
              //   height: size.height * 0.,
              // ),
              Container(
                  width: size.width * 1,
                  child: Column(
                    children: [
                      Row(
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: CircleAvatar(
                                backgroundColor: Colors.white,
                                radius: 25,
                                child: Icon(Icons.person, color: Colors.black)),
                          ),
                          SizedBox(width: size.width * 0.05),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text("City  :  $city", style: thinfont),
                          )
                        ],
                      ),
                      Row(
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: CircleAvatar(
                                backgroundColor: Colors.white,
                                radius: 25,
                                child: Icon(Icons.hotel, color: Colors.black)),
                          ),
                          SizedBox(width: size.width * 0.05),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text("Gender  :  $gender", style: thinfont),
                          )
                        ],
                      ),
                      //  SizedBox(height: size.height * 0.04),
                      Row(
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: CircleAvatar(
                                backgroundColor: Colors.white,
                                radius: 25,
                                child: Icon(Icons.watch_later,
                                    color: Colors.black)),
                          ),
                          SizedBox(width: size.width * 0.05),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text("DOB   :  $dob", style: thinfont),
                          )
                        ],
                      ),

                      // SizedBox(height: size.height * 0.04),
                      GestureDetector(
                        onTap: () async {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => Userdetail(
                                        id: id,
                                        imei1: iemi1,
                                        imei2: iemi2,
                                      )));
                        },
                        child: Row(
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: CircleAvatar(
                                  backgroundColor: Colors.white,
                                  radius: 25,
                                  child: Icon(Icons.edit, color: Colors.black)),
                            ),
                            SizedBox(width: size.width * 0.05),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text("Edit Profile", style: thinfont),
                            )
                          ],
                        ),
                      ),
                    ],
                  ))
            ],
          ),
        ),
      ),
    );
  }
}
