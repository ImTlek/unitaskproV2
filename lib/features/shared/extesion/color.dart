import 'package:flutter/widgets.dart';

extension HexColor on String {
  Color toColor() {
    const int base = 16;
    final code = int.parse(replaceFirst('#', ''), radix: base);
    return Color(code);
  }
}
