import 'package:flutter/material.dart';
import 'package:unitaskpro/l10n/lan.dart';

extension LocalizedBuildContext on BuildContext {
  AppLocalizations get local => AppLocalizations.of(this)!;
}
