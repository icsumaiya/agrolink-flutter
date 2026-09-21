import 'package:flutter/material.dart';

import '../core/theme/app_spacing.dart';

/// One place for success/error SnackBars so every screen looks the same.
class AppFeedback {
  AppFeedback._();

  static void success(BuildContext context, String message) =>
      _show(context, message, isError: false);

  static void error(BuildContext context, String message) =>
      _show(context, message, isError: true);

  static void _show(BuildContext context, String message,
      {required bool isError}) {
    final scheme = Theme.of(context).colorScheme;
    final bg = isError ? scheme.error : scheme.primary;
    final fg = isError ? scheme.onError : scheme.onPrimary;

    ScaffoldMessenger.of(context)
      ..hideCurrentSnackBar()
      ..showSnackBar(
        SnackBar(
          behavior: SnackBarBehavior.floating,
          backgroundColor: bg,
          content: Row(
            children: [
              Icon(
                isError ? Icons.error_outline : Icons.check_circle_outline,
                color: fg,
              ),
              const SizedBox(width: AppSpacing.sm),
              Expanded(child: Text(message, style: TextStyle(color: fg))),
            ],
          ),
        ),
      );
  }
}
