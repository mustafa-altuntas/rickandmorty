import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rickandmorty/views/screens/characters_view/characters_view_model.dart';
import 'package:rickandmorty/views/widget/character_card_list_view.dart';

class CharactersView extends StatefulWidget {
  const CharactersView({super.key});

  @override
  State<CharactersView> createState() => _CharactersViewState();
}

class _CharactersViewState extends State<CharactersView> {
  @override
  void initState() {
    super.initState();
    context.read<CharactersViewModel>().getCharacters();
  }

  @override
  Widget build(BuildContext context) {
    // final viewModel = context.watch<CharactersViewModel>();
    // if (viewModel.characterResponse == null) {
    //   return const Center(child: CircularProgressIndicator());
    // }
    var children = [
      _serchInputWidget(context),
      Consumer<CharactersViewModel>(
        builder: (context, viewModel, child) {
          if (viewModel.characterResponse == null) {
            return const Center(child: CircularProgressIndicator.adaptive());
          }
          return CharacterCardListView(
            viewModel: viewModel,
            onLoadMore: () {
              context.read<CharactersViewModel>().getCharactersMore();
              log('Load More Characters');
            },
            isLoading: viewModel.isLoading,
          );
        },
      ),
    ];
    return Scaffold(body: Center(child: Column(children: children)));
  }

  Padding _serchInputWidget(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 12, bottom: 16),
      child: TextField(
        decoration: InputDecoration(
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(
              color: Colors.grey, // Pasif durumdaki border rengi
              width: 2.0, // Kalınlığı
            ),
          ),
          labelText: 'Karakter Ara',
          labelStyle: TextStyle(color: Theme.of(context).colorScheme.onSurface),
          prefixIcon: Icon(
            Icons.search,
            color: Theme.of(context).colorScheme.primary,
          ),
          suffixIcon: Icon(
            Icons.more_vert,
            color: Theme.of(context).colorScheme.primary,
          ),
        ),
      ),
    );
  }
}
