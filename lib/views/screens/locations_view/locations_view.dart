import 'dart:async';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rickandmorty/views/screens/locations_view/location_listview.dart';
import 'package:rickandmorty/views/screens/locations_view/locations_view_model.dart';
import 'package:rickandmorty/views/widget/BackgroundContainerWidget.dart';
import 'package:rickandmorty/views/widget/appbar_widget.dart';

class LocationsView extends StatefulWidget {
  const LocationsView({super.key});

  @override
  State<LocationsView> createState() => _LocationsViewState();
}

class _LocationsViewState extends State<LocationsView> {
  @override
  void initState() {
    context.read<LocationsViewModel>().getLocations();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        extendBodyBehindAppBar: true,
        appBar: AppbarWidget(title: 'Konumlar', transparentBackground: true),
        body: Backgroundcontainerwidget(
          topChild: SizedBox(height: 74),

          child: _location_list_view(),
        ),
      ),
    );
  }

  Flexible _location_list_view() {
    return Flexible(
      child: Consumer<LocationsViewModel>(
        builder: (context, value, child) {
          if (value.locationResponse == null) {
            return Center(child: CircularProgressIndicator.adaptive());
          }

          return Padding(
            padding: const EdgeInsets.only(top: 30),
            child: LocationListview(
              locationResponse: value.locationResponse!,
              onLoadMore: value.geMoretLocations,
              loadMore: value.loadMore,
            ),
          );
        },
      ),
    );
  }
}
