import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'theme/app_theme.dart';
import 'screens/home_screen.dart';
import 'services/notification_service.dart';
import 'widgets/splash_screen.dart';
import 'models/habit.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Initialize Hive
  await Hive.initFlutter();

  // Register Hive adapters
  Hive.registerAdapter(HabitAdapter());
  Hive.registerAdapter(HabitCategoryAdapter());
  Hive.registerAdapter(HabitFrequencyAdapter());

  // Initialize notifications
  // await NotificationService.initialize();

  // Set system UI overlay style
  SystemChrome.setSystemUIOverlayStyle(
    const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarIconBrightness: Brightness.dark,
      systemNavigationBarColor: Colors.transparent,
    ),
  );

  runApp(
    const ProviderScope(
      child: HabitFlowApp(),
    ),
  );
}

class HabitFlowApp extends ConsumerStatefulWidget {
  const HabitFlowApp({super.key});

  @override
  ConsumerState<HabitFlowApp> createState() => _HabitFlowAppState();
}

class _HabitFlowAppState extends ConsumerState<HabitFlowApp> {
  bool _showSplash = true;

  void _onSplashComplete() {
    setState(() {
      _showSplash = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'HabitFlow',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.lightTheme,
      darkTheme: AppTheme.darkTheme,
      themeMode: ThemeMode.system,
      home: _showSplash
          ? SplashScreen(onAnimationComplete: _onSplashComplete)
          : const HomeScreen(),
    );
  }
}
