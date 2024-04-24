import 'package:flutter/material.dart';
import 'package:unitaskpro/constant/pages.dart';

class BtmNav extends StatelessWidget {
  const BtmNav({super.key, this.onTap, this.currentIndex = 0});
  final void Function(int)? onTap;
  final int currentIndex;

  List<BottomNavigationBarItem> get navs {
    return page.entries
        .map((e) => BottomNavigationBarItem(icon: Icon(e.value), label: ''))
        .toList();
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: currentIndex == 0,
      onPopInvoked: (didPop) {
        if (didPop) return;
        onTap?.call(0);
      },
      child: BottomNavigationBar(
        elevation: 30,
        landscapeLayout: BottomNavigationBarLandscapeLayout.linear,
        useLegacyColorScheme: true,
        enableFeedback: false,
        showSelectedLabels: false,
        showUnselectedLabels: false,
        type: BottomNavigationBarType.fixed,
        currentIndex: currentIndex,
        onTap: onTap,
        items: navs,
      ),
    );
  }
}
