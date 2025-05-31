class Episode {
  final int id;
  final String name;
  final String airDate;
  final String episode; // Biçimlendirilmiş hali
  final int seasonNumber;
  final int episodeNumber;
  final List<String> characters;
  final String url;
  final DateTime created;

  Episode({
    required this.id,
    required this.name,
    required this.airDate,
    required this.episode,
    required this.seasonNumber,
    required this.episodeNumber,
    required this.characters,
    required this.url,
    required this.created,
  });

  factory Episode.fromJson(Map<String, dynamic> json) {
    final episodeCode = json['episode'] as String;
    final parsed = _parseEpisodeCode(episodeCode);

    return Episode(
      id: json['id'],
      name: json['name'],
      airDate: json['air_date'],
      episode: _formatEpisodeCode(episodeCode),
      seasonNumber: parsed['season']!,
      episodeNumber: parsed['episode']!,
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
      'season_number': seasonNumber,
      'episode_number': episodeNumber,
      'characters': characters,
      'url': url,
      'created': created.toIso8601String(),
    };
  }

  static Map<String, int> _parseEpisodeCode(String code) {
    final regex = RegExp(r'S(\d{2})E(\d{2})');
    final match = regex.firstMatch(code);

    if (match != null) {
      final season = int.parse(match.group(1)!);
      final episode = int.parse(match.group(2)!);
      return {'season': season, 'episode': episode};
    }
    return {'season': 0, 'episode': 0}; // Eşleşmezse varsayılan
  }

  static String _formatEpisodeCode(String code) {
    final parsed = _parseEpisodeCode(code);
    return '${parsed['episode']}. Bölüm ${parsed['season']}. Sezon';
  }
}
