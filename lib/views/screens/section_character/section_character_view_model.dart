import 'package:flutter/material.dart';
import 'package:rickandmorty/app/di.dart';
import 'package:rickandmorty/models/characters_model.dart';
import 'package:rickandmorty/services/api_service.dart';

class SectionCharacterViewModel extends ChangeNotifier {
  final _apiService = di<ApiService>();
  CharacterResponse? _characterResponse;
  CharacterResponse? get characterResponse => _characterResponse;

  void getSectionCharacters(List<String> charactersUrls) async {
    _characterResponse = await _apiService.getSectionCharacters(charactersUrls);
    notifyListeners();
  }
}
