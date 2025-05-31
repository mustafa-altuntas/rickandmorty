import 'package:flutter/material.dart';
import 'package:rickandmorty/app/di.dart';
import 'package:rickandmorty/models/episode/episode_respose.dart';
import 'package:rickandmorty/services/api_service.dart';

class SectionsViewModel extends ChangeNotifier {
  final _apiSerive = di<ApiService>();
  EpisodeRespose? _episodeRespose;
  EpisodeRespose? get episodeRespose => _episodeRespose;

  void getEpisodes() async {
    _episodeRespose = await _apiSerive.getEpisodes();
    notifyListeners();
  }

  bool loadMore = false;
  int _currentPage = 1;
  void setLoadMore(bool value) {
    loadMore = value;
    notifyListeners();
  }

  void onLoadMore() async {
    if (loadMore) return;
    if (_episodeRespose?.info?.pages == _currentPage) return;

    if (loadMore && _currentPage == _episodeRespose?.info?.pages) return;
    setLoadMore(true);
    final data = await _apiSerive.getEpisodes(url: _episodeRespose?.info?.next);
    _currentPage++;
    _episodeRespose?.info = data?.info;
    _episodeRespose?.results.addAll(data!.results);
    setLoadMore(false);

    notifyListeners();
  }
}
