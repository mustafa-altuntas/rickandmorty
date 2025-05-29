import 'package:flutter/material.dart';
import 'package:rickandmorty/app/di.dart';
import 'package:rickandmorty/models/location/location_respose.dart';
import 'package:rickandmorty/services/api_service.dart';

class LocationsViewModel extends ChangeNotifier {
  final _apiService = di<ApiService>();

  LocationResponse? _locationResponse;
  LocationResponse? get locationResponse => _locationResponse;
  int currentPage = 1;
  bool loadMore = false;

  void setLoadMore(bool value) {
    loadMore = value;
    notifyListeners();
  }

  void getLocations() async {
    _locationResponse = await _apiService.getLocations();
    notifyListeners();
  }

  void geMoretLocations() async {
    if (loadMore) return;
    if (_locationResponse?.info.pages == currentPage) return;

    setLoadMore(true);

    final data = await _apiService.getLocations(
      url: _locationResponse?.info.next,
    );

    setLoadMore(false);

    currentPage++;

    _locationResponse?.info = data!.info;
    _locationResponse?.results.addAll(data!.results);

    notifyListeners();
  }
}
