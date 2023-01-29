import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:swiftycompanion/Datapage.dart';
import 'package:swiftycompanion/Graphechart.dart';
import 'package:swiftycompanion/LoginPage.dart';
import 'package:swiftycompanion/SearchPage.dart';
import 'package:swiftycompanion/prefences.dart';
import 'package:swiftycompanion/provider_setup.dart';
import 'package:swiftycompanion/radar_chart.dart';

//com.example.swiftycompanion
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await MyPreferences.init();
  final darkMode = await MyPreferences.getDarkMode() ?? false;
  // final darkMode = true;
  await dotenv.load(fileName: ".env");

  runApp(
    ChangeNotifierProvider(
        create: (context) {
          final darkModeProvider = DarkModeProvider();
          darkModeProvider.setMode(darkMode);
          return darkModeProvider;
        },
        child: MyApp()),
  );
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

var iconbool = false;

class _MyAppState extends State<MyApp> {
  final _router = GoRouter(
    routes: [
      GoRoute(
        path: '/',
        pageBuilder: (context, state) => MaterialPage<void>(
          key: state.pageKey,
          child: Loginpage(),
        ),
      ),
      GoRoute(
        path: '/page2',
        pageBuilder: (context, state) => MaterialPage<void>(
          key: state.pageKey,
          child: SearchPage(),
        ),
      ),
      GoRoute(
        path: '/page3',
        pageBuilder: (context, state) => MaterialPage<void>(
          key: state.pageKey,
          child: DataPage(
            key: state.pageKey,
            index: state.params['index'],
            iconbool: iconbool,
          ),
        ),
      ),
    ],
  );

  @override
  Widget build(BuildContext context) => Selector<DarkModeProvider, bool>(
        selector: (ctx, darkModeProvider) => darkModeProvider.isDark,
        builder: (ctx, isDark, _) => MaterialApp.router(
          routeInformationParser: _router.routeInformationParser,
          routerDelegate: _router.routerDelegate,
          routeInformationProvider: _router.routeInformationProvider,
          theme: ThemeData(
              brightness: isDark ? Brightness.dark : Brightness.light),
        ),
      );
}
