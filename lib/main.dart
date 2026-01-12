import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flex_color_scheme/flex_color_scheme.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'dart:developer' as developer;
import 'package:package_info_plus/package_info_plus.dart';
import 'package:stack_trace/stack_trace.dart';

import 'controllers/event_controller.dart';
import 'screens/home_screen.dart';
import 'screens/statistics_screen.dart';
import 'screens/health_advice_screen.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();

  // Initialize GetX controller
  Get.put(EventController());

  // Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform).then((
  //   x,
  // ) {
  //   FirebaseAnalytics.instance.logAppOpen();
  // });

  runApp(const LuleMoApp());
}

class LuleMoApp extends StatelessWidget {
  const LuleMoApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: '撸了么',
      debugShowCheckedModeBanner: false,
      logWriterCallback: (value, {isError = false}) {
        if (isError || Get.isLogEnable) {
          developer.log(
            '[${DateTime.now()}] $value\n${Trace.current().terse.frames.getRange(1, 4).join('\n')}',
            name: 'GETX',
          );
        }
      },
      theme: FlexThemeData.light(
        scheme: FlexScheme.deepPurple,
        useMaterial3: true,
        surfaceMode: FlexSurfaceMode.highScaffoldLowSurface,
        blendLevel: 15,
        appBarStyle: FlexAppBarStyle.primary,
        appBarOpacity: 0.95,
        appBarElevation: 0,
        transparentStatusBar: true,
      ),
      darkTheme: FlexThemeData.dark(
        scheme: FlexScheme.deepPurple,
        useMaterial3: true,
        surfaceMode: FlexSurfaceMode.highScaffoldLowSurface,
        blendLevel: 15,
        appBarStyle: FlexAppBarStyle.background,
        appBarOpacity: 0.95,
        appBarElevation: 0,
        transparentStatusBar: true,
      ),
      themeMode: ThemeMode.system,
      home: const MainNavigationScreen(),
    );
  }
}

class MainNavigationScreen extends StatefulWidget {
  const MainNavigationScreen({super.key});

  @override
  State<MainNavigationScreen> createState() => _MainNavigationScreenState();
}

class _MainNavigationScreenState extends State<MainNavigationScreen> {
  int _currentIndex = 0;

  final List<Widget> _screens = const [
    HomeScreen(),
    StatisticsScreen(),
    HealthAdviceScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _screens[_currentIndex],
      bottomNavigationBar: NavigationBar(
        selectedIndex: _currentIndex,
        onDestinationSelected: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
        destinations: const [
          NavigationDestination(
            icon: Icon(Icons.home_outlined),
            selectedIcon: Icon(Icons.home),
            label: '首页',
          ),
          NavigationDestination(
            icon: Icon(Icons.bar_chart_outlined),
            selectedIcon: Icon(Icons.bar_chart),
            label: '统计',
          ),
          NavigationDestination(
            icon: Icon(Icons.favorite_outline),
            selectedIcon: Icon(Icons.favorite),
            label: '健康',
          ),
        ],
      ),
    );
  }
}
