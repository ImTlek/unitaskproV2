import 'package:flutter/material.dart';
import 'package:animations/animations.dart';

class OpenContainerWrapper extends StatelessWidget {
  const OpenContainerWrapper({
    super.key,
    required this.closedBuilder,
    required this.closeChild,
  });

  final CloseContainerBuilder closedBuilder;
  final Widget closeChild;

  @override
  Widget build(BuildContext context) {
    return OpenContainer<bool>(
        transitionType: ContainerTransitionType.fade,
        closedColor: Colors.transparent,
        openColor: Colors.transparent,
        openBuilder: (__, _) => closeChild,
        tappable: false,
        closedBuilder: closedBuilder);
  }
}
