import 'package:flutter/material.dart';

import '../../core/theme/app_spacing.dart';

/// TEMPORARY placeholder for a not-yet-built tab. Replaced screen by screen
/// in Step 8 (buyer) and Step 9 (farmer).
class ComingSoonScreen extends StatelessWidget {
  const ComingSoonScreen({super.key, required this.label, required this.icon});

  final String label;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(AppSpacing.lg),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(icon, size: 56, color: theme.colorScheme.onSurfaceVariant),
            const SizedBox(height: AppSpacing.md),
            Text(label, style: theme.textTheme.titleMedium),
          ],
        ),
      ),
    );
  }
}