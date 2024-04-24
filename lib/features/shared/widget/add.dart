import 'widget.dart';
import 'package:intl/intl.dart';
import 'package:flutter/material.dart';
import 'package:unitaskpro/utils/ex.dart';
import 'package:unitaskpro/model/list.dart';
import 'package:unitaskpro/model/task.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'package:flutter_popup/flutter_popup.dart';
import 'package:unitaskpro/provider/section.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:date_picker_plus/date_picker_plus.dart';
import 'package:unitaskpro/features/home/widget/widget.dart';
import 'package:flutter_datetime_picker_bdaya/flutter_datetime_picker_bdaya.dart';

@immutable
class AddWidget extends StatelessWidget {
  const AddWidget(
      {super.key, required this.child, required this.onAdd, this.hitText = ''});
  final Widget child;
  final ValueChanged<String> onAdd;
  final String hitText;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
            padding: const EdgeInsets.all(8.0),
            child: AddFiledWidget(show: true, hintText: hitText, onAdd: onAdd)),
        child,
        verticalMargin12,
      ],
    );
  }
}

@immutable
class AddTaskWidget extends StatefulWidget {
  const AddTaskWidget({
    super.key,
    required this.onAdd,
    this.hitText = ',',
    this.isMyday = false,
    this.onMyDayAdd,
  });

  final Function(TaskModel task) onAdd;
  final String hitText;
  final bool isMyday;
  final void Function(MapEntry<dynamic, ListModel> map, TaskModel task)?
      onMyDayAdd;

  @override
  State<AddTaskWidget> createState() => _AddTaskWidgetState();
}

class _AddTaskWidgetState extends State<AddTaskWidget> {
  late final TextEditingController controller = TextEditingController();

  bool isEdit = false;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPersistentFrameCallback((timeStamp) {
      controller.addListener(editListener);
    });
  }

  void editListener() {
    isEdit = controller.text.isNotEmpty;
    setState(() {});
  }

  @override
  void dispose() {
    controller.removeListener(editListener);
    super.dispose();
  }

  DateTime? dueDate;
  DateTime? remindDate;
  late bool isMyday = widget.isMyday;
  MapEntry<dynamic, ListModel>? map;

  @override
  Widget build(BuildContext context) {
    var themeData = Theme.of(context);

    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Card(
            color: themeData.cardColor,
            margin: EdgeInsets.zero,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15.0)),
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxHeight: 100),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  horizontalMargin12,
                  Expanded(
                    child: TextField(
                        autofocus: true,
                        controller: controller,
                        keyboardType: TextInputType.multiline,
                        maxLines: null,
                        decoration: const InputDecoration(
                            filled: false,
                            border: InputBorder.none,
                            focusedBorder: InputBorder.none,
                            enabledBorder: InputBorder.none,
                            errorBorder: InputBorder.none,
                            disabledBorder: InputBorder.none,
                            hintStyle: TextStyle())
                            
                            
                            ),
                  ),
                  !isEdit
                      ? emptyWidget
                      : Padding(
                          padding: const EdgeInsets.only(right: 1, top: 2),
                          child: Btn(
                            onTap: () {
                              var time = DateTime.now();

                              var data = TaskModel(
                                  isMyDay: isMyday,
                                  id: DateTime.now()
                                      .millisecondsSinceEpoch
                                      .toString(),
                                  img: '',
                                  isDone: false,
                                  isStar: false,
                                  createdAt: time,
                                  description: '',
                                  finishedAt: dueDate ??
                                      DateTime(time.year, time.month, time.day,
                                          time.hour + 6),
                                  startedAt: time,
                                  title: controller.text,
                                  updatedAt: time);

                              if (isMyday && map != null) {
                                widget.onMyDayAdd?.call(map!, data);
                              } else {
                                widget.onAdd(data);
                              }

                              Navigator.maybePop(context);
                            },
                            child: Container(
                              alignment: Alignment.center,
                              height: 38,
                              width: 38,
                              margin: const EdgeInsets.all(4),
                              decoration: BoxDecoration(
                                  color: themeData.hoverColor,
                                  borderRadius: BorderRadius.circular(10)),
                              child: const Icon(LucideIcons.arrowUpFromDot),
                            ),
                          )),
                ],
              ),
            ),
          ),
        ),
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            children: [
              if (isMyday)
                Row(
                  children: [
                    horizontalMargin4,
                    Consumer(
                      builder: (context, ref, child) {
                        var read = ref.read(sectionProvider);

                        return RowItemWidget(
                          title: Text(isMyday
                              ? map?.value.title ?? context.local.tMyday
                              : 'Task'),
                          icon: LucideIcons.home,
                          onTap: () {
                            var child = Container(
                              alignment: Alignment.center,
                              child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: read.requireValue.entries
                                      .map((e) => Btn(
                                            onTap: () {
                                              map = e;

                                              // widget.onMyDayAdd?.call();
                                              setState(() {});

                                              Navigator.maybePop(context);
                                            },
                                            child: Padding(
                                                padding:
                                                    const EdgeInsets.all(8),
                                                child: Text(e.value.title)),
                                          ))
                                      .toList()),
                            );
                            showSheet(context, child: child);
                          },
                        );
                      },
                    ),
                  ],
                ),
              horizontalMargin8,
              RowItemWidget(
                onTap: () async {
                  var dateTime = DateTime.now();
                  dueDate = await showDatePickerDialog(
                    context: context,
                    minDate: dateTime,
                    maxDate: DateTime(dateTime.year, dateTime.day + 30),
                  );

                  setState(() {});
                },
                title: dueDate == null
                    ? Text(context.local.tDuedate)
                    : Container(
                        padding: const EdgeInsets.symmetric(
                            vertical: 3, horizontal: 4),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(4),
                          border: Border.all(color: themeData.primaryColor),
                        ),
                        child: Text(DateFormat("dd-MM-yyyy").format(dueDate!))),
                icon: LucideIcons.calendarDays,
              ),
              horizontalMargin8,
              RowItemWidget(
                title: remindDate == null
                    ? Text(context.local.tRemindme)
                    : Container(
                        padding: const EdgeInsets.symmetric(
                            vertical: 3, horizontal: 4),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(4),
                          border: Border.all(color: themeData.primaryColor),
                        ),
                        child: Text(DateFormat("dd-MM-yyyy hh-mm")
                            .format(remindDate!))),
                icon: LucideIcons.activity,
                onTap: () {
                  DatePickerBdaya.showDateTimePicker(
                    context,
                    onConfirm: (date) {
                      remindDate = date;
                      setState(() {});
                    },
                    currentTime: DateTime.now(),
                  );
                },
              ),
              if (!widget.isMyday)
                Row(
                  children: [
                    horizontalMargin8,
                    RowItemWidget(
                      title: Container(
                          padding: const EdgeInsets.symmetric(
                              vertical: 3, horizontal: 4),
                          decoration: !isMyday
                              ? null
                              : BoxDecoration(
                                  borderRadius: BorderRadius.circular(4),
                                  border:
                                      Border.all(color: themeData.primaryColor),
                                ),
                          child: Text(context.local.tMyday)),
                      icon: LucideIcons.calendarCheck2,
                      onTap: () {
                        isMyday = !isMyday;
                        setState(() {});
                      },
                    ),
                  ],
                ),
              ItemWidget(
                title: context.local.tRepeat,
                content: Column(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: ['Daily', 'Weekdays', 'Monthly']
                        .map((e) => Btn(
                            onTap: () {
                              Navigator.maybePop(context);
                            },
                            child: Text(e)))
                        .toList()),
                icon: LucideIcons.home,
              ),
            ],
          ),
        ),
        verticalMargin12,
      ],
    );
  }
}

@immutable
class ItemWidget extends StatelessWidget {
  const ItemWidget(
      {super.key,
      required this.content,
      required this.icon,
      this.titleStyle = const TextStyle(),
      required this.title});

  final Widget content;
  final IconData icon;
  final TextStyle titleStyle;
  final String title;

  @override
  Widget build(BuildContext context) {
    return Btn(
      onTap: () {},
      child: CustomPopup(
        showArrow: true,
        content: content,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(mainAxisSize: MainAxisSize.min, children: [
            Icon(
              icon,
              color: titleStyle.color,
            ),
            horizontalMargin12,
            Text(
              title,
              style: titleStyle,
            )
          ]),
        ),
      ),
    );
  }
}

// --------------------------------------------------------
@immutable
class AddSubTaskWidget extends StatelessWidget {
  const AddSubTaskWidget({super.key, required this.onAdd, this.hitText = ''});

  final ValueChanged<String> onAdd;
  final String hitText;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
            padding: const EdgeInsets.all(8.0),
            child: AddFiledWidget(show: true, hintText: hitText, onAdd: onAdd)),
        verticalMargin12,
      ],
    );
  }
}
