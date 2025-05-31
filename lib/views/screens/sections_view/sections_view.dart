import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rickandmorty/views/screens/sections_view/sections_view_model.dart';
import 'package:rickandmorty/views/widget/appbar_widget.dart';
import 'package:rickandmorty/views/widget/background_container_widget.dart';
import 'package:rickandmorty/views/widget/episode_listview.dart';

class SectionsView extends StatefulWidget {
  const SectionsView({super.key});

  @override
  State<SectionsView> createState() => _SectionsViewState();
}

class _SectionsViewState extends State<SectionsView> {
  @override
  void initState() {
    super.initState();
    context.read<SectionsViewModel>().getEpisodes();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        extendBodyBehindAppBar: true,
        appBar: AppbarWidget(title: 'Bölümler', transparentBackground: true),
        body: Backgroundcontainerwidget(
          topChild: SizedBox(height: 74),
          child: Padding(
            padding: const EdgeInsets.all(18.0),
            child: Consumer<SectionsViewModel>(
              builder: (context, value, child) {
                if (value.episodeRespose == null) {
                  return Center(child: CircularProgressIndicator.adaptive());
                }
                return EpisodeListview(
                  episodes: value.episodeRespose!.results,
                  loadMore: value.loadMore,
                  onLoadMore: value.onLoadMore,
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}
