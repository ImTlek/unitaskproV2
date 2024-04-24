import 'shared/widget/widget.dart';
import 'package:flutter/material.dart';
import 'package:unitaskpro/constant/pages.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class AppMain extends StatefulWidget {
  const AppMain._();
  static Route<void> route() {
    return PageRouteBuilder(
      pageBuilder: (
        BuildContext context,
        Animation<double> animation,
        Animation<double> secondaryAnimation,
      ) {
        return FadeTransition(
          opacity: animation,
          child: const AppMain._(),
        );
      },
    );
  }

  @override
  State<AppMain> createState() => _AppMainState();
}

class _AppMainState extends State<AppMain> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(child: Consumer(builder: (context, ref, child) {
      var index = ref.watch(indexNotifireProvider);
      return LazyIndexedStack(index: index, children: page.keys.toList());
    })), bottomNavigationBar: Consumer(builder: (context, ref, child) {
      return BtmNav(
          currentIndex: ref.watch(indexNotifireProvider),
          onTap: ref.read(indexNotifireProvider.notifier).onIndex);
    }));
  }
}

final indexNotifireProvider =
    NotifierProvider<IndexNotifire, int>(IndexNotifire.new);

class IndexNotifire extends Notifier<int> {
  @override
  int build() => 1;
  void onIndex(int i) => state = i;
}
