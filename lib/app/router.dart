import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:rickandmorty/models/characters_model.dart';
import 'package:rickandmorty/views/app_view.dart';
import 'package:rickandmorty/views/screens/character_detail_view/character_detail_view.dart';
import 'package:rickandmorty/views/screens/character_detail_view/character_detail_view_model.dart';
import 'package:rickandmorty/views/screens/characters_view/characters_view.dart';
import 'package:rickandmorty/views/screens/characters_view/characters_view_model.dart';
import 'package:rickandmorty/views/screens/favorites_view/favorites_view.dart';
import 'package:rickandmorty/views/screens/locations_view/locations_view.dart';
import 'package:rickandmorty/views/screens/sections_view/sections_view.dart';

final _routeKey = GlobalKey<NavigatorState>();

class AppRoute {
  AppRoute._();
  static const String characters = '/';
  static const String favorites = '/favorites';
  static const String locations = '/locations';
  static const String sections = '/sections';

  static const String characterDetail = '/characterDetail';
}

final router = GoRouter(
  navigatorKey: _routeKey,
  initialLocation: AppRoute.characters,
  routes: [
    StatefulShellRoute.indexedStack(
      builder:
          (context, state, navigationShell) =>
              AppView(navigationShell: navigationShell),
      branches: [
        // StatefulShellBranch(
        //   routes: [
        //     GoRoute(
        //       path: AppRoute.characters,
        //       builder: (context, state) => CharactersView(),
        //     ),
        //   ],
        // ),
        StatefulShellBranch(
          routes: [
            GoRoute(
              path: AppRoute.characters,
              builder:
                  (context, state) => ChangeNotifierProvider(
                    create: (context) => CharactersViewModel(),
                    child: CharactersView(),
                  ),
              routes: [
                GoRoute(
                  path: AppRoute.characterDetail,
                  builder:
                      (context, state) => ChangeNotifierProvider(
                        create: (context) => CharacterDetailViewModel(),
                        child: CharacterDetailView(
                          character: state.extra as Character,
                        ),
                      ),
                ),
              ],
            ),
          ],
        ),
        StatefulShellBranch(
          routes: [
            GoRoute(
              path: AppRoute.favorites,
              builder: (context, state) => FavoritesView(),
            ),
          ],
        ),
        StatefulShellBranch(
          routes: [
            GoRoute(
              path: AppRoute.locations,
              builder: (context, state) => LocationsView(),
            ),
          ],
        ),
        StatefulShellBranch(
          routes: [
            GoRoute(
              path: AppRoute.sections,
              builder: (context, state) => SectionsView(),
            ),
          ],
        ),
      ],
    ),
  ],
);
