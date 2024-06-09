import 'package:dio/dio.dart';
import 'package:toktik/infrastructure/models/pexels_video_model.dart';

class PexelsAPI {
  static const String apiKey =
      '909SfdnSvlYolqgcU35uVnB3Wgt3Gpb9RspDi7PDhDCY6eL9rG7YLGhR';
  static const String baseUrl = 'https://api.pexels.com/videos';
  final Dio _dio;

  PexelsAPI()
      : _dio = Dio(BaseOptions(
          baseUrl: baseUrl,
          headers: {'Authorization': apiKey},
        ));

  Future<List<PexelsVideoModel>> fetchVideos(
      {String query = 'nature', int page = 1, int perPage = 10}) async {
    try {
      final response = await _dio.get('/search', queryParameters: {
        'query': query,
        'page': page,
        'per_page': perPage,
      });

      if (response.statusCode == 200) {
        final data = response.data;
        return (data['videos'] as List)
            .map((video) => PexelsVideoModel.fromJson(video))
            .toList();
      } else {
        throw Exception('Failed to load videos');
      }
    } catch (e) {
      throw Exception('Failed to load videos: $e');
    }
  }
}
