import 'package:flutter/material.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class video extends StatefulWidget {
  final videoUrl;
  const video({Key? key, this.videoUrl}) : super(key: key);

  @override
  _videoState createState() => _videoState();
}

class _videoState extends State<video> {
  late YoutubePlayerController _controller;

  @override
  void initState() {
    String? videoId = YoutubePlayer.convertUrlToId(widget.videoUrl);
    _controller = YoutubePlayerController(
      initialVideoId: videoId!,
      flags: YoutubePlayerFlags(
          autoPlay: false,
          mute: false,
          disableDragSeek: false,
          loop: false,
          isLive: false,
          forceHD: false),
    );

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: YoutubePlayer(
        controller: _controller,
        showVideoProgressIndicator: true,
        progressIndicatorColor: Colors.amber,
        // videoProgressIndicatorColor: Colors.amber,

        onReady: () {
          //  _controller.addListener(listener);
        },
      ),
    );
  }
}
