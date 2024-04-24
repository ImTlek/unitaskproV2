import 'common.dart';
import 'animation.dart';
import 'package:flutter/material.dart';
import 'package:unitaskpro/model/task.dart';
import 'package:unitaskpro/model/list.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'package:unitaskpro/features/task/datail.dart';
import 'package:unitaskpro/features/myday/detail.dart';
import 'package:super_context_menu/super_context_menu.dart';
import 'package:unitaskpro/features/shared/widget/btn.dart'; 

@immutable
class ExpansionTileWidget extends StatefulWidget {
  const ExpansionTileWidget(
      {super.key, required this.title, required this.body});

  final String title;
  final String body;

  @override
  State<ExpansionTileWidget> createState() => _ExpansionTileWidgetState();
}

class _ExpansionTileWidgetState extends State<ExpansionTileWidget> {
  ValueNotifier<bool> isExpanded = ValueNotifier(false);
  @override
  void dispose() {
    isExpanded.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var themeData = Theme.of(context);

    return Column(
      children: [
        verticalMargin4,
        ExpansionTile(
          backgroundColor: Colors.transparent,
          childrenPadding:
              const EdgeInsets.only(left: 12, right: 12, bottom: 12),
          maintainState: true,
          collapsedBackgroundColor: Colors.transparent,
          onExpansionChanged: (b) {
            isExpanded.value = b;
          },
          controller: ExpansionTileController.maybeOf(context),
          trailing: ValueListenableBuilder<bool>(
            valueListenable: isExpanded,
            builder: (context, isExpanded, child) => Icon(
              isExpanded
                  ? Icons.arrow_upward_sharp
                  : Icons.arrow_downward_outlined,
              color: isExpanded ? themeData.primaryColor : null,
              key: ValueKey(isExpanded),
            ),
          ),
          iconColor: themeData.iconTheme.color,
          collapsedTextColor: themeData.textTheme.titleLarge?.color,
          controlAffinity: ListTileControlAffinity.trailing,
          textColor: themeData.textTheme.bodyLarge?.color,
          collapsedIconColor: themeData.iconTheme.color,
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
              side: BorderSide(color: themeData.primaryColor, width: 1)),
          collapsedShape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
              side: BorderSide(
                color: themeData.dividerColor,
                width: 1,
              )),
          tilePadding: const EdgeInsets.all(12),
          title: Text(
            widget.title,
            style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w600,
                color: themeData.textTheme.bodyLarge?.color),
          ),
          expandedCrossAxisAlignment: CrossAxisAlignment.start,
          expandedAlignment: Alignment.centerLeft,
          children: <Widget>[
            Text(
              widget.body,
              style: TextStyle(color: themeData.textTheme.bodyLarge?.color),
            )
          ],
        ),
        verticalMargin4
      ],
    );
  }
}

@immutable
class ListExpansionListWidget extends StatelessWidget {
  const ListExpansionListWidget({
    super.key,
    required this.listModel,
    this.onDelete,
    required this.onAddTask,
    required this.keys,
  });
  final ListModel listModel;
  final void Function(int id)? onDelete;
  final Function() onAddTask;
  final dynamic keys;

  @override
  Widget build(BuildContext context) {
    var themeData = Theme.of(context);
    return ContextMenuWidget(
        menuProvider: (_) {
          return Menu(
            children: [
              MenuAction(
                  image: MenuImage.icon(LucideIcons.trash2),
                  state: MenuActionState.none,
                  title: 'Delete',
                  callback: () {
                    onDelete?.call((keys));
                  }),
            ],
          );
        },
        child: ExpansionListWidget(
          onTrailingTap: onAddTask,
          title: Text(
            listModel.title,
            style: themeData.textTheme.bodyLarge,
          ),
          children: listModel.tasks
              .map(
                (e) => InkWell(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) =>
                              TaskDetailPage(taskModel: e, keys: keys),
                        ));
                  },
                  child: Container(
                    alignment: Alignment.centerLeft,
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      // color: Colors.amber,
                      borderRadius: BorderRadius.circular(4),
                    ),
                    child: Text(e.title),
                  ),
                ),
              )
              .toList(),
        ));
  }
}

@immutable
class ExpansionListWidget extends StatefulWidget {
  const ExpansionListWidget({
    super.key,
    required this.title,
    required this.children,
    this.onTrailingTap,
  });

  final Widget title;
  final List<Widget> children;
  final Function()? onTrailingTap;

  @override
  State<ExpansionListWidget> createState() => _ExpansionListWidgetState();
}

class _ExpansionListWidgetState extends State<ExpansionListWidget> {
  ValueNotifier<bool> isExpanded = ValueNotifier(false);
  @override
  void dispose() {
    isExpanded.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var themeData = Theme.of(context);

    return Column(
      children: [
        verticalMargin4,
        ValueListenableBuilder(
          valueListenable: isExpanded,
          builder: (context, isExpandeds, child) => ExpansionTile(
              dense: true,
              expansionAnimationStyle: AnimationStyle(),
              backgroundColor: Colors.transparent,
              childrenPadding:
                  const EdgeInsets.only(left: 25, right: 8, bottom: 4),
              maintainState: true,
              collapsedBackgroundColor: Colors.transparent,
              onExpansionChanged: (b) {
                isExpanded.value = b;
              },
              controller: ExpansionTileController.maybeOf(context),
              trailing: Btn(
                  onTap: widget.onTrailingTap,
                  child: !isExpandeds
                      ? emptyWidget
                      : const SizedBox(
                          height: 33,
                          width: 33,
                          child: Icon(LucideIcons.plus))),
              iconColor: themeData.iconTheme.color,
              collapsedTextColor: themeData.textTheme.titleLarge?.color,
              controlAffinity: ListTileControlAffinity.trailing,
              textColor: themeData.textTheme.bodyLarge?.color,
              collapsedIconColor: themeData.iconTheme.color,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(4),
                  side: const BorderSide(color: Colors.transparent)),
              title: Row(children: [
                Icon(
                    isExpandeds
                        ? LucideIcons.chevronDown
                        : LucideIcons.chevronRight,
                    color: themeData.colorScheme.primary),
                widget.title
              ]),
              tilePadding: const EdgeInsets.symmetric(horizontal: 4),
              expandedCrossAxisAlignment: CrossAxisAlignment.start,
              expandedAlignment: Alignment.centerLeft,
              children: widget.children),
        ),
        verticalMargin4
      ],
    );
  }
}

@immutable
class TaskItem extends StatelessWidget {
  const TaskItem({
    super.key,
    this.background,
    required this.mydayTask,
    required this.onDoneChanged,
    required this.onIsStarChanged,
    required this.delte,
    required this.remove,
  });
  final Color? background;
  final TaskModel mydayTask;

  final void Function(bool? isDone)? onDoneChanged;
  final void Function(bool isStar) onIsStarChanged;
  final void Function() delte;
  final void Function() remove;

  @override
  Widget build(BuildContext context) {
    var themeData = Theme.of(context);

    return ContextMenuWidget(
      hitTestBehavior: HitTestBehavior.opaque,
      menuProvider: (_) {
        return Menu(
          title: 'Manage',
          children: [
            MenuAction(
                image: MenuImage.icon(LucideIcons.trash2),
                state: MenuActionState.none,
                title: 'Delete',
                callback: delte),
            MenuAction(
                title: 'Remove from Myday',
                callback: remove,
                image: MenuImage.icon(LucideIcons.listMinus)),
          ],
        );
      },
      child: OpenContainerWrapper(
          closedBuilder: (context, action) => InkWell(
              onTap: action,
              child: DecoratedBox(
                  decoration: BoxDecoration(
                      color: background ??
                          themeData.colorScheme.background.withOpacity(.3),
                      borderRadius: BorderRadius.circular(6)),
                  child: Row(children: [
                    Checkbox(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(6)),
                      value: mydayTask.isDone,
                      onChanged: onDoneChanged,
                    ),
                    Expanded(
                      child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(mydayTask.title),
                            Text(mydayTask.description),
                          ]),
                    ),
                    Btn(
                        onTap: () {
                          onIsStarChanged(!mydayTask.isStar);
                        },
                        child: Icon(mydayTask.isStar
                            ? Icons.star
                            : Icons.star_outline_sharp))
                  ]))),
          closeChild: MyTaskDetailPage(taskModel: mydayTask)),
    );
  }

  Widget slideRightBackground() {
    return Container(
        color: Colors.green,
        child: const Align(
            alignment: Alignment.centerRight,
            child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: <Widget>[
                  Icon(LucideIcons.layoutList, color: Colors.white),
                  horizontalMargin16
                ])));
  }
}

class CheckWidget extends StatelessWidget {
  const CheckWidget({super.key, this.value = false});
  final bool value;

  @override
  Widget build(BuildContext context) {
    return Icon(value ? LucideIcons.circle : LucideIcons.checkCircle2,
        size: 10);
  }
}

class CalendarWidget extends StatelessWidget {
  const CalendarWidget({super.key, this.color});
  final Color? color;

  @override
  Widget build(BuildContext context) {
    return Icon(LucideIcons.calendarDays, size: 10, color: color);
  }
}
