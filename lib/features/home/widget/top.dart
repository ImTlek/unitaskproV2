import 'package:flutter/material.dart';
import 'package:unitaskpro/utils/ex.dart';
import 'package:unitaskpro/features/app.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:unitaskpro/features/task/page.dart';
import 'package:unitaskpro/features/myday/page.dart';
import 'package:unitaskpro/features/message/page.dart';
import 'package:unitaskpro/features/schedule/page.dart';
import 'package:unitaskpro/features/important/page.dart';
import 'package:unitaskpro/features/home/widget/item.dart';

class TopWidget extends ConsumerWidget {
  const TopWidget({super.key});

  @override
  Widget build(BuildContext context, ref) {
    return Column(
      children: [
        ItemWidget(
          iconData: MydayPage.icon,
          index: 1,
          title: context.local.tMyday,
          onIndex: ref.read(indexNotifireProvider.notifier).onIndex,
        ),
        ItemWidget(
          iconData: TaskPage.icon,
          index: 2,
          title: context.local.tTask,
          onIndex: ref.read(indexNotifireProvider.notifier).onIndex,
        ),
        ItemWidget(
          iconData: MessagePage.icon,
          index: 3,
          title: context.local.tImportant,
          onIndex: (i) {
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => const ImportantPage()));
          },
        ),
        ItemWidget(
          iconData: SchedulePage.icon,
          index: 3,
          title: context.local.tSchedule,
          onIndex: ref.read(indexNotifireProvider.notifier).onIndex,
        ),
      ],
    );
  }
}
