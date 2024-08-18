import 'package:book_summary/ui/screens/splash_auth_screen.dart';
import 'package:book_summary/ui/screens/splash_main_screen.dart';
import 'package:book_summary/ui/screens/splash_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../logic/blocs/auth/auth_bloc.dart';
import '../ui/screens/auth_screen.dart';
import '../ui/screens/main_screen.dart';

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorSchemeSeed: Colors.amber,
      ),
      home: BlocSelector<AuthBloc, AuthState, User?>(
        bloc: context.read<AuthBloc>()..add(WatchAuthEvent()),
        selector: (state) => state.user,
        builder: (context, user) {
          return user == null
              ? const SplashAuthScreen()
              : const SplashMainScreen();
        },
      ),
    );
  }
}
