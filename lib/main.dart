import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:movieapp/screens/Login/splash_screen.dart';
import 'package:movieapp/screens/Profile/user_provider.dart';

void main() {
  runApp(
    ChangeNotifierProvider(
      create: (_) => UserProvider(),
      child: const MovieApp(),
    ),
  );
}

class MovieApp extends StatelessWidget {
  const MovieApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primaryColor: const Color(0xFF5C67D1),
      ),
      home: const SplashScreen(),
    );
  }
}
