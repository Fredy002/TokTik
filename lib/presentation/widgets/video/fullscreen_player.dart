// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

class FullscreenPlayer extends StatefulWidget {
  final String videoUrl;
  final String caption;

  const FullscreenPlayer({
    super.key,
    required this.videoUrl,
    required this.caption,
  });

  @override
  State<FullscreenPlayer> createState() => _FullscreenPlayerState();
}

class _FullscreenPlayerState extends State<FullscreenPlayer> {
  late VideoPlayerController controller;

  @override
  void initState() {
    super.initState();

    controller = VideoPlayerController.network(widget.videoUrl)
      ..setVolume(0)
      ..setLooping(true)
      ..initialize().then((_) {
        setState(() {});
        controller.play();
      });
  }

  @override
  void dispose() {
    // ceases to reproduce when we no longer observe it
    controller.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return controller.value.isInitialized
        ? AspectRatio(
            aspectRatio: controller.value.aspectRatio,
            child: VideoPlayer(controller),
          )
        : const Center(
            child: CircularProgressIndicator(),
          );
  }
}
