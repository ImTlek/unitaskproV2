import 'package:flutter/material.dart';
import 'package:unitaskpro/features/shared/widget/widget.dart';

@immutable
class ItemWidget extends StatelessWidget {
  const ItemWidget(
      {super.key,
      required this.title,
      required this.iconData,
      required this.index,
      this.onIndex});

  final IconData iconData;
  final String title;
  final int index;
  final ValueChanged<int>? onIndex;

  @override
  Widget build(BuildContext context) {
    var themeData = Theme.of(context);
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 1),
      decoration: BoxDecoration(
          color: themeData.hoverColor, borderRadius: BorderRadius.circular(4)),
      child: Btn(
        onTap: () {
          onIndex?.call(index);
        },
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(children: [
            Icon(iconData, color: themeData.colorScheme.primary),
            horizontalMargin8,
            Text(title)
          ]),
        ),
      ),
    );
  }
}
