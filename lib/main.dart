import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:swiftycompanion/Datapage.dart';
import 'package:swiftycompanion/Graphechart.dart';
import 'package:swiftycompanion/LoginPage.dart';
import 'package:swiftycompanion/SearchPage.dart';
import 'package:swiftycompanion/provider_setup.dart';
import 'package:swiftycompanion/radar_chart.dart';

//com.example.swiftycompanion
void main() {
  ProviderSetup.setup();
  runApp(
    MyApp(),
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
  Widget build(BuildContext context) => MaterialApp.router(
        routeInformationParser: _router.routeInformationParser,
        routerDelegate: _router.routerDelegate,
        routeInformationProvider: _router.routeInformationProvider,
      );
}
