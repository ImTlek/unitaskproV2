import 'widget.dart';
import 'package:flutter/material.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:unitaskpro/features/settings/page.dart';
import 'package:unitaskpro/features/shared/widget/widget.dart';

class HeaderWidget extends StatelessWidget {
  const HeaderWidget({super.key, this.backgroundColor});
  final Color? backgroundColor;

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);

    return SizedBox(
      height: 55,
      child: Row(
        children: [
          Expanded(
            child: CarouselSlider(
              options: CarouselOptions(
                  scrollDirection: Axis.vertical,
                  autoPlay: true,
                  animateToClosest: true),
              items: [
                const GreetingText(locale: Locale('kk'), name: 'Tilek'),
                const LocalizedDateTimeDisplay(),
              ].map((i) {
                return Builder(
                  key: ValueKey(i),
                  builder: (BuildContext context) {
                    return i;
                  },
                );
              }).toList(),
            ),
          ),
          horizontalMargin16,
          Btn(
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const SettingsPage(index: 1),
                  ));
            },
            child: Container(
              padding: const EdgeInsets.all(8.0),
              alignment: Alignment.center,
              decoration: BoxDecoration(
                  color: theme.hoverColor,
                  shape: BoxShape.circle,
                  boxShadow: [
                    // if (brightness == Brightness.light)
                    BoxShadow(
                        color: theme.cardColor.withOpacity(0.2),
                        blurRadius: 5.0,
                        spreadRadius: 2.0)
                  ]),
              child: const Icon(LucideIcons.settings),
            ),
          ),
        ],
      ),
    );
  }

  void _push(BuildContext context, Widget child) {
    var navigator = Navigator.of(context);
    navigator.pop();
    navigator.push(PageRouteBuilder(
        transitionDuration: const Duration(milliseconds: 250),
        reverseTransitionDuration: const Duration(milliseconds: 200),
        transitionsBuilder: (context, animation, secondaryAnimation, child) {
          const begin = Offset(0.0, 1.0);
          const end = Offset.zero;
          final tween = Tween(begin: begin, end: end);
          final offsetAnimation = animation.drive(tween);
          return SlideTransition(position: offsetAnimation, child: child);
        },
        pageBuilder: (context, animation, secondaryAnimation) {
          return child;
        }));
  }
}

class RowItemWidget extends StatelessWidget {
  const RowItemWidget({
    super.key,
    required this.title,
    required this.icon,
    this.onTap,
    this.titleStyle = const TextStyle(),
    this.mainAxisSize = MainAxisSize.max,
    this.color,
  });
  final Widget title;
  final IconData icon;
  final void Function()? onTap;
  final TextStyle titleStyle;
  final MainAxisSize mainAxisSize;

  final Color? color;
  @override
  Widget build(BuildContext context) => color != null
      ? ColoredBox(
          color: color!,
          child: Btn(
            onTap: onTap,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(mainAxisSize: mainAxisSize, children: [
                Icon(
                  icon,
                  color: titleStyle.color,
                ),
                horizontalMargin12,

                title
                // Text(
                //   title,
                //   style: titleStyle,
                // )
              ]),
            ),
          ),
        )
      : Btn(
          onTap: onTap,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(mainAxisSize: mainAxisSize, children: [
              Icon(
                icon,
                color: titleStyle.color,
              ),
              horizontalMargin12,

              title
              // Text(
              //   title,
              //   style: titleStyle,
              // )
            ]),
          ),
        );
}
