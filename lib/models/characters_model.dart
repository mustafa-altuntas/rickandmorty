import 'package:rickandmorty/models/info_model.dart';

class CharacterResponse {
  Info info;
  final List<Character> characters;

  CharacterResponse({required this.info, required this.characters});
  factory CharacterResponse.fromJson(Map<String, dynamic> json) =>
      CharacterResponse(
        info: Info.fromJson(json['info']),
        characters: List<Character>.from(
          json['results'].map((x) => Character.fromJson(x)),
        ),
      );
}

class Character {
  final int id;
  final String name;
  final String status;
  final String species;
  final String gender;

  final CharacterLocation origin;
  final CharacterLocation location;
  final String image;
  final List<String> episode;

  Character({
    required this.id,
    required this.name,
    required this.status,
    required this.species,
    required this.gender,
    required this.origin,
    required this.location,
    required this.image,
    required this.episode,
  });
  factory Character.fromJson(Map<String, dynamic> json) => Character(
    id: json['id'],
    name: json['name'],
    status: json['status'],
    species: json['species'],
    gender: json['gender'],
    origin: CharacterLocation.fromJson(json['origin']),
    location: CharacterLocation.fromJson(json['location']),
    image: json['image'],
    episode: List<String>.from(json['episode'].map((x) => x)),
  );
}

class CharacterLocation {
  final String name;
  final String url;

  CharacterLocation({required this.name, required this.url});
  factory CharacterLocation.fromJson(Map<String, dynamic> json) =>
      CharacterLocation(name: json['name'], url: json['url']);
}
