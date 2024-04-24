import 'common.dart';
import 'widget.dart';
import 'package:flutter/material.dart';
import 'package:lucide_icons/lucide_icons.dart';

class ScaffoldWidget extends StatelessWidget {
  final Widget? body;
  final Widget? floatingActionButton;
  final PreferredSizeWidget? appBar;
  final FloatingActionButtonAnimator? floatingActionButtonAnimator;
  final Widget? drawer;
  final Color? backgroundColor;
  final Widget? bottomNavigationBar;
  final Widget? bottomSheet;
  final bool? resizeToAvoidBottomInset;
  final FloatingActionButtonLocation? floatingActionButtonLocation;
  final GlobalKey<ScaffoldState>? scaffoldKey;

  const ScaffoldWidget({
    super.key,
    this.scaffoldKey,
    this.body,
    this.floatingActionButton,
    this.appBar,
    this.floatingActionButtonAnimator,
    this.drawer,
    this.backgroundColor,
    this.bottomNavigationBar,
    this.bottomSheet,
    this.resizeToAvoidBottomInset,
    this.floatingActionButtonLocation,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      resizeToAvoidBottomInset: resizeToAvoidBottomInset,
      extendBody: false,
      floatingActionButton: floatingActionButton,
      floatingActionButtonLocation: floatingActionButtonLocation,
      floatingActionButtonAnimator: floatingActionButtonAnimator,
      appBar: appBar,
      body: body,
      drawer: drawer,
      backgroundColor: backgroundColor,
      bottomSheet: bottomSheet,
      bottomNavigationBar: bottomNavigationBar,
    );
  }
}

@immutable
class AppBarWidget extends StatelessWidget implements PreferredSizeWidget {
  const AppBarWidget(
      {super.key,
      this.backgroundColor,
      this.centerTitle = false,
      this.elevation = 0,
      this.title,
      this.automaticallyImplyLeading = true,
      this.actions = const [],
      this.titleStyle});
  final bool automaticallyImplyLeading;
  final Color? backgroundColor;
  final double? elevation;
  final bool? centerTitle;
  final String? title;
  final List<Widget> actions;
  final TextStyle? titleStyle;

  @override
  Widget build(BuildContext context) {
    final ModalRoute<dynamic>? parentRoute = ModalRoute.of(context);
    final bool canPop = parentRoute?.canPop ?? false;
    var themeData = Theme.of(context);
    var isDark = themeData.brightness == Brightness.dark;

    // return AppBar(automaticallyImplyLeading: false, actions: [
    //   IconButton(
    //       padding: const EdgeInsets.only(right: 8),
    //       splashColor: Colors.transparent,
    //       highlightColor: Colors.transparent,
    //       alignment: Alignment.center,
    //       onPressed: () {
    //         Navigator.of(context).maybePop();
    //       },
    //       iconSize: 24,
    //       icon: const Icon(LucideIcons.x, size: 28))
    // ]);
    return AppBar(
        actionsIconTheme:
            IconThemeData(color: isDark ? Colors.white : Colors.black),
        // flexibleSpace: !canPop
        //     ? emptyWidget
        //     : IconButton(
        //         splashColor: Colors.transparent,
        //         highlightColor: Colors.transparent,
        //         alignment: Alignment.center,
        //         onPressed: () {
        //           Navigator.of(context).maybePop();
        //         },
        //         iconSize: 24,
        //         icon: const Icon(
        //           LucideIcons.shieldClose,
        //           size: 28,
        //         )),
        elevation: elevation,
        centerTitle: centerTitle,
        titleTextStyle: TextStyle(
            color: isDark ? Colors.white : Colors.black,
            fontSize: 18,
            fontWeight: FontWeight.w600),
        leading: !canPop
            ? emptyWidget
            : IconButton(
                splashColor: Colors.transparent,
                highlightColor: Colors.transparent,
                alignment: Alignment.center,
                onPressed: () {
                  Navigator.of(context).maybePop();
                },
                iconSize: 24,
                icon: const Icon(
                  LucideIcons.x,
                  size: 28,
                )),
        automaticallyImplyLeading: false,
        titleSpacing: canPop ? 0 : null,
        title: title == null
            ? emptyWidget
            : Text(
                title!,
                style: titleStyle,
                textAlign: TextAlign.start,
              ),
        actions: [Row(children: actions)]);
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}

@immutable
class SlieverAppBar extends StatelessWidget {
  const SlieverAppBar({super.key, this.actions, this.title,this.leading});
  final List<Widget>? actions;
  final String? title;

  final Widget? leading;

  @override
  Widget build(BuildContext context) {
    var themeData = Theme.of(context);

    return SliverAppBar.medium(
      leading: leading,
        // backgroundColor: Colors.transparent,
        surfaceTintColor: Colors.transparent,
        title: Text(title ?? ''),
        titleTextStyle: themeData.appBarTheme.titleTextStyle?.copyWith(
            letterSpacing: 4, fontSize: 33, fontWeight: FontWeight.bold),
        automaticallyImplyLeading: false,
        actions: actions);
  }
}
