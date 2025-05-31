import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rickandmorty/models/characters_model.dart';
import 'package:rickandmorty/views/screens/character_detail_view/character_detail_view_model.dart';
import 'package:rickandmorty/views/widget/background_container_widget.dart';
import 'package:rickandmorty/views/widget/appbar_widget.dart';
import 'package:rickandmorty/views/widget/episode_listview.dart';

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
          topChild: _characterAvatarWidget(context),

          child: Column(
            children: [
              _characterNameWidget(),
              SizedBox(height: 15),
              _labesViews(context),
              SizedBox(height: 30),
              _scenesTitleWidget(),

              _episodeListView(),
            ],
          ),
        ),
      ),
    );
  }

  Flexible _episodeListView() {
    return Flexible(
      child: Consumer<CharacterDetailViewModel>(
        builder: (context, value, child) {
          return EpisodeListview(episodes: value.episodes);
        },
      ),
    );
  }

  Text _characterNameWidget() {
    return Text(
      widget.character.name,
      style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
    );
  }

  Align _scenesTitleWidget() {
    return Align(
      alignment: Alignment.centerLeft,
      child: Text(
        'Bölümler (${widget.character.episode.length})',
        style: TextStyle(fontSize: 15, fontWeight: FontWeight.w500),
      ),
    );
  }

  Padding _labesViews(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 39),
      child: Wrap(
        alignment: WrapAlignment.center,
        runSpacing: 4,
        spacing: 7,
        children: [
          _labelwidget(
            context,
            label: widget.character.status,
            tooltip: 'Status',
          ),
          _labelwidget(
            context,
            label: widget.character.origin.name,
            tooltip: 'origin',
          ),
          _labelwidget(
            context,
            label: widget.character.gender,
            tooltip: 'gender',
          ),

          _labelwidget(
            context,
            label: widget.character.species,
            tooltip: 'species',
          ),
        ],
      ),
    );
  }

  Widget _labelwidget(
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

  Padding _characterAvatarWidget(BuildContext context) {
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
