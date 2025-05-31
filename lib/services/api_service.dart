import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:rickandmorty/models/characters_model.dart';
import 'package:rickandmorty/models/episode/episode.dart';
import 'package:rickandmorty/models/episode/episode_respose.dart';
import 'package:rickandmorty/models/info_model.dart';
import 'package:rickandmorty/models/location/location_respose.dart';

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
      final response = await _dio.get("/character/[$ids]");
      (response.data as List).map((x) => Character.fromJson(x)).toList();
      return CharacterResponse(
        characters:
            (response.data as List).map((x) => Character.fromJson(x)).toList(),
        info: Info(
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
      final response = await _dio.get("/episode/[$ids]");
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

  Future<LocationResponse?> getLocations({
    String? url,
    Map<String, dynamic>? args,
  }) async {
    try {
      final response = await _dio.get(
        url ?? "/location",
        queryParameters: args,
      );
      return LocationResponse.fromJson(response.data);
    } on DioException catch (e) {
      log('Error: <ApiService> :: getLocations() ${e.message}');
      return null;
    }
  }

  Future<EpisodeRespose?> getEpisodes({
    String? url,
    Map<String, dynamic>? args,
  }) async {
    try {
      final response = await _dio.get(url ?? "/episode", queryParameters: args);
      return EpisodeRespose.fromJson(response.data);
    } on DioException catch (e) {
      log('Error: <ApiService> :: getEpisodes() ${e.message}');
      return null;
    }
  }

  Future<CharacterResponse?> getResidents(List<String> residentsUrl) async {
    List<int> ids =
        residentsUrl.map((e) => int.parse(e.split('/').last)).toList();
    try {
      final result = await getMultipleCharacters(ids);
      return result;
    } on DioException catch (e) {
      log('Error: <ApiService> :: ${e.message}');
      return null;
    }
  }

  Future<CharacterResponse?> getSectionCharacters(
    List<String> charactersUrls,
  ) async {
    List<int> ids =
        charactersUrls.map((e) => int.parse(e.split('/').last)).toList();
    try {
      final result = await getMultipleCharacters(ids);
      return result;
    } on DioException catch (e) {
      log('Error: <ApiService> :: ${e.message}');
      return null;
    }
  }
}
