import 'widget/item.dart';
import 'package:flutter/material.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'package:unitaskpro/features/shared/widget/scaffold.dart';

class MessagePage extends StatelessWidget {
  const MessagePage({super.key});
  static IconData get icon => LucideIcons.messageCircle;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: CustomScrollView(
      slivers: [
        const SlieverAppBar(
          title: 'Messasge',
          actions: [],
        ),
        SliverPadding(
          padding: const EdgeInsets.only(left: 0, bottom: 0, right: 0, top: 0),
          sliver: SliverList.builder(
            addAutomaticKeepAlives: false,
            addSemanticIndexes: true,
            addRepaintBoundaries: false,
            itemCount: 3,
            itemBuilder: (context, index) {
              return const MessageItem();
            },
          ),
        )
      ],
    ));
  }
}
