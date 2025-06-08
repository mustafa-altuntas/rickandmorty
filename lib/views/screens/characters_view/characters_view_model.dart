import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:rickandmorty/app/di.dart';
import 'package:rickandmorty/models/characters_model.dart';
import 'package:rickandmorty/services/api_service.dart';

extension CharacterTypeExtension on CharacterType {
  String get nameTr {
    switch (this) {
      case CharacterType.all:
        return 'Tümü';
      case CharacterType.alive:
        return 'Canlı';
      case CharacterType.dead:
        return 'Ölü';
      case CharacterType.unknown:
        return 'Bilinmiyor';
    }
  }
}

enum CharacterType { all, alive, dead, unknown }

class CharactersViewModel extends ChangeNotifier {
  final _apiService = di<ApiService>();

  CharacterType characterType = CharacterType.all;

  CharacterResponse? _characterResponse;
  CharacterResponse? get characterResponse => _characterResponse;

  bool isLoading = false;
  int currentPage = 1;

  void setIsLoading(bool value) {
    isLoading = value;
    notifyListeners();
  }

  void clearCharacters() {
    _characterResponse = null;
    currentPage = 1;
    notifyListeners();
  }

  void getCharacters() async {
    _characterResponse = await _apiService.getCharacters();
    notifyListeners();
  }

  void getCharactersMore() async {
    if (isLoading) return;
    if (_characterResponse?.info.pages == currentPage) return;

    setIsLoading(true);

    final data = await _apiService.getCharacters(url: _characterResponse?.info.next);

    setIsLoading(false);

    currentPage++;

    _characterResponse?.info = data!.info;
    _characterResponse?.characters.addAll(data!.characters);

    notifyListeners();
  }

  void searchCharacter(String name) async {
    setIsLoading(true);

    clearCharacters();

    _characterResponse = await _apiService.getCharacters(args: {'name': name});
    log('Search Character: $name');
    setIsLoading(false);
    notifyListeners();
  }

  void onCharacterTypeChange(CharacterType type) async {
    characterType = type;

    clearCharacters();

    Map<String, dynamic>? args;
    if (type != CharacterType.all) {
      args = {'status': type.name};
    }

    _characterResponse = await _apiService.getCharacters(args: args);
    notifyListeners();

    // notifyListeners();
  }
}
