import 'package:connectivity_wrapper/connectivity_wrapper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:quizwiz/app/app.bottomsheets.dart';
import 'package:quizwiz/app/app.dialogs.dart';
import 'package:quizwiz/app/app.locator.dart';
import 'package:quizwiz/app/app.router.dart';
import 'package:quizwiz/ui/common/main_theme.dart';
import 'package:quizwiz/utils/env.dart';
import 'package:stacked_services/stacked_services.dart';
import 'package:stacked_themes/stacked_themes.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await setupLocator();
  setupDialogUi();
  setupBottomSheetUi();
  await ThemeManager.initialise();
  await dotenv.load(fileName: ".env");

  BuildEnvironment.init(
    flavor: BuildFlavor.production,
    appName: 'QUIZWIZ',
    quizUrl: dotenv.env['QUIZ_API'],
  );
  assert(env != null);

  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ThemeBuilder(
      defaultThemeMode: ThemeMode.system,
      darkTheme: ThemeData(colorScheme: darkColorScheme),
      lightTheme: ThemeData(colorScheme: lightColorScheme),
      builder: (context, regularTheme, darkTheme, themeMode) =>
          ConnectivityAppWrapper(
        app: MaterialApp(
          theme: regularTheme,
          darkTheme: darkTheme,
          themeMode: themeMode,
          initialRoute: Routes.startupView,
          debugShowCheckedModeBanner: false,
          title: env!.appName,
          onGenerateRoute: StackedRouter().onGenerateRoute,
          navigatorKey: StackedService.navigatorKey,
          navigatorObservers: [
            StackedService.routeObserver,
          ],
        ),
      ),
    );
  }
}
