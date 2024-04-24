import 'package:firebase_core/firebase_core.dart';
import 'package:unitaskpro/services/db/list.dart';
import 'package:unitaskpro/services/service.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:unitaskpro/services/db/hive/db.dart';
import 'package:unitaskpro/services/theme/theme.service.hive.dart';
import 'package:unitaskpro/services/firebase/firebase_options.dart';
import 'package:unitaskpro/services/theme/controllers/theme.controller.dart';
 

class Ini {
  Ini();
  final HiveStorageService storageService = HiveStorageService();
  final ThemeServiceHive _themeServiceHive = ThemeServiceHive('theme');

  // Locale locale = const Locale('kk');

  Future<List<Override>> init() async {
    await Firebase.initializeApp(
        options: DefaultFirebaseOptions.currentPlatform);
    await storageService.initHive('boxName');
    await ListHive.initHive();
    var themeController = ThemeController(_themeServiceHive);
    await _themeServiceHive.init();
    await themeController.loadAll();
    List<Override> overrides = [];
    final overrideWith =
        storageServiceProvider.overrideWithValue(storageService);
    // var localCode = storageService.readValue<String>('LOCALKEY');
    // locale = Locale(localCode);
    // final overrideWith2 =
    //     loggerServiceProvider.overrideWithValue(loggerService);
    var overrideWith3 =
        themeControllerProvider.overrideWith((_) => themeController);
    overrides.addAll([overrideWith, overrideWith3]);
    // isarInit();

    return overrides;
  }

  Future<void> close() async {
    ///impl close
    ///initProvoder
  }
}
