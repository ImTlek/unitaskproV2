import 'package:flutter/widgets.dart';

class SettingModel {
  final String title;
  final IconData iconData;
  final int index;
  final Widget child;

  SettingModel(
      {required this.title,
      required this.iconData,
      required this.child,
      required this.index});
}
