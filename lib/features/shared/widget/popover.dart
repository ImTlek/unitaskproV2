import 'package:flutter/material.dart';
import 'package:unitaskpro/features/shared/widget/common.dart';

Future<T?> showSheet<T>(BuildContext context,
        {required Widget child, bool isExpanded = false}) =>
    showModalBottomSheet<T?>(
        backgroundColor: Colors.transparent,
        clipBehavior: Clip.antiAlias,
        context: context,
        // enableDrag: true,
        // isDismissible: true,
        // showDragHandle: false,
        useSafeArea: true,
        isScrollControlled: true,
        elevation: 0,
        builder: (context) =>
            PopoverWidget(isExpanded: isExpanded, child: child));

class PopoverWidget extends StatelessWidget {
  const PopoverWidget({
    super.key,
    required this.child,
    this.isExpanded = true,
  });

  final Widget child;
  final bool isExpanded;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return SafeArea(
      child: Container(
          margin: const EdgeInsets.all(12.0),
          padding: EdgeInsets.only(
              bottom: MediaQuery.of(context).viewInsets.bottom,
              left: 8,
              right: 8),
          clipBehavior: Clip.antiAlias,
          decoration: BoxDecoration(
              color: theme.cardColor,
              borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(16),
                  topRight: Radius.circular(16),
                  bottomLeft: Radius.circular(6),
                  bottomRight: Radius.circular(6))),
          child: Column(mainAxisSize: MainAxisSize.min, children: [
            _buildHandle(theme),
            verticalMargin12,
            isExpanded ? Expanded(child: child) : child,
            verticalMargin12,
          ])),
    );
  }

  Widget _buildHandle(ThemeData theme) {
    return FractionallySizedBox(
      widthFactor: 0.25,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 6),
        child: Container(
          height: 4.0,
          decoration: BoxDecoration(
            color: theme.dividerColor,
            borderRadius: const BorderRadius.all(Radius.circular(2.5)),
          ),
        ),
      ),
    );
  }
}
