import 'package:shared_preferences/shared_preferences.dart';

class PreferencesService {
  final SharedPreferences prefs;

  PreferencesService({required this.prefs});

  final String _characterKey = 'characters';

  void saveCharacter(int id) async {
    List<String> characters = prefs.getStringList(_characterKey) ?? [];
    if (!characters.contains(id.toString())) {
      characters.add(id.toString());
      await prefs.setStringList(_characterKey, characters);
    }
  }

  void removeCharacter(int id) async {
    List<String> characters = prefs.getStringList(_characterKey) ?? [];
    if (characters.contains(id.toString())) {
      characters.remove(id.toString());
      await prefs.setStringList(_characterKey, characters);
    }
  }

  List<int> getSavedCharacters() {
    final characterList = prefs.getStringList(_characterKey) ?? [];
    return characterList.map((e) => int.parse(e)).toList();
  }

  bool isCharacterFavorite(int id) {
    final savedCharacters = getSavedCharacters();
    return savedCharacters.contains(id);
  }
}
