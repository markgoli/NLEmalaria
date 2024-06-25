import 'package:flick_video_player/flick_video_player.dart';
import 'package:flutter/material.dart';
import 'package:nle4malaria/styles/color.dart';
import 'package:video_player/video_player.dart';

class VideoPage extends StatelessWidget {
  VideoPage({Key? key}) : super(key: key);

  final FlickManager flickManager = FlickManager(
    videoPlayerController:
        VideoPlayerController.asset("assets/video/malaria_blood_smear.mp4"),
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: mainBlue,
        title: const Text(
          "Visual Explanatuions.",
          style: TextStyle(
              color: whiteColor,
              fontFamily: 'Roboto',
              fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
      ),
      body: Center(
        child: AspectRatio(
          aspectRatio: 16 / 9,
          child: FlickVideoPlayer(flickManager: flickManager),
        ),
      ),
    );
  }
}
