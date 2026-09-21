import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../core/theme/app_spacing.dart';
import '../../l10n/app_localizations.dart';
import '../../providers/settings_provider.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final settings = context.watch<SettingsProvider>();
    final text = Theme.of(context).textTheme;

    return Scaffold(
      appBar: AppBar(title: Text(l10n.settings)),
      body: Center(
        child: ConstrainedBox(
          constraints:
              const BoxConstraints(maxWidth: AppSpacing.maxContentWidth),
          child: ListView(
            padding: const EdgeInsets.all(AppSpacing.md),
            children: [
              Text(l10n.appName, style: text.headlineMedium),
              const SizedBox(height: AppSpacing.xs),
              Text(l10n.tagline, style: text.bodyLarge),
              const SizedBox(height: AppSpacing.lg),
              Text(l10n.theme, style: text.titleMedium),
              SwitchListTile(
                contentPadding: EdgeInsets.zero,
                title: Text(l10n.darkMode),
                value: settings.isDark,
                onChanged: settings.setDarkMode,
              ),
              const SizedBox(height: AppSpacing.md),
              Text(l10n.language, style: text.titleMedium),
              const SizedBox(height: AppSpacing.sm),
              SegmentedButton<String>(
                segments: [
                  ButtonSegment(value: 'en', label: Text(l10n.english)),
                  ButtonSegment(value: 'bn', label: Text(l10n.bangla)),
                ],
                selected: {settings.locale.languageCode},
                onSelectionChanged: (s) => settings.setLanguage(s.first),
              ),
            ],
          ),
        ),
      ),
    );
  }
}