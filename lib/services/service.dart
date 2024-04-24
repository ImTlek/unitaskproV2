import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'theme/constant/app.color.dart';
import 'package:flutter/foundation.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:unitaskpro/services/db/hive/hive.dart';
import 'package:flex_color_scheme/flex_color_scheme.dart';
import 'package:unitaskpro/services/theme/controllers/theme.controller.dart';

final storageServiceProvider =
    Provider<StorageServiceInterface>((_) => throw UnimplementedError());

final themeControllerProvider =
    ChangeNotifierProvider.autoDispose<ThemeController>(
        (_) => throw UnimplementedError());

ThemeData? themeData(ThemeController themeController) {
  return themeController.themeMode == ThemeMode.dark
      ? FlexThemeData.dark(
          useMaterial3: true,
          splashFactory: NoSplash.splashFactory,
          colors: AppColor.customSchemes[themeController.schemeIndex].dark,
          surfaceMode: FlexSurfaceMode.highScaffoldLowSurfaces,
          blendLevel: 7,
          keyColors: FlexKeyColors(
            useKeyColors: themeController.useKeyColors,
            useSecondary: themeController.useSecondary,
            useTertiary: themeController.useTertiary,
            keepPrimary: themeController.keepDarkPrimary,
            keepSecondary: themeController.keepDarkSecondary,
            keepTertiary: themeController.keepDarkTertiary,
          ),
          subThemesData: themeController.useSubThemes
              ? FlexSubThemesData(
                  cardRadius: 4, defaultRadius: themeController.defaultRadius)
              : null,
          typography: Typography.material2021(platform: defaultTargetPlatform))
      : FlexThemeData.light(
          useMaterial3: true,
          splashFactory: NoSplash.splashFactory,
          colors: AppColor.schemes[themeController.schemeIndex].light,
          surfaceMode: FlexSurfaceMode.highScaffoldLowSurfaces,
          subThemesData: themeController.useSubThemes
              ? FlexSubThemesData(
                  cardRadius: 4, defaultRadius: themeController.defaultRadius)
              : null,
        );
}

const appOverlayDarkIcons = SystemUiOverlayStyle(
  statusBarColor: Colors.transparent,
  statusBarBrightness: Brightness.light,
  statusBarIconBrightness: Brightness.dark,
  systemNavigationBarColor: Colors.transparent,
  systemNavigationBarIconBrightness: Brightness.dark,
);

const appOverlayLightIcons = SystemUiOverlayStyle(
  statusBarColor: Colors.transparent,
  statusBarBrightness: Brightness.dark,
  statusBarIconBrightness: Brightness.light,
  systemNavigationBarColor: Colors.transparent,
  systemNavigationBarIconBrightness: Brightness.dark,
);

