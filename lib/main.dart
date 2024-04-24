import 'dart:async';
import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:unitaskpro/app/root.dart';
import 'package:unitaskpro/services/init/ini.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

void logs(Object? o) {
  print('-------------------------');
  log(o.toString());
  print('-------------------------');
}

final Ini initialization = Ini();

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final list = await initialization.init();
  final ProviderScope scope = ProviderScope(overrides: list, child: Root());

  runApp(scope);
}
