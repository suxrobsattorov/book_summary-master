import 'package:flutter/material.dart';
import 'package:toastification/toastification.dart';

class AppDialogs {
  static bool _isLoading = false;

  static showLoading(BuildContext context) {
    if (!_isLoading) {
      showDialog(
        context: context,
        builder: (ctx) => const Center(
          child: CircularProgressIndicator(
            color: Colors.white,
          ),
        ),
      );
      _isLoading = true;
    }
  }

  static hideLoading(BuildContext context) {
    if (_isLoading) {
      Navigator.pop(context);
      _isLoading = false;
    }
  }

  static showToast(String message, ToastificationType type) {
    toastification.show(
      title: Text(message),
      type: type,
      alignment: Alignment.topCenter,
      autoCloseDuration: const Duration(seconds: 5),
    );
  }
}
