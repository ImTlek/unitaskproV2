import 'theme.service.dart';
import 'app.data.dir/app.data.dir.dart';
import 'package:flutter/foundation.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:unitaskpro/services/theme/theme.service.hive.adapters.dart';

const bool _debug = !kReleaseMode && true;

class ThemeServiceHive implements ThemeService {
  ThemeServiceHive(this.boxName);

  final String boxName;

  late final Box<dynamic> _hiveBox;

  @override
  Future<void> init() async {
    registerHiveAdapters();

    final String appDataDir = await getAppDataDir();

    if (_debug) {
      // debugPrint(
      // 'Hive using storage path: $appDataDir and file name: $boxName');
    }

    Hive.init(appDataDir);

    await Hive.openBox<dynamic>(boxName);

    _hiveBox = Hive.box<dynamic>(boxName);
  }

  void registerHiveAdapters() {
    Hive.registerAdapter(ThemeModeAdapter());
    Hive.registerAdapter(ColorAdapter());
    Hive.registerAdapter(FlexSchemeAdapter());
    Hive.registerAdapter(FlexSurfaceModeAdapter());
    Hive.registerAdapter(FlexInputBorderTypeAdapter());
    Hive.registerAdapter(FlexTabBarStyleAdapter());
    Hive.registerAdapter(FlexAppBarStyleAdapter());
    Hive.registerAdapter(FlexSystemNavBarStyleAdapter());
    Hive.registerAdapter(FlexSchemeColorAdapter());
    Hive.registerAdapter(NavigationDestinationLabelBehaviorAdapter());
    Hive.registerAdapter(NavigationRailLabelTypeAdapter());
    Hive.registerAdapter(FlexSliderIndicatorTypeAdapter());
    Hive.registerAdapter(ShowValueIndicatorAdapter());
    Hive.registerAdapter(TabBarIndicatorSizeAdapter());
    Hive.registerAdapter(AdaptiveThemeAdapter());
    Hive.registerAdapter(FlexPaletteTypeAdapter());
    Hive.registerAdapter(VisualDensityEnumAdapter());
    Hive.registerAdapter(SplashTypeEnumAdapter());
  }

  @override
  Future<T> load<T>(String key, T defaultValue) async {
    try {
      final T loaded = _hiveBox.get(key, defaultValue: defaultValue) as T;
      if (_debug) {
        // debugPrint('Hive type   : $key as ${defaultValue.runtimeType}');
        // debugPrint('Hive loaded : $key as $loaded with ${loaded.runtimeType}');
      }
      return loaded;
    } catch (e) {
      // debugPrint('Hive load (get) ERROR');
      // debugPrint(' Error message ...... : $e');
      // debugPrint(' Store key .......... : $key');
      // debugPrint(' defaultValue ....... : $defaultValue');

      return defaultValue;
    }
  }

  @override
  Future<void> save<T>(String key, T value) async {
    try {
      await _hiveBox.put(key, value);
      if (_debug) {
        // debugPrint('Hive type   : $key as ${value.runtimeType}');
        // debugPrint('Hive saved  : $key as $value');
      }
    } catch (e) {
      // debugPrint('Hive save (put) ERROR');
      // debugPrint(' Error message ...... : $e');
      // debugPrint(' Store key .......... : $key');
      // debugPrint(' Save value ......... : $value');
    }
  }
}
