import 'package:flutter/material.dart';

@immutable
class AnimatedSwitchWidget extends StatelessWidget {
  final Widget child;
  final int? duration;

  const AnimatedSwitchWidget({super.key, required this.child, this.duration});

  @override
  Widget build(BuildContext context) {
    return AnimatedSwitcher(
        duration: Duration(milliseconds: duration ?? 400),
        switchInCurve: Curves.easeInQuad,
        transitionBuilder: (child, animation) => ScaleTransition(
            scale: animation,
            child: FadeTransition(opacity: animation, child: child)),
        child: child);
  }
}
