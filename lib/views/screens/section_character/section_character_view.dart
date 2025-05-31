import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rickandmorty/models/episode/episode.dart';
import 'package:rickandmorty/views/screens/section_character/section_character_view_model.dart';
import 'package:rickandmorty/views/widget/appbar_widget.dart';
import 'package:rickandmorty/views/widget/character_card_list_view.dart';

class SectionCharacterView extends StatefulWidget {
  final Episode episode;
  const SectionCharacterView({super.key, required this.episode});

  @override
  State<SectionCharacterView> createState() => _SectionCharacterViewState();
}

class _SectionCharacterViewState extends State<SectionCharacterView> {
  @override
  @override
  void initState() {
    super.initState();
    context.read<SectionCharacterViewModel>().getSectionCharacters(
      widget.episode.characters,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppbarWidget(title: widget.episode.name),
      body:
          context.watch<SectionCharacterViewModel>().characterResponse == null
              ? Center(child: CircularProgressIndicator.adaptive())
              : Padding(
                padding: const EdgeInsets.all(18),
                child: Column(
                  children: [
                    Consumer<SectionCharacterViewModel>(
                      builder:
                          (context, value, child) => CharacterCardListView(
                            viewModel: value.characterResponse,
                          ),
                    ),
                  ],
                ),
              ),
    );
  }
}
