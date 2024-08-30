import '../ui/screens/summary_history_screen.dart';
import '../ui/screens/books_history_screen.dart';
import '../ui/screens/edit_profile_screen.dart';
import '../ui/screens/main_screen.dart';
import '../ui/screens/profile_screen.dart';
import '../ui/screens/saved_books_screen.dart';
import '../ui/screens/splash_auth_screen.dart';
import '../ui/screens/splash_main_screen.dart';
import '../ui/screens/summary_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:toastification/toastification.dart';

import '../logic/blocs/auth/auth_bloc.dart';
import '../ui/screens/auth_screen.dart';

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ToastificationWrapper(
      child: MaterialApp(
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
        routes: {
          AuthScreen.routeName: (ctx) => const AuthScreen(),
          BooksHistoryScreen.routeName: (ctx) => const BooksHistoryScreen(),
          EditProfileScreen.routeName: (ctx) => const EditProfileScreen(),
          MainScreen.routeName: (ctx) => const MainScreen(),
          ProfileScreen.routeName: (ctx) => const ProfileScreen(),
          SavedBooksScreen.routeName: (ctx) => const SavedBooksScreen(),
          SummaryScreen.routeName: (ctx) => const SummaryScreen(),
          SummaryHistoryScreen.routeName: (ctx) => const SummaryHistoryScreen(),
        },
      ),
    );
  }
}
