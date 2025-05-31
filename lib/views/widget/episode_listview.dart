import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:rickandmorty/app/router.dart';
import 'package:rickandmorty/models/episode/episode.dart';

class EpisodeListview extends StatefulWidget {
  final List<Episode> episodes;
  bool loadMore;
  VoidCallback? onLoadMore;
  EpisodeListview({
    super.key,
    required this.episodes,
    this.onLoadMore,
    this.loadMore = false,
  });

  @override
  State<EpisodeListview> createState() => _EpisodeListviewState();
}

class _EpisodeListviewState extends State<EpisodeListview> {
  final _scrollController = ScrollController();

  @override
  void initState() {
    _listenScroll();
    super.initState();
  }

  void _listenScroll() {
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
    return ListView.separated(
      controller: _scrollController,
      padding: EdgeInsets.zero,
      itemCount: widget.episodes.length,
      itemBuilder: (context, index) {
        final Episode episode = widget.episodes[index];
        return Column(
          children: [
            ListTile(
              onTap:
                  () => context.push(
                    AppRoute.sectionsCharacterRoute,
                    extra: episode,
                  ),
              leading: Icon(Icons.face_retouching_natural, size: 36),
              trailing: Icon(Icons.keyboard_arrow_right),
              title: Text(
                episode.episode,
                style: TextStyle(fontWeight: FontWeight.w500),
              ),
              subtitle: Text(episode.name, style: TextStyle(fontSize: 12)),
            ),
            if (widget.loadMore && index == widget.episodes.length - 1)
              CircularProgressIndicator.adaptive(),
          ],
        );
      },
      separatorBuilder:
          (context, index) => Divider(
            color: Theme.of(context).colorScheme.tertiary,
            height: 0,
            indent: 20,
            endIndent: 20,
          ),
    );
  }
}
