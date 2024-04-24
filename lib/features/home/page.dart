import 'widget/widget.dart';
import 'package:flutter/material.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:unitaskpro/features/shared/widget/widget.dart';

@immutable
class HomePage extends ConsumerWidget {
  const HomePage({super.key});

  static IconData get icon => LucideIcons.home;

  /// remove [RefreshIndicator.adaptive]
  @override
  Widget build(BuildContext context, ref) {
    return ListView(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
      children: const [
        HeaderWidget(),
        verticalMargin12,
        TopWidget(),
        verticalMargin12,
        BodyWidget(),
      ],
    );
  }
}
