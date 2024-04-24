import 'package:flutter/material.dart';
import 'package:unitaskpro/features/shared/widget/btn.dart';
import 'package:unitaskpro/features/shared/widget/common.dart';

class TaskEditWidget extends StatelessWidget {
  const TaskEditWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.symmetric(horizontal: 8),
      child: Column(
        children: [
          Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
            const Text('Edit task'),
            RectangleBtn(title: 'Done', onTap: () {})
          ]),
          verticalMargin12,
          const Card(
            child: Column(
              children: [
                TextField(
                  maxLines: 5,
                  maxLength: 100,
                  spellCheckConfiguration: SpellCheckConfiguration.disabled(),
                  decoration: InputDecoration(
                      counter: emptyWidget,
                      filled: false,
                      border: InputBorder.none,
                      contentPadding:
                          EdgeInsets.symmetric(horizontal: 8, vertical: 8)),
                ),
                verticalMargin12,
              ],
            ),
          ),
        ],
      ),
    );
  }
}
