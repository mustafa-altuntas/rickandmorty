import 'package:flutter/material.dart';
import 'package:rickandmorty/app/di.dart';
import 'package:rickandmorty/models/characters_model.dart';
import 'package:rickandmorty/services/api_service.dart';
import 'package:rickandmorty/services/preferences_service.dart';

class FavoritesViewModel extends ChangeNotifier {
  final _preferencesApi = di.get<PreferencesService>();
  final _apiServie = di.get<ApiService>();
  CharacterResponse? _favorites;
  CharacterResponse? get charactersResponse => _favorites;

  Future<void> getFavorites() async {
    List<int> favoriteIds = _preferencesApi.getSavedCharacters();
    if (favoriteIds.isNotEmpty) {
      _favorites = await _apiServie.getMultipleCharacters(favoriteIds);
      notifyListeners();
    }
  }
}
