import 'package:rickandmorty/models/episode/episode.dart';
import 'package:rickandmorty/models/info_model.dart';

class EpisodeRespose {
  Info? info;
  final List<Episode> results;

  EpisodeRespose({required this.info, required this.results});

  factory EpisodeRespose.fromJson(Map<String, dynamic> json) {
    return EpisodeRespose(
      info: Info.fromJson(json['info']),
      results: List<Episode>.from(
        json['results'].map((x) => Episode.fromJson(x)),
      ),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'info': info?.toJson(),
      'results': results.map((x) => x.toJson()).toList(),
    };
  }
}
