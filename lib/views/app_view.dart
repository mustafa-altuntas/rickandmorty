import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:rickandmorty/views/screens/favorites_view/favorites_view_model.dart';

class AppView extends StatelessWidget {
  final StatefulNavigationShell navigationShell;
  const AppView({super.key, required this.navigationShell});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _appBarWidget(),

      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 18),
        child: navigationShell,
      ),
      bottomNavigationBar: Theme(
        data: Theme.of(context).copyWith(
          navigationBarTheme: NavigationBarThemeData(
            indicatorColor: Colors.transparent,
            labelTextStyle: WidgetStateProperty.resolveWith<TextStyle?>((
              Set<WidgetState> states,
            ) {
              if (states.contains(WidgetState.selected)) {
                return TextStyle(
                  color: Theme.of(context).colorScheme.primary,
                  fontWeight: FontWeight.w600,
                );
              }
              return TextStyle(
                color: Theme.of(context).colorScheme.tertiary,
                fontWeight: FontWeight.normal,
              );
            }),
            // Icon rengini ayarla
            iconTheme: WidgetStateProperty.resolveWith<IconThemeData?>((
              Set<WidgetState> states,
            ) {
              if (states.contains(WidgetState.selected)) {
                return IconThemeData(
                  color: Theme.of(context).colorScheme.primary,
                );
              }
              return IconThemeData(
                color: Theme.of(context).colorScheme.tertiary,
              );
            }),
          ),
        ),

        child: NavigationBar(
          selectedIndex: navigationShell.currentIndex,
          onDestinationSelected: (index) {
            navigationShell.goBranch(index);
            if (index == 1) {
              context.read<FavoritesViewModel>().getFavorites();
            }
          },
          indicatorColor: Colors.transparent,
          destinations: [
            _menuItem(
              context,
              index: 0,
              currentIndex: navigationShell.currentIndex,
              label: 'Karakterler',
              icon: Icons.face,
            ),
            _menuItem(
              context,
              index: 1,
              currentIndex: navigationShell.currentIndex,
              label: 'Favorilerim',
              icon: Icons.bookmark,
            ),
            _menuItem(
              context,
              index: 2,
              currentIndex: navigationShell.currentIndex,
              label: 'Konumlar',
              icon: Icons.location_on,
            ),
            _menuItem(
              context,
              index: 3,
              currentIndex: navigationShell.currentIndex,
              label: 'Bölümler',
              icon: Icons.menu,
            ),
          ],
        ),
      ),
    );
  }

  NavigationDestination _menuItem(
    BuildContext context, {
    required int index,
    required int currentIndex,
    required String label,
    required IconData icon,
  }) => NavigationDestination(
    icon: Icon(
      icon,
      color:
          currentIndex == index
              ? Theme.of(context).colorScheme.primary
              : Theme.of(context).colorScheme.tertiary,
    ),
    label: label,
  );

  AppBar _appBarWidget() {
    return AppBar(
      title: Text(
        'Rick and Morty',
        style: TextStyle(fontSize: 22, fontWeight: FontWeight.w500),
      ),
      //leading: // sol kısımdaki ikonlar
      actions: [
        IconButton(
          icon: const Icon(Icons.settings),
          onPressed: () {
            // Search action
          },
        ),
      ],
    );
  }
}
