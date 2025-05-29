import 'package:flutter/material.dart';
import 'package:rickandmorty/models/location/location.dart';
import 'package:rickandmorty/models/location/location_respose.dart';

class LocationListview extends StatefulWidget {
  final LocationResponse locationResponse;
  final VoidCallback? onLoadMore;
  final bool loadMore;
  const LocationListview({
    super.key,
    required this.locationResponse,
    this.onLoadMore,
    required this.loadMore,
  });

  @override
  State<LocationListview> createState() => _LocationListviewState();
}

class _LocationListviewState extends State<LocationListview> {
  final ScrollController _scrollController = ScrollController();
  List<int> _favoriteCharacters = [];
  // bool _isLoading = false;
  @override
  void initState() {
    _detectScrollBottom();
    super.initState();
  }

  void _detectScrollBottom() {
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
      itemCount: widget.locationResponse.results.length,
      itemBuilder: (context, index) {
        final Location location = widget.locationResponse.results[index];
        return Column(
          children: [
            ListTile(
              leading: Icon(Icons.location_on, size: 36),
              trailing: Icon(Icons.keyboard_arrow_right),
              title: Text(
                location.name,
                style: TextStyle(fontWeight: FontWeight.w500),
              ),
              subtitle: Column(
                children: [
                  _subtitle_item_widget(text: 'Tür: ', value: location.name),
                  _subtitle_item_widget(
                    text: 'Kişi Sayısı: ',
                    value: location.residents.length.toString(),
                  ),
                ],
              ),
            ),
            if (widget.loadMore &&
                index == widget.locationResponse.results.length - 1)
              const CircularProgressIndicator.adaptive(),
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

  Row _subtitle_item_widget({required String text, required String value}) {
    return Row(
      children: [
        Text(
          '${text}',
          style: TextStyle(fontSize: 10, fontWeight: FontWeight.w300),
        ),
        Text(value, style: TextStyle(fontSize: 10)),
      ],
    );
  }
}
