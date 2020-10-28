import 'package:youtube/contant.dart';
import 'package:youtube/pages/videotile.dart';
import 'package:flutter/material.dart';

import "package:http/http.dart" as http;

import 'dart:convert';

class Videolist extends StatefulWidget {
  String id, title;
  Videolist({@required this.id, this.title});

  @override
  _VideolistState createState() => _VideolistState();
}

class _VideolistState extends State<Videolist> {
  List video;
  var ID;
  var x;
  @override
  void initState() {
    ID = widget.id;

    x = widget.title;
    print(ID);

    super.initState();
    fetchvideo();
  }

  Future fetchvideo() async {
    http.Response response = await http
        .get("http://webster.wonsoft.co.in/API/Post.asmx/GetVideos?ID=$ID");
    video = json.decode(response.body);
    print(response.statusCode);
    print("hii");

    print(video);

    if (response.statusCode == 200) {
      print(response.statusCode);
      print("video");

      print(video);

      setState(() {
        video = video;
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
    return Scaffold(
        backgroundColor: back1,
        appBar: AppBar(
          title: Text("$x", style: boldfont),
          backgroundColor: back1,
        ),
        body: SingleChildScrollView(
            child: Column(children: [
          SizedBox(height: 50),
          Container(
              child: video.length < 1
                  ? Center(
                      child: Column(children: [
                      SizedBox(
                        height: 200,
                      ),
                      Text("", style: thinfont)
                    ]))
                  : ListView.builder(
                      reverse: true,
                      physics: NeverScrollableScrollPhysics(),
                      padding: EdgeInsets.symmetric(horizontal: 16),
                      shrinkWrap: true,
                      itemCount: video == null ? 0 : video.length,
                      itemBuilder: (context, index) {
                        var x = video[index]["URL"];
                        var y = x.substring(x.length - 11);
                        print(y);

                        return Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Container(
                              child: Column(children: [
                                Row(children: [
                                  GestureDetector(
                                    onTap: () {
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) => Videotile(
                                                    url: video[index]["URL"],
                                                  )));
                                    },
                                    child: Container(
                                        height: size.height * 0.35,
                                        width: size.width * 0.85,
                                        child: Image.network(
                                            "https://img.youtube.com/vi/$y/0.jpg",
                                            fit: BoxFit.fill)),
                                  ),
                                ]),
                                Padding(
                                  padding: const EdgeInsets.all(18.0),
                                  child: Text(
                                    video[index]["Title"],
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 20,
                                    ),
                                  ),
                                )
                              ]),
                            ));
                      },
                    ))
        ])));
  }
}
