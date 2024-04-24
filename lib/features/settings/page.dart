import 'model/model.dart';
import 'widget/widget.dart';
import 'package:flutter/material.dart';
import 'package:unitaskpro/utils/ex.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:unitaskpro/features/home/widget/header.dart';
import 'package:unitaskpro/features/shared/widget/widget.dart';
import 'package:unitaskpro/features/settings/provider/provider.dart';

@immutable
class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key, required this.index});

  final int index;

  @override
  Widget build(BuildContext context) {
    return ScaffoldWidget(
      body: SafeArea(
        child: Stack(
          children: [
            ListView(
              children: [
                SettingNavWidget(index: index),
                Consumer(
                  builder: (context, ref, child) {
                    var i = ref.watch(settingsNotifireProvider(index));
                    return LazyIndexedStack(
                      index: i.index,
                      children: settings(context).map((e) => e.child).toList(),
                    );
                  },
                )
              ],
            ),
            Align(
              alignment: Alignment.topCenter,
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    IconButton.outlined(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        icon: const Icon(LucideIcons.x)),
                    IconButton.outlined(
                        onPressed: () {
                          showSheet(context,
                              child: Column(
                                children: [
                                  RowItemWidget(
                                      onTap: () async {
                                        // FirebaseAuth.instance.signOut();
                                        // await authService.signOut();
                                        await FirebaseAuth.instance.signOut();
                                      },
                                      title: Text(context.local.tLogout),
                                      icon: LucideIcons.logOut),
                                  RowItemWidget(
                                    onTap: () {},
                                    title: Text(context.local.tDeleteaccount),
                                    icon: LucideIcons.trash2,
                                    titleStyle:
                                        const TextStyle(color: Colors.red),
                                  ),
                                ],
                              ));
                        },
                        icon: const Icon(LucideIcons.moreVertical)),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}

List<SettingModel> settings(BuildContext context) => [
      SettingModel(
          iconData: LucideIcons.smilePlus,
          child: const ProfileWidget(),
          title: context.local.tProfile,
          index: 0),
      SettingModel(
          iconData: LucideIcons.globe2,
          child: const LanWidget(),
          title: context.local.tTheme,
          index: 1),
      // SettingModel(
      //     iconData: LucideIcons.thermometerSnowflake,
      //     child: const ThemeWidget(),
      //     title: 'Theme',
      //     index: 2),
      SettingModel(
          iconData: LucideIcons.info,
          child: const AboutWidget(),
          title: context.local.tAbout,
          index: 3),
    ];
