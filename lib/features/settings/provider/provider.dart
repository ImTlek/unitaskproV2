import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:haptic_feedback/haptic_feedback.dart';

class SettingsProvider extends ChangeNotifier {
  SettingsProvider(int i) {
    index = i;
  }

  late int index;

  void onIndex(int i) async {
    await Haptics.vibrate(HapticsType.rigid);
    index = i;
    notifyListeners();
  }
}

final settingsNotifireProvider = ChangeNotifierProvider.family
    .autoDispose<SettingsProvider, int>((ref, i) => SettingsProvider(i));

// class SettingsNotifier extends Notifier<int> {
//   final int initialIndex;

//   SettingsNotifier(this.initialIndex);

//   @override
//   int get state => initialIndex;

//   void updateIndex(int newIndex) => state = newIndex;

//   @override
//   int build() {
//     return initialIndex;
//   }
// }

// // Create a NotifierProviderFamily for settings with different initial values
// final settingsProvider = NotifierProviderFamily(() => SettingsNotifier());
