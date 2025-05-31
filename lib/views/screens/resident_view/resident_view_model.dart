import 'package:flutter/material.dart';
import 'package:rickandmorty/app/di.dart';
import 'package:rickandmorty/models/characters_model.dart';
import 'package:rickandmorty/services/api_service.dart';

class ResidentViewModel extends ChangeNotifier {
  final _apiService = di<ApiService>();
  CharacterResponse? _residents;
  CharacterResponse? get residents => _residents;

  void getResidents(List<String> residentsUrl) async {
    _residents = await _apiService.getResidents(residentsUrl);
    notifyListeners();
  }
}
