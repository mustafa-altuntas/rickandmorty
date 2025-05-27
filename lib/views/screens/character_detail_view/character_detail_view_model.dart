import 'package:flutter/material.dart';
import 'package:rickandmorty/app/di.dart';
import 'package:rickandmorty/models/episode.dart';
import 'package:rickandmorty/services/api_service.dart';

class CharacterDetailViewModel extends ChangeNotifier {
  final ApiService _apiService = di.get<ApiService>();
  List<Episode> _episodes = [];
  List<Episode> get episodes => _episodes;

  Future<void> getEpisodes(List<String> urls) async {
    _episodes = await _apiService.getMulltipleEpisodes(urls);
    notifyListeners();
  }
}
