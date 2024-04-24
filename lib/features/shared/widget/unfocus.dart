import 'package:flutter/material.dart';

@immutable
class UnfocusWidget extends StatelessWidget {
  const UnfocusWidget({super.key, required this.child});
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: FocusManager.instance.primaryFocus?.unfocus,
      //  () {
      //   FocusManager.instance.primaryFocus?.unfocus();
      // }, // FocusScope.of(context).unfocus,
      child: child,
    );
  }
}
