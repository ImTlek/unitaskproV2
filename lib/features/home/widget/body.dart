import 'package:flutter/material.dart';
import 'package:unitaskpro/utils/ex.dart';
import 'package:unitaskpro/model/task.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'package:unitaskpro/provider/section.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:unitaskpro/features/shared/widget/widget.dart';

@immutable
class BodyWidget extends ConsumerWidget {
  const BodyWidget({super.key});

  @override
  Widget build(BuildContext context, ref) {
    var asyncValue = ref.watch(sectionProvider);
    return asyncValue.when(
        data: (data) {
          return Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('${data.length} ${context.local.tSection}',
                      style: const TextStyle(fontSize: 18)),
                  Btn(
                    child: const Icon(LucideIcons.plusCircle, size: 28),
                    onTap: () {
                      var child = AddWidget(
                          onAdd: (title) {
                            ref
                                .read(sectionProvider.notifier)
                                .addSection(title, context);
                          },
                          child: emptyWidget);
                      showSheet(context, child: child);
                    },
                  ),
                ],
              ),
              verticalMargin4,
              ListView.builder(
                physics: const NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                itemCount: asyncValue.requireValue.entries.length,
                itemBuilder: (context, index) {
                  var data = asyncValue.requireValue.entries.toList()[index];
                  return ListExpansionListWidget(
                    keys: data.key,
                    onAddTask: () {
                      var child = AddTaskWidget(onAdd: (TaskModel taskModel) {
                        ref
                            .read(sectionProvider.notifier)
                            .addTask(data, taskModel);
                      });

                      showSheet(context, child: child);
                    },
                    listModel: data.value,
                    onDelete: (id) {
                      ref.read(sectionProvider.notifier).remove(id);
                    },
                  );
                },
              )
            ],
          );
        },
        error: (error, stackTrace) {
          return Center(child: Text(error.toString()));
        },
        loading: () => const LoadingWid());
  }
}
