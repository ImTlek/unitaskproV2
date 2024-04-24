import 'package:flutter/material.dart';
import 'package:unitaskpro/features/message/detail.dart';
import 'package:unitaskpro/features/shared/widget/common.dart';

class MessageItem extends StatelessWidget {
  const MessageItem({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 58,
      child: InkWell(
        onTap: () => Navigator.push(context, MsgDetailPage.route()),
        child: const Padding(
          padding: EdgeInsets.symmetric(horizontal: 16),
          child: Row(
            children: [
              CircleAvatar(),
              horizontalMargin8,
              Expanded(
                  child: Padding(
                      padding: EdgeInsets.symmetric(vertical: 6),
                      child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text('title'),
                            Text('user name : message')
                          ]))),
              Text('time ago '), // Make trailing time text constant
            ],
          ),
        ),
      ),
    );
  }
}
