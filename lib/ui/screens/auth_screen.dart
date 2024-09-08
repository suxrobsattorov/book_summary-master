import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:toastification/toastification.dart';

import '../../core/utils/app_dialogs.dart';
import '../../logic/blocs/auth/auth_bloc.dart';
import 'main_screen.dart';

class AuthScreen extends StatefulWidget {
  const AuthScreen({super.key});

  static const routeName = '/auth';

  @override
  State<AuthScreen> createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AuthBloc, AuthState>(
      listener: (context, state) {
        if (state.status == AuthStatus.loading) {
          AppDialogs.showLoading(context);
        }else if (state.status == AuthStatus.authenticated) {
          Navigator.of(context).pushReplacementNamed(MainScreen.routeName);
        } else {
          AppDialogs.hideLoading(context);
          if (state.status == AuthStatus.error) {
            AppDialogs.showToast(
              state.error.toString(),
              ToastificationType.error,
            );
          }
        }
      },
      builder: (context, state) {
        return Scaffold(
          backgroundColor: Colors.white,
          body: SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.symmetric(
                horizontal: 22,
                vertical: MediaQuery.of(context).padding.top + 44,
              ),
              child: Form(
                key: state.formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Image.asset(
                      'assets/images/auth_image.png',
                      height: 201,
                      width: 201,
                    ),
                    const SizedBox(height: 18),
                    TextFormField(
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        hintText: 'Email',
                      ),
                      controller: state.emailController,
                      keyboardType: TextInputType.emailAddress,
                      textInputAction: TextInputAction.next,
                      validator: (email) {
                        if (email == null || email.isEmpty) {
                          return 'Iltimos, email manzil kiriting.';
                        } else if (!email.contains('@')) {
                          return 'Iltimos, to\'g\'ri email kiriting.';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 10),
                    TextFormField(
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        hintText: 'Parol',
                      ),
                      textInputAction: TextInputAction.next,
                      controller: state.passwordController,
                      obscureText: true,
                      validator: (password) {
                        if (password == null || password.isEmpty) {
                          return 'Iltimos, parolni kiriting.';
                        } else if (password.length < 6) {
                          return 'Parol juda oson.';
                        }
                        return null;
                      },
                    ),
                    if (!state.isLogin)
                      Column(
                        children: [
                          const SizedBox(height: 10),
                          TextFormField(
                            decoration: const InputDecoration(
                              border: OutlineInputBorder(),
                              hintText: 'Parolni tasdiqlang',
                            ),
                            controller: state.passwordConfirmController,
                            textInputAction: TextInputAction.done,
                            obscureText: true,
                            validator: (confirmedPassword) {
                              if (confirmedPassword == null ||
                                  confirmedPassword.isEmpty ||
                                  confirmedPassword !=
                                      state.passwordController!.text) {
                                return 'Parollar bir biriga mos kelmadi';
                              }
                              return null;
                            },
                          ),
                        ],
                      ),
                    const SizedBox(height: 38),
                    InkWell(
                      onTap: () =>
                          context.read<AuthBloc>().add(AuthenticateEvent()),
                      child: Container(
                        padding: const EdgeInsets.all(15),
                        alignment: Alignment.center,
                        width: double.infinity,
                        decoration: BoxDecoration(
                          color: const Color(0xFF02CCAA),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Text(
                                state.isLogin
                                    ? 'Kirish'
                                    : 'Ro\'yxatdan o\'tish',
                                style: const TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                ),
                              ),
                      ),
                    ),
                    const SizedBox(height: 38),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          state.isLogin
                              ? 'Hisobingiz yo\'qmi?'
                              : 'Hisobga kirish',
                          style: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w500,
                            color: Colors.black,
                          ),
                        ),
                        TextButton(
                          onPressed: () => context
                              .read<AuthBloc>()
                              .add(ToggleLoginFormEvent()),
                          child: Text(
                            !state.isLogin ? 'Kirish' : 'Ro\'yxatdan o\'tish',
                            style: const TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.w500,
                              color: Color(0xFF775A0B),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
