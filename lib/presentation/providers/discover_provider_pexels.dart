import 'package:flutter/material.dart';
import 'package:toktik/domain/entities/video_post.dart';
import 'package:toktik/infrastructure/models/pexels_video_model.dart';
import 'package:toktik/shared/data/pexels_api.dart';

class DiscoverProviderPexels extends ChangeNotifier {
  bool initialLoading = true;
  List<VideoPost> videos = [];
  final PexelsAPI pexelsAPI = PexelsAPI();

  Future<void> loadNextPage() async {
    try {
      final List<PexelsVideoModel> newVideos =
          await pexelsAPI.fetchVideos(query: 'nature', page: 1, perPage: 10);
      videos
          .addAll(newVideos.map((video) => video.toVideoPostEntity()).toList());
      initialLoading = false;
      notifyListeners();
    } catch (e) {
      print('Error loading videos: $e');
    }
  }
}
