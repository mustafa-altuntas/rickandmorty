import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:rickandmorty/app/router.dart';

class AppbarWidget extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final bool transparentBackground;
  final bool hideSetting;
  const AppbarWidget({
    super.key,
    required this.title,
    this.transparentBackground = false,
    this.hideSetting = false,
  });

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: transparentBackground ? Colors.transparent : null,
      title: Text(title, style: TextStyle(fontSize: 22, fontWeight: FontWeight.w500)),

      //leading: // sol kısımdaki ikonlar
      actions: [
        if (!hideSetting)
          IconButton(
            icon: const Icon(Icons.settings),
            onPressed: () => context.push(AppRoute.setting),
          ),
      ],
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(56);
}
