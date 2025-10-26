import 'package:flutter/material.dart';
import 'package:weather/core/theme/app_theme.dart';

class Messenger {
  static void showErrorMessage(
    String message, {
    required BuildContext context,
  }) {
    ScaffoldMessenger.of(context).clearSnackBars();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(message, style: AppTheme.textTheme.titleMedium)),
    );
  }

  static void showSimpleMessage(
    String message, {
    required BuildContext context,
  }) {
    ScaffoldMessenger.of(context).clearSnackBars();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(message, style: AppTheme.textTheme.titleMedium)),
    );
  }
}
