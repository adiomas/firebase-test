// ignore_for_file: always_use_package_imports

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_test/features/auth/domain/notifiers/auth_notifier.dart';
import 'package:firebase_test/firebase_options.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_loggy/flutter_loggy.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:loggy/loggy.dart';
import 'package:sentry_flutter/sentry_flutter.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import 'common/domain/providers/base_router_provider.dart';
import 'common/presentation/base_widget.dart';
import 'common/utils/custom_provider_observer.dart';
import 'common/utils/q_logger.dart';
import 'generated/l10n.dart';
import 'main/app_environment.dart';
import 'theme/theme.dart';

Future<void> mainCommon(AppEnvironment environment) async {
  WidgetsFlutterBinding.ensureInitialized();
  EnvInfo.initialize(environment);
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  await Supabase.initialize(
    url: EnvInfo.supabaseUrl,
    anonKey: EnvInfo.supabaseAnonKey,
  );

  Loggy.initLoggy(
    logPrinter: !EnvInfo.isProduction || kDebugMode
        ? StreamPrinter(const PrettyDeveloperPrinter())
        : const DisabledPrinter(),
  );
  void runAppCallback() => SystemChrome.setPreferredOrientations(
        [DeviceOrientation.portraitUp],
      ).then((_) => runApp(ProviderScope(
            observers: [CustomProviderObserver()],
            child: const MyApp(),
          )));
  if (environment == AppEnvironment.PROD) {
    await SentryFlutter.init(
      (options) {
        options.dsn = 'DSN';
      },
      appRunner: runAppCallback,
    );
  } else {
    runAppCallback();
  }
}

class MyApp extends ConsumerWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final baseRouter = ref.watch(baseRouterProvider);
    ref.watch(authNotifierProvider);
    return MaterialApp.router(
      debugShowCheckedModeBanner: EnvInfo.environment != AppEnvironment.PROD,
      title: EnvInfo.appTitle,
      theme: primaryTheme,
      darkTheme: secondaryTheme,
      themeMode: ThemeMode.system,
      localizationsDelegates: const [
        S.delegate,
        ...GlobalMaterialLocalizations.delegates,
      ],
      routerDelegate: baseRouter.routerDelegate,
      routeInformationParser: baseRouter.routeInformationParser,
      routeInformationProvider: baseRouter.routeInformationProvider,
      builder: (context, child) => Material(
        type: MaterialType.transparency,
        child: BaseWidget(child ?? const SizedBox()),
      ),
    );
  }
}
