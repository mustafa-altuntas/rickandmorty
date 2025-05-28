import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rickandmorty/models/characters_model.dart';
import 'package:rickandmorty/models/episode.dart';
import 'package:rickandmorty/views/screens/character_detail_view/character_detail_view_model.dart';
import 'package:rickandmorty/views/widget/BackgroundContainerWidget.dart';
import 'package:rickandmorty/views/widget/appbar_widget.dart';

class CharacterDetailView extends StatefulWidget {
  final Character character;
  const CharacterDetailView({super.key, required this.character});

  @override
  State<CharacterDetailView> createState() => _CharacterDetailViewState();
}

class _CharacterDetailViewState extends State<CharacterDetailView> {
  @override
  void initState() {
    super.initState();
    context.read<CharacterDetailViewModel>().getEpisodes(
      widget.character.episode,
    );
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        extendBodyBehindAppBar: true,
        appBar: AppbarWidget(title: 'Karakter', transparentBackground: true),
        body: Backgroundcontainerwidget(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              _character_avatar_widget(context),
              Expanded(
                child: Container(
                  decoration: BoxDecoration(
                    color: Theme.of(context).colorScheme.surface,
                    borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(50),
                      topRight: Radius.circular(50),
                    ),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(18.0),
                    child: Column(
                      children: [
                        _character_name_widget(),
                        SizedBox(height: 15),
                        _labes_Views(context),
                        SizedBox(height: 30),
                        _scenes_Title_Widget(),

                        _episode_list_view(),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Flexible _episode_list_view() {
    return Flexible(
      child: Consumer<CharacterDetailViewModel>(
        builder:
            (context, value, child) => ListView.separated(
              padding: EdgeInsets.zero,
              itemCount: value.episodes.length,
              itemBuilder: (context, index) {
                final Episode episode = value.episodes[index];
                return ListTile(
                  leading: Icon(Icons.face_retouching_natural, size: 36),
                  trailing: Icon(Icons.keyboard_arrow_right),
                  title: Text(
                    episode.episode,
                    style: TextStyle(fontWeight: FontWeight.w500),
                  ),
                  subtitle: Text(episode.name, style: TextStyle(fontSize: 12)),
                );
              },
              separatorBuilder:
                  (context, index) => Divider(
                    color: Theme.of(context).colorScheme.tertiary,
                    height: 0,
                    indent: 20,
                    endIndent: 20,
                  ),
            ),
      ),
    );
  }

  Text _character_name_widget() {
    return Text(
      widget.character.name,
      style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
    );
  }

  Align _scenes_Title_Widget() {
    return Align(
      alignment: Alignment.centerLeft,
      child: Text(
        'Bölümler (${widget.character.episode.length})',
        style: TextStyle(fontSize: 15, fontWeight: FontWeight.w500),
      ),
    );
  }

  Padding _labes_Views(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 39),
      child: Wrap(
        alignment: WrapAlignment.center,
        runSpacing: 4,
        spacing: 7,
        children: [
          _label_widget(
            context,
            label: widget.character.status,
            tooltip: 'Status',
          ),
          _label_widget(
            context,
            label: widget.character.origin.name,
            tooltip: 'origin',
          ),
          _label_widget(
            context,
            label: widget.character.gender,
            tooltip: 'gender',
          ),

          _label_widget(
            context,
            label: widget.character.species,
            tooltip: 'species',
          ),
        ],
      ),
    );
  }

  Widget _label_widget(
    BuildContext context, {
    required String label,
    String? tooltip,
  }) {
    return Tooltip(
      message: tooltip ?? '',
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.secondary,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Text(label, style: TextStyle(fontSize: 12)),
      ),
    );
  }

  Padding _character_avatar_widget(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 50, bottom: 42),
      child: CircleAvatar(
        backgroundColor: Theme.of(context).colorScheme.primary,
        radius: 90,
        child: CircleAvatar(
          backgroundColor: Colors.white,
          radius: 88,
          child: Hero(
            tag: widget.character.image,
            child: CircleAvatar(
              backgroundColor: Theme.of(context).colorScheme.surface,
              backgroundImage: NetworkImage(widget.character.image),
              radius: 85,
            ),
          ),
        ),
      ),
    );
  }
}
