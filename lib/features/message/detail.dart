import 'package:flutter/material.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'package:unitaskpro/features/home/widget/widget.dart';
import 'package:unitaskpro/features/shared/widget/widget.dart';

class MsgDetailPage extends StatelessWidget {
  const MsgDetailPage({super.key});

  static Route route() =>
      MaterialPageRoute(builder: (context) => const MsgDetailPage());

  @override
  Widget build(BuildContext context) {
    // var themeData = Theme.of(context);
    final bool showFab = MediaQuery.of(context).viewInsets.bottom == 0.0;

    return ScaffoldWidget(
        // resizeToAvoidBottomInset: false,
        floatingActionButton: !showFab
            ? emptyWidget
            : FloatingActionButton.small(
                heroTag: '',
                onPressed: () {},
                child: const Icon(LucideIcons.plus),
              ),
        appBar: AppBarWidget(
          actions: [
            CirculerBtn(
              onTap: () {
                var child = Column(
                  children: [
                    RowItemWidget(
                        onTap: () {},
                        icon: LucideIcons.listChecks,
                        title: const Text('Mark all Incomplete')),
                    RowItemWidget(
                        titleStyle: const TextStyle(color: Colors.red),
                        onTap: () {},
                        icon: LucideIcons.trash2,
                        title: const Text('Delete task')),
                    verticalMargin12,
                  ],
                );
                showSheet(context, child: child);
              },
              child: const Icon(LucideIcons.moreVertical),
            ),
            horizontalMargin8,
          ],
        ),
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Column(children: [
              verticalMargin32,
              // const TaskItem(title: 'Actiity'),
              const TimeWidget(),
              const Expanded(child: MessageWidget()),
              AddFiledWidget(
                show: showFab,
                onAdd: (value) {},
              ),
              verticalMargin14,
            ]),
          ),
        ));
  }
}

class MessageWidget extends StatelessWidget {
  const MessageWidget({super.key});

  @override
  Widget build(BuildContext context) {
    var sizeOf = MediaQuery.sizeOf(context);
    return Container(
      height: sizeOf.height * .3,
    );
  }
}

class TimeWidget extends StatelessWidget {
  const TimeWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return const Column(
      children: [
        verticalMargin8,
        Divider(),
        verticalMargin12,
        Text(
          'Creaete by tilek 12 days ago',
          style: TextStyle(fontSize: 12),
        ),
        verticalMargin8,
        Text(
          'Sunday,March 10',
          style: TextStyle(fontSize: 12),
        ),
        verticalMargin12,
      ],
    );
  }
}
