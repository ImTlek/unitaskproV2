import 'package:flutter/material.dart';
import 'package:unitaskpro/services/theme/constant/app.color.dart';

@immutable
class ThemePopupMenu extends StatelessWidget {
  const ThemePopupMenu({
    super.key,
    required this.schemeIndex,
    required this.onChanged,
    this.contentPadding,
  });
  final int schemeIndex;
  final ValueChanged<int> onChanged;
  final EdgeInsetsGeometry? contentPadding;

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    final bool isLight = theme.brightness == Brightness.light;
    final ColorScheme colorScheme = theme.colorScheme;

    return PopupMenuButton<int>(
      tooltip: '',
      padding: EdgeInsets.zero,
      splashRadius: 4,
      elevation: 0,
      // surfaceTintColor: Colors.transparent,
      color: colorScheme.primary.withOpacity(.3),
      offset: Offset.zero,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),
      position: PopupMenuPosition.under,
      onSelected: onChanged,
      itemBuilder: (BuildContext context) => <PopupMenuItem<int>>[
        for (int i = 0; i < AppColor.customSchemes.length; i++)
          PopupMenuItem<int>(
              height: 55,
              padding: const EdgeInsets.symmetric(horizontal: 8),
              value: i,
              child: Container(
                height: 44,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(4),
                  color: isLight
                      ? AppColor.customSchemes[i].light.primary
                      : AppColor.customSchemes[i].dark.primary,
                ),
              ))
      ],
      child: CircleAvatar(
        backgroundColor: colorScheme.primary,
        child: Icon(Icons.color_lens_sharp,
            color: isLight ? colorScheme.background : colorScheme.onBackground),
      ),
    );
  }
}
