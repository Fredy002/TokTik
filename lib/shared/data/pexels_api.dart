import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:toktik/infrastructure/models/pexels_video_model.dart';

class PexelsAPI {
  final Dio _dio;

  PexelsAPI()
      : _dio = Dio(BaseOptions(
          baseUrl: 'https://api.pexels.com/videos',
          headers: {'Authorization': dotenv.env['PEXELS_API_KEY']},
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
        final List<dynamic> videos = data['videos'];

        // Mapa para rastrear videos únicos por usuario
        final Map<int, PexelsVideoModel> uniqueUserVideos = {};

        for (var video in videos) {
          final pexelsVideoModel = PexelsVideoModel.fromJson(video);
          // Verificar si el user id ya está en el mapa
          if (!uniqueUserVideos.containsKey(pexelsVideoModel.userId)) {
            uniqueUserVideos[pexelsVideoModel.userId] = pexelsVideoModel;
          }
        }

        return uniqueUserVideos.values.toList();
      } else {
        throw Exception('Failed to load videos');
      }
    } catch (e) {
      throw Exception('Failed to load videos: $e');
    }
  }
}
