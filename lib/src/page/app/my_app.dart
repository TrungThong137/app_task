import 'package:app_task/src/configs/constants/constants.dart';
import 'package:app_task/src/page/splash/splash_screen.dart';
import 'package:flutter/material.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: AppColors.COLOR_PINK),
        useMaterial3: true,
      ),
      home: const SplashScreen(),
    );
  }
}