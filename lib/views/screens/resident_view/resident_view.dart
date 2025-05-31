import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rickandmorty/models/location/location.dart';
import 'package:rickandmorty/views/screens/resident_view/resident_view_model.dart';
import 'package:rickandmorty/views/widget/appbar_widget.dart';
import 'package:rickandmorty/views/widget/character_card_list_view.dart';

class ResidentView extends StatefulWidget {
  final Location location;
  const ResidentView({super.key, required this.location});

  @override
  State<ResidentView> createState() => _ResidentViewState();
}

class _ResidentViewState extends State<ResidentView> {
  @override
  @override
  void initState() {
    super.initState();
    context.read<ResidentViewModel>().getResidents(widget.location.residents);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppbarWidget(title: widget.location.name),
      body:
          context.watch<ResidentViewModel>().residents == null
              ? Center(child: CircularProgressIndicator.adaptive())
              : Padding(
                padding: const EdgeInsets.all(18),
                child: Column(
                  children: [
                    Consumer<ResidentViewModel>(
                      builder:
                          (context, value, child) =>
                              CharacterCardListView(viewModel: value.residents),
                    ),
                  ],
                ),
              ),
    );
  }
}
