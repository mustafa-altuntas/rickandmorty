import 'package:get_it/get_it.dart';
import 'package:rickandmorty/services/api_service.dart';

final di = GetIt.I;

void setupDI() {
  di.registerLazySingleton<ApiService>(() => ApiService());
}
