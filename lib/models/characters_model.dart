class CharacterResponse {
  CharacterInfo info;
  final List<Character> characters;

  CharacterResponse({required this.info, required this.characters});
  factory CharacterResponse.fromJson(Map<String, dynamic> json) =>
      CharacterResponse(
        info: CharacterInfo.fromJson(json['info']),
        characters: List<Character>.from(
          json['results'].map((x) => Character.fromJson(x)),
        ),
      );
}

class CharacterInfo {
  final int count;
  final int pages;
  final String? next;
  final String? prev;

  CharacterInfo({
    required this.count,
    required this.pages,
    required this.next,
    required this.prev,
  });

  factory CharacterInfo.fromJson(Map<String, dynamic> json) => CharacterInfo(
    count: json['count'],
    pages: json['pages'],
    next: json['next'],
    prev: json['prev'],
  );
}

class Character {
  final int id;
  final String name;
  final String status;
  final String species;

  final CharacterLocation origin;
  final CharacterLocation location;
  final String image;
  final List<String> episode;

  Character({
    required this.id,
    required this.name,
    required this.status,
    required this.species,
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
