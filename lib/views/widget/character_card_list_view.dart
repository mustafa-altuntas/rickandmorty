import 'package:flutter/material.dart';
import 'package:rickandmorty/app/di.dart';
import 'package:rickandmorty/models/characters_model.dart';
import 'package:rickandmorty/services/preferences_service.dart';
import 'package:rickandmorty/views/widget/character_card_view.dart';

class CharacterCardListView extends StatefulWidget {
  // final CharactersViewModel viewModel;
  final CharacterResponse? viewModel;
  final VoidCallback? onLoadMore;
  final bool isLoading;
  const CharacterCardListView({
    super.key,
    required this.viewModel,
    this.onLoadMore,
    this.isLoading = false,
  });

  @override
  State<CharacterCardListView> createState() => _CharacterCardListViewState();
}

class _CharacterCardListViewState extends State<CharacterCardListView> {
  final ScrollController _scrollController = ScrollController();
  List<int> _favoriteCharacters = [];
  bool _isLoading = false;

  @override
  void initState() {
    // widget ilk olşturulduğunda çalışan metod
    _getFavoriteCharacters();
    _detectScrollEnd();
    super.initState();
  }

  void _setIsLoading(bool value) {
    _isLoading = value;
    setState(() {});
  }

  void _getFavoriteCharacters() async {
    _setIsLoading(true);
    _favoriteCharacters = di<PreferencesService>().getSavedCharacters();
    _setIsLoading(false);
    setState(() {});
  }

  void _detectScrollEnd() {
    _scrollController.addListener(() {
      final maxScroll = _scrollController.position.maxScrollExtent;
      final currentScroll = _scrollController.position.pixels;
      const int delta = 200;
      if (maxScroll - currentScroll <= delta) {
        widget.onLoadMore?.call();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    // sayfalar arası geçişlerde tekrar favori karakterleri al
    _getFavoriteCharacters();
    if (_isLoading) {
      return const Center(child: CircularProgressIndicator.adaptive());
    }
    return Flexible(
      child: ListView.builder(
        shrinkWrap: true,
        controller: _scrollController,
        itemCount: widget.viewModel!.characters.length,
        itemBuilder: (context, index) {
          final isFavorite = _favoriteCharacters.contains(
            widget.viewModel!.characters[index].id,
          );
          return Column(
            children: [
              CharacterCardView(
                character: widget.viewModel!.characters[index],
                isFavorite: isFavorite,
              ),
              if (widget.isLoading &&
                  index == widget.viewModel!.characters.length - 1)
                const Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Center(child: CircularProgressIndicator.adaptive()),
                ),
            ],
          );
        },
      ),
    );
  }
}
