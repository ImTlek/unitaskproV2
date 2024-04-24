import 'package:flutter/cupertino.dart';


@immutable
class LoadingWid extends StatelessWidget {
  const LoadingWid({super.key, this.child});

  final Widget? child;

  @override
  Widget build(BuildContext context) {
    return const Center(
        child: RepaintBoundary(child: CupertinoActivityIndicator()));
  }
}
