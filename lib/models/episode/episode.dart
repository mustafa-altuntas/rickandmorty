class Episode {
  final int id;
  final String name;
  final String airDate;
  final String episode;
  final List<String> characters;
  final String url;
  final DateTime created;

  Episode({
    required this.id,
    required this.name,
    required this.airDate,
    required this.episode,
    required this.characters,
    required this.url,
    required this.created,
  });
  factory Episode.fromJson(Map<String, dynamic> json) {
    return Episode(
      id: json['id'],
      name: json['name'],
      airDate: json['air_date'],
      episode: _formatEpisodeCode(json['episode']),
      characters: List<String>.from(json['characters']),
      url: json['url'],
      created: DateTime.parse(json['created']),
    );
  }
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'air_date': airDate,
      'episode': episode,
      'characters': characters,
      'url': url,
      'created': created.toIso8601String(),
    };
  }

  static String _formatEpisodeCode(String code) {
    final regex = RegExp(r'S(\d{2})E(\d{2})');
    final match = regex.firstMatch(code);

    if (match != null) {
      final season = int.parse(match.group(1)!);
      final episode = int.parse(match.group(2)!);
      return 'Sezon $season Bölüm $episode';
    }
    return code; // eşleşmezse olduğu gibi döner
  }
}
