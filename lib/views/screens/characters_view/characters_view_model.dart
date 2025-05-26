import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:rickandmorty/app/di.dart';
import 'package:rickandmorty/models/characters_model.dart';
import 'package:rickandmorty/services/api_service.dart';

class CharactersViewModel extends ChangeNotifier {
  final _apiService = di<ApiService>();

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

    final data = await _apiService.getCharacters(
      url: _characterResponse?.info.next,
    );

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
}
