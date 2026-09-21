import 'package:flutter/material.dart';

import '../core/theme/app_spacing.dart';

enum AppButtonType { filled, outlined }

/// Shared button: filled/outlined, optional icon, loading state,
/// destructive style (delete/cancel actions).
class AppButton extends StatelessWidget {
  const AppButton({
    super.key,
    required this.label,
    required this.onPressed,
    this.icon,
    this.type = AppButtonType.filled,
    this.isLoading = false,
    this.isDestructive = false,
    this.expand = true,
  });

  final String label;
  final VoidCallback? onPressed;
  final IconData? icon;
  final AppButtonType type;
  final bool isLoading;
  final bool isDestructive;
  final bool expand;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    final handler = isLoading ? null : onPressed;

    final child = isLoading
        ? Builder(
            builder: (ctx) => SizedBox(
              height: 20,
              width: 20,
              child: CircularProgressIndicator(
                strokeWidth: 2,
                color: IconTheme.of(ctx).color,
              ),
            ),
          )
        : Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              if (icon != null) ...[
                Icon(icon, size: 20),
                const SizedBox(width: AppSpacing.sm),
              ],
              Flexible(child: Text(label, overflow: TextOverflow.ellipsis)),
            ],
          );

    final Widget button;
    if (type == AppButtonType.filled) {
      button = FilledButton(
        onPressed: handler,
        style: isDestructive
            ? FilledButton.styleFrom(
                backgroundColor: scheme.error,
                foregroundColor: scheme.onError,
              )
            : null,
        child: child,
      );
    } else {
      button = OutlinedButton(
        onPressed: handler,
        style: isDestructive
            ? OutlinedButton.styleFrom(
                foregroundColor: scheme.error,
                side: BorderSide(color: scheme.error),
              )
            : null,
        child: child,
      );
    }

    return SizedBox(width: expand ? double.infinity : null, child: button);
  }
}