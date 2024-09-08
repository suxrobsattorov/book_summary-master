import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

import 'core/app.dart';
import 'data/repositories/audio_repository.dart';
import 'data/repositories/auth_repository.dart';
import 'data/repositories/books_repository.dart';
import 'data/repositories/user_repository.dart';
import 'data/services/audio_service.dart';
import 'data/services/firebase_auth_service.dart';
import 'data/services/firebase_book_service.dart';
import 'data/services/firebase_user_service.dart';
import 'firebase_options.dart';
import 'logic/blocs/all_blocs.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  await dotenv.load(fileName: ".env");

  final firebaseBookService = FirebaseBookService();
  final firebaseAuthService = FirebaseAuthService();
  final firebaseUserService = FirebaseUserService();
  final audioService = AudioService();
  runApp(
    MultiRepositoryProvider(
      providers: [
        RepositoryProvider(
          create: (context) => BooksRepository(
            firebaseBookService: firebaseBookService,
          ),
        ),
        RepositoryProvider(
          create: (context) => AuthRepository(
            firebaseAuthService: firebaseAuthService,
          ),
        ),
        RepositoryProvider(
          create: (context) => UserRepository(
            firebaseUserService: firebaseUserService,
          ),
        ),
        RepositoryProvider(
          create: (context) => AudioRepository(
            audioService: audioService,
          ),
        ),
      ],
      child: MultiBlocProvider(
        providers: [
          BlocProvider(create: (ctx) {
            return TranslateBloc();
          }),
          BlocProvider(create: (ctx) {
            return FilePickerBloc();
          }),
          BlocProvider(create: (ctx) {
            return PdfToImageBloc();
          }),
          BlocProvider(
            create: (ctx) => AuthBloc(
              authRepository: ctx.read<AuthRepository>(),
              userRepository: ctx.read<UserRepository>(),
            )..add(InitialAuthEvent()),
          ),
          BlocProvider(create: (ctx) {
            return GenerativeAiBloc(
              booksRepository: ctx.read<BooksRepository>(),
              authRepository: ctx.read<AuthRepository>(),
            );
          }),
          BlocProvider(create: (ctx) {
            return BooksBloc(
              booksRepository: ctx.read<BooksRepository>(),
              authRepository: ctx.read<AuthRepository>(),
            );
          }),
          BlocProvider(create: (ctx) {
            return AudioPlayerBloc(
              audioRepository: ctx.read<AudioRepository>(),
            );
          }),
          BlocProvider(create: (ctx) {
            return UserBloc(
              userRepository: ctx.read<UserRepository>(),
              authRepository: ctx.read<AuthRepository>(),
            );
          }),
        ],
        child: const MainApp(),
      ),
    ),
  );
}
