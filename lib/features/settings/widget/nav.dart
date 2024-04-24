import 'package:flutter/material.dart';
import 'package:unitaskpro/utils/ex.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:unitaskpro/features/settings/page.dart';
import 'package:unitaskpro/features/shared/widget/widget.dart';
import 'package:unitaskpro/features/settings/provider/provider.dart';

class SettingNavWidget extends StatelessWidget {
  const SettingNavWidget({super.key, required this.index});
  final int index;

  @override
  Widget build(BuildContext context) {
    var themeData = Theme.of(context);

    return ColoredBox(
      color: themeData.hoverColor,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          verticalMargin48,
          verticalMargin12,
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: Text(
           
           context.local.tSettings,
              style: themeData.textTheme.displaySmall
                  ?.copyWith(fontWeight: FontWeight.bold),
            ),
          ),
          Consumer(
            builder: (context, ref, child) {
              var i = ref.watch(settingsNotifireProvider(index));
              return SizedBox(
                height: 55,
                child: ListView.separated(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
                  itemCount: settings(context).length,
                  separatorBuilder: (context, index) => horizontalMargin12,
                  itemBuilder: (context, index) {
                    var settingModel = settings(context)[index];

                    var selected = index == i.index;

                    return Ink(
                      decoration: BoxDecoration(
                          border: Border.all(
                              color: themeData.dividerColor.withOpacity(.2)),
                          color: selected
                              ? themeData.hoverColor
                              : themeData.cardColor,
                          borderRadius: BorderRadius.circular(30)),
                      child: InkWell(
                        borderRadius: BorderRadius.circular(30),
                        onTap: () {
                          i.onIndex(index);
                        },
                        child: Center(
                          child: Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 8),
                              child: Text(settingModel.title)),
                        ),
                      ),
                    );
                  },
                  scrollDirection: Axis.horizontal,
                ),
              );
            },
          ),
          verticalMargin16,
        ],
      ),
    );
  }
}
