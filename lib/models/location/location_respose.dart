import 'package:rickandmorty/models/info_model.dart';
import 'package:rickandmorty/models/location/location.dart';

class LocationResponse {
  Info info;
  final List<Location> results;

  LocationResponse({required this.info, required this.results});

  factory LocationResponse.fromJson(Map<String, dynamic> json) {
    return LocationResponse(
      info: Info.fromJson(json['info']),
      results: List<Location>.from(
        json['results'].map((x) => Location.fromJson(x)),
      ),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'info': info.toJson(),
      'results': results.map((x) => x.toJson()).toList(),
    };
  }
}
