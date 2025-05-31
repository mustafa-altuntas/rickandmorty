import 'package:flutter/material.dart';

class Backgroundcontainerwidget extends StatelessWidget {
  final Widget child;
  final Widget topChild;
  const Backgroundcontainerwidget({
    super.key,
    required this.child,
    required this.topChild,
  });

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
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          topChild,
          Expanded(
            child: Container(
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.surface,
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(50),
                  topRight: Radius.circular(50),
                ),
              ),
              child: child,
            ),
          ),
        ],
      ),
    );
  }
}
