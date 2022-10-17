import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:swiftycompanion/Datapage.dart';
import 'package:swiftycompanion/Graphechart.dart';
import 'package:swiftycompanion/LoginPage.dart';
import 'package:swiftycompanion/SearchPage.dart';
import 'package:swiftycompanion/radar_chart.dart';

void main() {
  runApp( MyApp(),
  );
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final _router = GoRouter(
    routes: [
      GoRoute(
        path: '/',
        pageBuilder: (context, state) => MaterialPage<void>(
          key: state.pageKey,
          child: const Loginpage(),
        ),
      ),
      GoRoute(
        path: '/page2',
        pageBuilder: (context, state) => MaterialPage<void>(
          key: state.pageKey,
          child: const SearchPage(),
        ),
      ),GoRoute(
        path: '/page3',
        pageBuilder: (context, state) => MaterialPage<void>(
          key: state.pageKey,
          child: const DataPage(),
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