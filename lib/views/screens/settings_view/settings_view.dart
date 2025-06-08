import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rickandmorty/app/theme.dart';
import 'package:rickandmorty/views/widget/appbar_widget.dart';

class SettingsView extends StatelessWidget {
  const SettingsView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppbarWidget(title: 'Ayarlar', hideSetting: true),
      body: Center(
        child: ListView(
          children: [
            ListTile(
              title: Text('Karanlık Tema'),
              trailing: Switch(
                value: context.watch<AppTheme>().isDark,
                onChanged: (value) {
                  context.read<AppTheme>().toggleTheme();
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
