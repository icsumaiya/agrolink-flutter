import 'package:flutter/material.dart';

import 'core/theme/app_colors.dart';
import 'core/theme/app_spacing.dart';
import 'core/theme/app_theme.dart';

void main() => runApp(const AgroLinkApp());

class AgroLinkApp extends StatefulWidget {
  const AgroLinkApp({super.key});

  @override
  State<AgroLinkApp> createState() => _AgroLinkAppState();
}

class _AgroLinkAppState extends State<AgroLinkApp> {
  ThemeMode _mode = ThemeMode.light;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'AgroLink',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.light,
      darkTheme: AppTheme.dark,
      themeMode: _mode,
      home: _ThemePreview(
        isDark: _mode == ThemeMode.dark,
        onToggle: (v) =>
            setState(() => _mode = v ? ThemeMode.dark : ThemeMode.light),
      ),
    );
  }
}

/// Temporary screen to verify the design system. Replaced in Step 3/6.
class _ThemePreview extends StatelessWidget {
  const _ThemePreview({required this.isDark, required this.onToggle});

  final bool isDark;
  final ValueChanged<bool> onToggle;

  @override
  Widget build(BuildContext context) {
    final text = Theme.of(context).textTheme;
    return Scaffold(
      appBar: AppBar(
        title: const Text('AgroLink'),
        actions: [
          Switch(value: isDark, onChanged: onToggle),
        ],
      ),
      body: ListView(
        padding: const EdgeInsets.all(AppSpacing.md),
        children: [
          Text('Headline', style: text.headlineMedium),
          const SizedBox(height: AppSpacing.sm),
          Text('Body text preview', style: text.bodyLarge),
          const SizedBox(height: AppSpacing.md),
          const TextField(decoration: InputDecoration(labelText: 'Email')),
          const SizedBox(height: AppSpacing.md),
          FilledButton(onPressed: () {}, child: const Text('Filled')),
          const SizedBox(height: AppSpacing.sm),
          OutlinedButton(onPressed: () {}, child: const Text('Outlined')),
          const SizedBox(height: AppSpacing.md),
          Card(
            child: Padding(
              padding: const EdgeInsets.all(AppSpacing.md),
              child: Row(
                children: [
                  for (final c in [
                    AppColors.pending,
                    AppColors.accepted,
                    AppColors.preparing,
                    AppColors.completed,
                    AppColors.rejected,
                    AppColors.cancelled,
                  ])
                    Expanded(child: CircleAvatar(backgroundColor: c)),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}