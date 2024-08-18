// ignore_for_file: must_be_immutable

import 'package:book_summary/ui/screens/auth_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'main_screen.dart';

class SplashMainScreen extends StatefulWidget {
  const SplashMainScreen({super.key});

  @override
  State<SplashMainScreen> createState() => _SplashMainScreenState();
}

class _SplashMainScreenState extends State<SplashMainScreen> {
  @override
  void initState() {
    super.initState();
    Future.delayed(
      const Duration(seconds: 4),
      () => Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => const MainScreen(),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Container(
          padding: const EdgeInsets.all(30),
          alignment: Alignment.center,
          child: Image.asset(
            'assets/images/splash.png',
            fit: BoxFit.cover,
            repeat: ImageRepeat.noRepeat,
            width: MediaQuery.of(context).size.width - 60,
          ),
        ),
      ),
    );
  }
}
