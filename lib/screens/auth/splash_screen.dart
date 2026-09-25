import 'package:flutter/material.dart';

import '../../core/theme/app_spacing.dart';
import '../../l10n/app_localizations.dart';
import 'login_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    // Phase 2: check the saved session here and skip Login if logged in.
    Future<void>.delayed(const Duration(seconds: 2), () {
      if (!mounted) return;
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (_) => const LoginScreen()),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final scheme = Theme.of(context).colorScheme;
    final text = Theme.of(context).textTheme;

    return Scaffold(
      backgroundColor: scheme.primary,
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(Icons.agriculture, size: 88, color: scheme.onPrimary),
            const SizedBox(height: AppSpacing.md),
            Text(
              l10n.appName,
              style: text.headlineLarge?.copyWith(color: scheme.onPrimary),
            ),
            const SizedBox(height: AppSpacing.sm),
            Text(
              l10n.tagline,
              style: text.bodyLarge?.copyWith(color: scheme.onPrimary),
            ),
            const SizedBox(height: AppSpacing.xl),
            CircularProgressIndicator(color: scheme.onPrimary),
          ],
        ),
      ),
    );
  }
}