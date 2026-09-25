import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../core/theme/app_spacing.dart';
import '../../l10n/app_localizations.dart';
import '../../models/enums.dart';
import '../../providers/auth_provider.dart';
import '../../utils/app_feedback.dart';
import '../../widgets/app_button.dart';
import '../../widgets/safe_image.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final theme = Theme.of(context);
    final text = theme.textTheme;
    final user = context.watch<AuthProvider>().currentUser;
    if (user == null) return const SizedBox.shrink();

    final roleLabel = user.role == UserRole.farmer ? l10n.farmer : l10n.buyer;

    return Scaffold(
      appBar: AppBar(
        title: Text(l10n.profile),
        actions: [
          IconButton(
            tooltip: l10n.editProfile,
            icon: const Icon(Icons.edit_outlined),
            onPressed: () =>
                AppFeedback.success(context, l10n.comingSoonFeature),
          ),
        ],
      ),
      body: Center(
        child: ConstrainedBox(
          constraints:
              const BoxConstraints(maxWidth: AppSpacing.maxContentWidth),
          child: ListView(
            padding: const EdgeInsets.all(AppSpacing.md),
            children: [
              Center(
                child: ClipOval(
                  child: SizedBox(
                    width: 96,
                    height: 96,
                    child: SafeImage(
                      path: user.imagePath,
                      placeholderIcon: Icons.person,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: AppSpacing.md),
              Center(child: Text(user.name, style: text.headlineMedium)),
              const SizedBox(height: AppSpacing.xs),
              Center(
                child: Chip(
                  label: Text(roleLabel),
                  avatar: Icon(
                    user.role == UserRole.farmer
                        ? Icons.agriculture
                        : Icons.shopping_basket_outlined,
                    size: 18,
                  ),
                ),
              ),
              const SizedBox(height: AppSpacing.lg),
              _InfoTile(icon: Icons.email_outlined, label: l10n.email, value: user.email),
              _InfoTile(icon: Icons.phone_outlined, label: l10n.phone, value: user.phone),
              if (user.location.isNotEmpty)
                _InfoTile(
                  icon: Icons.place_outlined,
                  label: l10n.location,
                  value: user.location,
                ),
              _InfoTile(
                icon: Icons.calendar_today_outlined,
                label: l10n.memberSince,
                value: '${user.createdAt.year}-${user.createdAt.month.toString().padLeft(2, '0')}',
              ),
              if (user.about.isNotEmpty) ...[
                const SizedBox(height: AppSpacing.md),
                Text(l10n.about, style: text.titleMedium),
                const SizedBox(height: AppSpacing.xs),
                Text(user.about, style: text.bodyMedium),
              ],
              const SizedBox(height: AppSpacing.lg),
              AppButton(
                label: l10n.editProfile,
                type: AppButtonType.outlined,
                icon: Icons.edit_outlined,
                onPressed: () =>
                    AppFeedback.success(context, l10n.comingSoonFeature),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _InfoTile extends StatelessWidget {
  const _InfoTile({required this.icon, required this.label, required this.value});

  final IconData icon;
  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: AppSpacing.xs),
      child: Row(
        children: [
          Icon(icon, size: 20, color: theme.colorScheme.onSurfaceVariant),
          const SizedBox(width: AppSpacing.sm),
          Text(label, style: theme.textTheme.bodySmall),
          const Spacer(),
          Flexible(
            child: Text(
              value,
              textAlign: TextAlign.end,
              style: theme.textTheme.bodyMedium,
            ),
          ),
        ],
      ),
    );
  }
}