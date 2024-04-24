import 'dart:async';
import 'package:get_it/get_it.dart';
import 'package:oktoast/oktoast.dart';
import 'package:unitaskpro/main.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:unitaskpro/l10n/lan.dart';
import 'package:unitaskpro/features/app.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:unitaskpro/services/service.dart';
import 'package:unitaskpro/features/auth/page.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:unitaskpro/services/auth/auth.dart';
import 'package:unitaskpro/services/db/hive/hive.dart';
import 'package:flex_color_scheme/flex_color_scheme.dart';
import 'package:unitaskpro/features/shared/widget/splash.dart';

@immutable
class Root extends ConsumerStatefulWidget {
  const Root({super.key});
  static RootState? of(BuildContext context) =>
      context.findAncestorStateOfType<RootState>();
  @override
  RootState createState() => RootState();
}

class RootState extends ConsumerState<Root> {
  Locale _locale = const Locale('kk');
  void setLocale(Locale value) {
    _locale = value;
    storageServiceInterface.writeValue(key: 'local', data: value.languageCode);

    setState(() {});
  }

  StorageServiceInterface get storageServiceInterface =>
      ref.read(storageServiceProvider);

  final _navigatorKey = GlobalKey<NavigatorState>();
  NavigatorState? get navigatorState => _navigatorKey.currentState;
  StreamSubscription<bool>? _subIsLoggedIn;
  bool _isLoggedIn = false;
  late Future<void> loadApp;

  late final StreamSubscription _firebaseStreamEvents;
  @override
  void initState() {
    super.initState();
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.edgeToEdge);
    SystemChrome.setPreferredOrientations(
        [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);
    loadApp = _loadApp();
    _firebaseStreamEvents =
        FirebaseAuth.instance.authStateChanges().listen(_onLoginStateChange);

    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      var local = storageServiceInterface.readValue('local') ?? 'kk';
      _locale = Locale(local);
      setState(() {});
    });
  }

  Future<void> _loadApp() async {
    // await authService.init();
    await initializeDateFormatting();
    await Future.delayed(Durations.extralong1);
    GetIt.I.registerLazySingleton(() => authService);

    if (mounted) {
      // await MainScreen.precacheImages();
    }
  }

  void _onLoginStateChange(User? user) {
    logs(user);
    if (mounted) {
      // scheduleMicrotask(() {
      if (user == null) {
        _isLoggedIn = false;
        navigatorState?.pushAndRemoveUntil(
            OnboardingPage.route(), (route) => false);
      } else {
        _isLoggedIn = true;
        navigatorState?.pushAndRemoveUntil(AppMain.route(), (route) => false);
      }
    }
  }

  @override
  void dispose() {
    _subIsLoggedIn?.cancel();
    // authService.close();
    _firebaseStreamEvents.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return OKToast(
        child: AnnotatedRegion<SystemUiOverlayStyle>(
      value: appOverlayDarkIcons,
      child: FutureBuilder<void>(
        future: loadApp,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            return Consumer(
              builder: (context, ref, child) {
                var themeController = ref.watch(themeControllerProvider);
                return MaterialApp(
                  key: const ValueKey('x'),
                  locale: _locale,
                  navigatorKey: _navigatorKey,
                  localizationsDelegates:
                      AppLocalizations.localizationsDelegates,
                  supportedLocales: AppLocalizations.supportedLocales,
                  theme: themeData(themeController),
                  darkTheme: themeData(themeController),
                  themeMode: themeController.themeMode,
                  debugShowCheckedModeBanner: false,
                  builder: (context, child) => _Unfocus(child: child!),
                  onGenerateRoute: (RouteSettings settings) {
                    if (settings.name == Navigator.defaultRouteName) {
                      if (!_isLoggedIn) {
                        return OnboardingPage.route();
                      }
                      return AppMain.route();
                    } else {
                      return null;
                    }
                  },
                );
              },
            );
          }

          return Theme(
              data: FlexThemeData.dark(),
              child: const Directionality(
                  textDirection: TextDirection.ltr,
                  child: SplashPage(key: Key('value'))));
        },
      ),
    ));
  }
}
 

@immutable
class _Unfocus extends HookConsumerWidget {
  const _Unfocus({super.key, required this.child});
  final Widget child;

  @override
  Widget build(BuildContext __, WidgetRef _) {
    return GestureDetector(
        behavior: HitTestBehavior.opaque,
        onTap: FocusManager.instance.primaryFocus?.unfocus,
        child: child);
  }
}
