import 'package:flutter/widgets.dart';
import 'package:flutter/material.dart';
import 'package:unitaskpro/features/home/page.dart';
import 'package:unitaskpro/features/task/page.dart';
import 'package:unitaskpro/features/myday/page.dart';
import 'package:unitaskpro/features/schedule/page.dart';

final Map<Widget, IconData> page = {
  const HomePage(): HomePage.icon,
  const MydayPage(): MydayPage.icon,
  const TaskPage(): TaskPage.icon,
  // const MessagePage(): MessagePage.icon,
  const SchedulePage(): SchedulePage.icon,
};

final Map<Widget, IconData> pages = {
  const HomePage(): HomePage.icon,
  const MydayPage(): MydayPage.icon,
  const TaskPage(): TaskPage.icon,
  // const MessagePage(): MessagePage.icon,
  const SchedulePage(): SchedulePage.icon,
};

 

// final Map<Widget, Map> pages = {
//   // const HomePage(): {'icon': HomePage.icon, 'title': 'Home'},
//   const TodayPage(): {'icon': TodayPage.iocn, 'title': 'today'},
//   const TaskPage(): {'icon': TaskPage.icon, 'title': 'task'},
//   const MessagePage(): {'icon': MessagePage.icon, 'title': 'message'},
// };
