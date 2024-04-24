import 'package:flutter/material.dart';

@immutable
class CirCleWidget extends StatelessWidget {
  const CirCleWidget({super.key, required this.child});

  final Widget child;
  @override
  Widget build(BuildContext context) {
    final brightness = Theme.of(context).brightness;
    final color =
        brightness == Brightness.light ? Colors.white : Colors.grey[800];

    return Theme(
      data: Theme.of(context).copyWith(iconTheme: const IconThemeData(size: 29)),
      child: Container(
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(30.0),
          boxShadow: [
            if (brightness == Brightness.light)
              BoxShadow(
                color: Colors.grey.withOpacity(0.2),
                blurRadius: 5.0,
                spreadRadius: 2.0,
              ),
          ],
        ),
        child: Padding(padding: const EdgeInsets.all(16.0), child: child),
      ),
    );
  }
}
