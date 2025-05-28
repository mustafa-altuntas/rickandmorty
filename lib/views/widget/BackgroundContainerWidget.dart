import 'package:flutter/material.dart';

class Backgroundcontainerwidget extends StatelessWidget {
  final Widget child;
  const Backgroundcontainerwidget({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage('assets/images/bg-image.png'),
          fit: BoxFit.fitWidth,
          alignment: Alignment.topCenter,
        ),
      ),
      child: child,
    );
  }
}
