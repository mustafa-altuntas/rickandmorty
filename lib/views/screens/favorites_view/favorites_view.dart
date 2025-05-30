import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rickandmorty/views/screens/favorites_view/favorites_view_model.dart';
import 'package:rickandmorty/views/widget/appbar_widget.dart';
import 'package:rickandmorty/views/widget/character_card_list_view.dart';

class FavoritesView extends StatefulWidget {
  const FavoritesView({super.key});

  @override
  State<FavoritesView> createState() => _FavoritesViewState();
}

class _FavoritesViewState extends State<FavoritesView> {
  @override
  void initState() {
    context.read<FavoritesViewModel>().getFavorites();
    super.initState();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    final favoritesViewModel = context.watch<FavoritesViewModel>();

    return Scaffold(
      appBar: AppbarWidget(title: 'Favoriler'),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 18),
          child:
              favoritesViewModel.charactersResponse == null
                  ? const CircularProgressIndicator()
                  : favoritesViewModel.charactersResponse!.characters.isEmpty
                  ? const Text('No favorites found')
                  : Column(
                    children: [
                      CharacterCardListView(
                        viewModel: favoritesViewModel.charactersResponse,
                        onLoadMore: () {},
                      ),
                    ],
                  ),
        ),
      ),
    );
  }
}
