import "package:flutter/material.dart";
import 'package:youtube_player_flutter/youtube_player_flutter.dart';
import 'package:youtube/contant.dart';

class Videotile extends StatefulWidget {
  String url;
  Videotile({@required this.url});

  @override
  _VideotileState createState() => _VideotileState();
}

class _VideotileState extends State<Videotile> {
  YoutubePlayerController _controller;

  @override
  void initState() {
    print(widget.url);
    _controller = YoutubePlayerController(
      initialVideoId: YoutubePlayer.convertUrlToId(widget.url),
      flags: YoutubePlayerFlags(
        autoPlay: true, 
        mute: false,
        
//forceHideAnnotation:true,
        disableDragSeek: true,
        loop: false,
        isLive: false,
        forceHD: false,
        enableCaption: true,
        ),
    );

    super.initState();
  }

    @override
  void deactivate() {
    _controller.pause();
    super.deactivate();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return
              YoutubePlayer(
                //aspectRatio: 16 / 32,
               
                 progressIndicatorColor: Colors.blueAccent,
      topActions: <Widget>[
        SizedBox(width: 8.0),
        Expanded(
          child: Text(
            _controller.metadata.title,
            style: TextStyle(
              color: Colors.white,
              fontSize: 18.0,
            ),
            overflow: TextOverflow.ellipsis,
            maxLines: 1,
          ),
        ),
      ],
                controller: _controller,
                showVideoProgressIndicator: true,
                onReady: () {
                  print("Ready");
                },
            
          
        );
  }
}


