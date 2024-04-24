import 'package:flutter/material.dart';
import 'package:unitaskpro/utils/ex.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'package:unitaskpro/provider/section.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:unitaskpro/features/important/provider.dart';
import 'package:unitaskpro/features/shared/widget/common.dart';
import 'package:unitaskpro/features/shared/widget/scaffold.dart';
import 'package:unitaskpro/features/shared/widget/expansiontile.dart';

@immutable
class ImportantPage extends ConsumerWidget {
  const ImportantPage({super.key});

  @override
  Widget build(BuildContext context, ref) {
    ref.watch(sectionProvider);

    var provider = ref.read(sectionProvider.notifier);
    var allTasks = getImportantTasks(ref);
    return Scaffold(
        body: CustomScrollView(
      slivers: [
        SlieverAppBar(
            title:context.local.tImportant,
            leading: IconButton(
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
                ))),
        SliverPadding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          sliver: SliverList.builder(
            itemCount: 20,
            itemBuilder: (context, index) {
              return emptyWidget;
            },
          ),
        ),
        SliverPadding(
          padding: const EdgeInsets.symmetric(horizontal: 8),
          sliver: SliverList.separated(
            separatorBuilder: (context, index) => verticalMargin4,
            itemCount: allTasks.length,
            itemBuilder: (context, index) {
              var mydayTask = allTasks[index];
              return TaskItem(
                mydayTask: mydayTask,
                onDoneChanged: (isDone) {
                  provider.updateTaskById(mydayTask.copyWith(isDone: isDone));
                },
                onIsStarChanged: (isStar) {
                  provider.updateTaskById(mydayTask.copyWith(isStar: isStar));
                },
                delte: () {
                  provider.removeTaskById(mydayTask);
                },
                remove: () {
                  provider.updateTaskById(mydayTask.copyWith(isMyDay: false));
                },
              );
            },
          ),
        )
      ],
    ));
  }
}
