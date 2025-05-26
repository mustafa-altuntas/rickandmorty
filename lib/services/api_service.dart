import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:rickandmorty/models/characters_model.dart';

class ApiService {
  final _dio = Dio(BaseOptions(baseUrl: 'https://rickandmortyapi.com/api'));

  Future<CharacterResponse> getCharacters({String? url}) async {
    try {
      final response = await _dio.get(url ?? "/character");
      return CharacterResponse.fromJson(response.data);
    } on DioException catch (e) {
      log('Error: ${e.message}');
      rethrow;
    }
  }
}
