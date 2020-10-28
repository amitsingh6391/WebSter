import "package:flutter/material.dart";
import "package:flutter/cupertino.dart";
import 'package:flutter/src/widgets/basic.dart';
import 'package:flutter/src/widgets/basic.dart';
import 'package:flutter/src/widgets/basic.dart';
import 'package:flutter/src/widgets/basic.dart';
import 'package:flutter/src/widgets/basic.dart';
import "package:flutter_colorpicker/flutter_colorpicker.dart";

final formKey = GlobalKey<FormState>();

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(debugShowCheckedModeBanner: false, home: Step1());
  }
}

class Step1 extends StatefulWidget {
  @override
  _Step1State createState() => _Step1State();
}

class _Step1State extends State<Step1> {
  TextEditingController name = new TextEditingController();
  TextEditingController address = new TextEditingController();

  Color pickerColor = Color(0xff443a49);
  Color currentColor = Color(0xff443a49);
  List<String> state = [
    "Andhra Pradesh",
    "Assam",
    "Arunachal Pradesh",
    "Bihar",
    "Goa",
    "Gujarat",
    "Jammu and Kashmir",
    "Jharkhand,"
        "West Bengal",
    "Karnatak",
    "Kerala,",
    "Madhya Pradesh",
    "Maharashtra",
    "Manipur",
    "Meghalaya",
    "Mizoram",
    "Nagaland",
    "Orissa",
    "Punjab",
    "Rajasthan",
    "Sikkim",
    "Tamil Nadu",
    "Tripura",
    "Uttaranchal",
    "Uttar Pradesh",
    "Haryana",
    "Himachal Pradesh",
    "Chhattisgarh"
  ];
  String x;
  var favcolor;

  void changeColor(Color color) {
    setState(() {
      pickerColor = color;
      favcolor = pickerColor;

      // print(pickerColor.toString());
    });
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
        appBar: AppBar(
          title: Text("Demo test"),
          backgroundColor: Color(0xFF8d0101),
        ),
        body: SingleChildScrollView(
            child: Column(children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text("Demo Test",
                style: TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                    color: Colors.black)),
          ),
          Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                  padding: EdgeInsets.only(left: 20, right: 20),
                  child: Form(
                      key: formKey,
                      child: Column(children: [
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
                            validator: (val) {
                              return val.length > 2 ? null : "Enter your name";
                            },
                            controller: name,
                            decoration: InputDecoration(
                                icon: Icon(Icons.person),
                                hintText: "Enter your name",
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
                            maxLines: 3,
                            validator: (val) {
                              return val.length > 3
                                  ? null
                                  : "Enter Your Address";
                            },
                            controller: address,
                            decoration: InputDecoration(
                                icon: Icon(Icons.home),
                                hintText: "Enter your address",
                                border: InputBorder.none),
                          ),
                        ),
                        SizedBox(height: 10),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text("Select your DOB"),
                        ),
                        Container(
                            height: 100,
                            child: CupertinoDatePicker(
                                mode: CupertinoDatePickerMode.date,
                                initialDateTime: DateTime(1997, 1, 1),
                                onDateTimeChanged: (DateTime newDateTime) {
                                  print(newDateTime.toString());
                                })),
                        SizedBox(height: 20),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            children: [
                              DropdownButton(
                                hint: Text(
                                    'Please choose Your State'), // Not necessary for Option 1
                                value: x,
                                onChanged: (newValue) {
                                  setState(() {
                                    x = newValue;
                                  });
                                },
                                items: state.map((location) {
                                  return DropdownMenuItem(
                                    child: new Text(location),
                                    value: location,
                                  );
                                }).toList(),
                              ),
                              SizedBox(height: 20),
                              Padding(
                                padding: const EdgeInsets.all(4.0),
                                child: Text("Select your Faviorte Color"),
                              ),
                              Padding(
                                  padding: const EdgeInsets.all(28.0),
                                  child: ColorPicker(
                                    pickerColor: pickerColor,
                                    onColorChanged: changeColor,
                                    showLabel: true,
                                    pickerAreaHeightPercent: 0.8,
                                  )),
                              GestureDetector(
                                onTap: () {
                                  if (formKey.currentState.validate()) {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) => Secondscreen(
                                                name: name.text,
                                                fav: favcolor)));
                                  }
                                },
                                child: Padding(
                                  padding: const EdgeInsets.all(28.0),
                                  child: CircleAvatar(
                                    radius: 30,
                                    backgroundColor: Colors.red,
                                    child: Icon(Icons.arrow_forward),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        )
                      ]))))
        ])));
  }
}

class Secondscreen extends StatelessWidget {
  String name;
  var fav;
  Secondscreen({@required this.name, @required this.fav});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: fav,
        body: Center(
            child: Text(name,
                style: TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                    color: Colors.black))));
  }
}
