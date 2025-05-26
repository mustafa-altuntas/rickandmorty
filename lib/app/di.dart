import 'package:get_it/get_it.dart';
import 'package:rickandmorty/services/api_service.dart';
import 'package:rickandmorty/services/preferences_service.dart';
import 'package:shared_preferences/shared_preferences.dart';

final di = GetIt.I;

Future<void> setupDI() async {
  final SharedPreferences prefs = await SharedPreferences.getInstance();
  di.registerLazySingleton<ApiService>(() => ApiService());
  di.registerLazySingleton<PreferencesService>(
    () => PreferencesService(prefs: prefs),
  );
}
