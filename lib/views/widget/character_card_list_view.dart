import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:rickandmorty/views/screens/characters_view/characters_view_model.dart';
import 'package:rickandmorty/views/widget/character_card_view.dart';

class CharacterCardListView extends StatefulWidget {
  final CharactersViewModel viewModel;
  final VoidCallback onLoadMore;
  final bool isLoading;
  const CharacterCardListView({
    super.key,
    required this.viewModel,
    required this.onLoadMore,
    this.isLoading = false,
  });

  @override
  State<CharacterCardListView> createState() => _CharacterCardListViewState();
}

class _CharacterCardListViewState extends State<CharacterCardListView> {
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    // widget ilk olşturulduğunda çalışan metod
    _detectScrollEnd();
    super.initState();
  }

  void _detectScrollEnd() {
    _scrollController.addListener(() {
      final maxScroll = _scrollController.position.maxScrollExtent;
      final currentScroll = _scrollController.position.pixels;
      const int delta = 200;
      if (maxScroll - currentScroll <= delta) {
        widget.onLoadMore();

        log('Scroll End Detected');
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Flexible(
      child: ListView.builder(
        shrinkWrap: true,
        controller: _scrollController,
        itemCount: widget.viewModel.characterResponse!.characters.length,
        itemBuilder: (context, index) {
          return Column(
            children: [
              CharacterCardView(
                character:
                    widget.viewModel.characterResponse!.characters[index],
              ),
              if (widget.isLoading &&
                  index ==
                      widget.viewModel.characterResponse!.characters.length - 1)
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
