import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:rickandmorty/models/characters_model.dart';
import 'package:rickandmorty/models/episode.dart';

class ApiService {
  final _dio = Dio(BaseOptions(baseUrl: 'https://rickandmortyapi.com/api'));

  Future<CharacterResponse?> getCharacters({
    String? url,
    Map<String, dynamic>? args,
  }) async {
    try {
      final response = await _dio.get(
        url ?? "/character",
        queryParameters: args,
      );
      return CharacterResponse.fromJson(response.data);
    } on DioException catch (e) {
      log('Error: <ApiService> :: ${e.message}');
      return null;
    }
  }

  Future<CharacterResponse?> getMultipleCharacters(List<int> idList) async {
    String ids = idList.join(',');
    try {
      final response = await _dio.get("/character/[${ids}]");
      (response.data as List).map((x) => Character.fromJson(x)).toList();
      return CharacterResponse(
        characters:
            (response.data as List).map((x) => Character.fromJson(x)).toList(),
        info: CharacterInfo(
          count:
              0, // Placeholder, as this API does not return info for multiple characters
          pages: 0, // Placeholder
          next: null, // Placeholder
          prev: null, // Placeholder
        ),
      );
    } on DioException catch (e) {
      log('Error: <ApiService> :: ${e.message}');
      return null;
    }
  }

  Future<List<Episode>> getMulltipleEpisodes(List<String> epidosesUrls) async {
    final List<String> episodeIds =
        epidosesUrls.map((e) => e.split('/').last).toList();
    String ids = episodeIds.join(',');
    try {
      final response = await _dio.get("/episode/[${ids}]");
      if (response.data is List) {
        return (response.data as List).map((x) => Episode.fromJson(x)).toList();
      } else {
        return [];
      }
    } on DioException catch (e) {
      log('Error: <ApiService> :: ${e.message}');
      return [];
    }
  }
}
