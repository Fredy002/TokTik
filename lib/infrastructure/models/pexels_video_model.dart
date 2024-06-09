import 'dart:math';

import 'package:toktik/domain/entities/video_post.dart';

class PexelsVideoModel {
  final int id;
  final int width;
  final int height;
  final String url;
  final String image;
  final int duration;
  final String videoUrl;
  final String user;
  final int likes;
  final int views;

  PexelsVideoModel({
    required this.id,
    required this.width,
    required this.height,
    required this.url,
    required this.image,
    required this.duration,
    required this.videoUrl,
    required this.user,
    this.likes = 0,
    this.views = 0,
  });

  factory PexelsVideoModel.fromJson(Map<String, dynamic> json) {
    final random = Random();
    final videoFile = (json['video_files'] as List).firstWhere(
        (file) => file['quality'] == 'hd',
        orElse: () => json['video_files'][0]);

    return PexelsVideoModel(
      id: json['id'],
      width: json['width'],
      height: json['height'],
      url: json['url'],
      image: json['image'],
      duration: json['duration'],
      videoUrl: videoFile['link'],
      user: json['user']['name'],
      likes: json['likes'] ?? random.nextInt(1000) + 1000,
      views: json['views'] ?? random.nextInt(1000) + 1000,
    );
  }

  VideoPost toVideoPostEntity() => VideoPost(
        caption: user,
        videoUrl: videoUrl,
        likes: likes,
        views: views,
      );
}
