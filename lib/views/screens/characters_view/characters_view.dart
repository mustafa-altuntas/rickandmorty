import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rickandmorty/views/screens/characters_view/characters_view_model.dart';
import 'package:rickandmorty/views/widget/appbar_widget.dart';
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
      context.watch<CharactersViewModel>().characterResponse == null
          ? const Center(child: CircularProgressIndicator.adaptive())
          : Consumer<CharactersViewModel>(
            builder: (context, viewModel, child) {
              if (viewModel.characterResponse == null) {
                return const Center(child: CircularProgressIndicator.adaptive());
              }
              return CharacterCardListView(
                viewModel: viewModel.characterResponse,
                onLoadMore: () {
                  viewModel.getCharactersMore();
                },
                isLoading: viewModel.isLoading,
              );
            },
          ),
    ];
    return Scaffold(
      appBar: AppbarWidget(title: 'Rick and Morty'),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 18),
        child: Center(child: Column(children: children)),
      ),
    );
  }

  Padding _serchInputWidget(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 12, bottom: 16),
      child: TextFormField(
        textInputAction: TextInputAction.search,
        onFieldSubmitted: (value) => context.read<CharactersViewModel>().searchCharacter(value),
        decoration: InputDecoration(
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(
              color: Colors.grey, // Pasif durumdaki border rengi
              width: 2.0, // Kalınlığı
            ),
          ),
          hintText: 'Karakter Ara',
          hintStyle: TextStyle(color: Theme.of(context).colorScheme.onSurface),
          prefixIcon: Icon(Icons.search, color: Theme.of(context).colorScheme.primary),
          suffixIcon: PopupMenuButton(
            onSelected: context.read<CharactersViewModel>().onCharacterTypeChange,
            icon: Icon(Icons.more_vert),
            itemBuilder: (context) {
              return CharacterType.values
                  .map((e) => PopupMenuItem<CharacterType>(value: e, child: Text(e.nameTr)))
                  .toList();

              ;
            },
          ),
        ),
      ),
    );
  }
}
