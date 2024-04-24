import 'package:flutter/material.dart';
import 'package:unitaskpro/app/root.dart';
import 'package:unitaskpro/utils/ex.dart';
import 'package:unitaskpro/services/service.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:unitaskpro/features/shared/widget/widget.dart';

class LanWidget extends StatelessWidget {
  const LanWidget({super.key});
  static Map map = {'en': 'English', 'kk': 'Kazakhstan', 'ru': 'Russian'};
  static List<String> themeMode = ['light', 'dark', 'system'];
  @override
  Widget build(BuildContext context) {
    var themeData = Theme.of(context);
    var name = context.local.localeName;

    final Brightness brightness = themeData.brightness;

    return Column(
      children: [
        Card(
            margin: const EdgeInsets.all(12),
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        context.local.tLanguage,
                        style: themeData.textTheme.titleLarge,
                      ),
                      verticalMargin4,
                      Text(
                        'Customize youre app language',
                        style: themeData.textTheme.labelLarge,
                      ),
                    ],
                  ),
                  verticalMargin16,
                  Row(children: [
                    ...map.entries.map(
                      (e) {
                        var selected = name == e.key;
                        return GestureDetector(
                          onTap: () {
                            Root.of(context)?.setLocale(Locale(e.key));
                          },
                          child: Container(
                            padding: const EdgeInsets.all(8),
                            margin: const EdgeInsets.only(right: 8),
                            decoration: BoxDecoration(
                              border: Border.all(
                                color: selected
                                    ? themeData.primaryColor.withOpacity(.2)
                                    : themeData.primaryColor,
                              ),
                              color: !selected
                                  ? themeData.primaryColor.withOpacity(.2)
                                  : themeData.primaryColor,
                              borderRadius: BorderRadius.circular(4),
                            ),
                            child: Text(e.value),
                          ),
                        );
                      },
                    ),
                    // const Spacer(),
                  ])
                ],
              ),
            )),
        Card(
          margin: const EdgeInsets.all(12),
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      context.local.tTheme,
                      style: themeData.textTheme.titleLarge,
                    ),
                    verticalMargin4,
                    Text(
                      'Customize youre app interface',
                      style: themeData.textTheme.labelLarge,
                    )
                  ],
                ),
                verticalMargin16,
                Consumer(
                  builder: (context, ref, child) {
                    var themeController = ref.watch(themeControllerProvider);
                    return Row(children: [
                      ...themeMode.map(
                        (e) {
                          var selected = brightness.name == e.toString();
                          return GestureDetector(
                            onTap: () {
                              switch (e) {
                                case 'light':
                                  ref
                                      .read(themeControllerProvider)
                                      .setThemeMode(ThemeMode.light);
                                  break;

                                case 'dark':
                                  ref
                                      .read(themeControllerProvider)
                                      .setThemeMode(ThemeMode.dark);
                                  break;
                                default:
                                  ref
                                      .read(themeControllerProvider)
                                      .setThemeMode(ThemeMode.system);
                              }
                            },
                            child: Container(
                              padding: const EdgeInsets.all(8),
                              margin: const EdgeInsets.only(right: 8),
                              decoration: BoxDecoration(
                                border: Border.all(
                                  color: selected
                                      ? themeData.primaryColor.withOpacity(.2)
                                      : themeData.primaryColor,
                                ),
                                color: !selected
                                    ? themeData.primaryColor.withOpacity(.2)
                                    : themeData.primaryColor,
                                borderRadius: BorderRadius.circular(4),
                              ),
                              child: Text(e),
                            ),
                          );
                        },
                      ),
                      const Spacer(),
                      ThemePopupMenu(
                        contentPadding: EdgeInsets.zero,
                        schemeIndex: themeController.schemeIndex,
                        onChanged: (value) {
                          ref
                              .read(themeControllerProvider)
                              .setSchemeIndex(value);
                        },
                      ),
                    ]);
                  },
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
