import 'package:flutter/material.dart';

import '../../core/theme/app_colors.dart';
import '../../core/theme/app_spacing.dart';
import '../../l10n/app_localizations.dart';
import '../../utils/app_feedback.dart';
import '../../widgets/app_button.dart';
import '../../widgets/app_text_field.dart';
import '../../widgets/confirm_dialog.dart';
import '../../widgets/empty_state_widget.dart';
import '../../widgets/error_state_widget.dart';
import '../../widgets/loading_widget.dart';
import '../../widgets/price_text.dart';
import '../../widgets/product_card.dart';
import '../../widgets/star_rating_widget.dart';
import '../../widgets/status_badge.dart';
import 'settings_screen.dart';

/// TEMPORARY: visual test for shared widgets. Deleted in Step 6.
class WidgetGalleryScreen extends StatefulWidget {
  const WidgetGalleryScreen({super.key});

  @override
  State<WidgetGalleryScreen> createState() => _WidgetGalleryScreenState();
}

class _WidgetGalleryScreenState extends State<WidgetGalleryScreen> {
  final _formKey = GlobalKey<FormState>();
  int _rating = 0;
  bool _loading = false;

  Future<void> _submit() async {
    if (!_formKey.currentState!.validate()) {
      AppFeedback.error(context, 'Please fix the errors');
      return;
    }
    setState(() => _loading = true);
    await Future<void>.delayed(const Duration(seconds: 1));
    if (!mounted) return;
    setState(() => _loading = false);
    AppFeedback.success(context, 'Form submitted');
  }

  Future<void> _confirm() async {
    final ok = await ConfirmDialog.show(
      context,
      title: 'Delete product?',
      message: 'This cannot be undone.',
      confirmLabel: 'Delete',
      isDestructive: true,
    );
    if (!mounted) return;
    ok
        ? AppFeedback.success(context, 'Deleted')
        : AppFeedback.error(context, 'Cancelled');
  }

  Widget _section(String title) => Padding(
        padding: const EdgeInsets.only(
          top: AppSpacing.lg,
          bottom: AppSpacing.sm,
        ),
        child: Text(title, style: Theme.of(context).textTheme.titleLarge),
      );

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);

    return Scaffold(
      appBar: AppBar(
        title: Text(l10n.appName),
        actions: [
          IconButton(
            tooltip: l10n.settings,
            icon: const Icon(Icons.settings),
            onPressed: () => Navigator.of(context).push(
              MaterialPageRoute(builder: (_) => const SettingsScreen()),
            ),
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
              _section('Form + AppButton'),
              Form(
                key: _formKey,
                child: Column(
                  children: [
                    AppTextField(
                      label: 'Email',
                      prefixIcon: Icons.email_outlined,
                      keyboardType: TextInputType.emailAddress,
                      validator: (v) =>
                          (v == null || v.isEmpty) ? 'Required' : null,
                    ),
                    const SizedBox(height: AppSpacing.md),
                    AppTextField(
                      label: 'Password',
                      isPassword: true,
                      prefixIcon: Icons.lock_outline,
                      validator: (v) => (v == null || v.length < 6)
                          ? 'Min 6 characters'
                          : null,
                    ),
                    const SizedBox(height: AppSpacing.md),
                    AppButton(
                      label: 'Submit',
                      icon: Icons.check,
                      isLoading: _loading,
                      onPressed: _submit,
                    ),
                    const SizedBox(height: AppSpacing.sm),
                    AppButton(
                      label: 'Delete (confirm dialog)',
                      type: AppButtonType.outlined,
                      isDestructive: true,
                      icon: Icons.delete_outline,
                      onPressed: _confirm,
                    ),
                  ],
                ),
              ),
              _section('PriceText + StarRating + StatusBadge'),
              const PriceText(price: 1250.5, unit: 'kg'),
              const SizedBox(height: AppSpacing.sm),
              const StarRatingWidget(rating: 3.5),
              StarRatingWidget(
                rating: _rating.toDouble(),
                size: 28,
                onChanged: (v) => setState(() => _rating = v),
              ),
              const SizedBox(height: AppSpacing.sm),
              const Wrap(
                spacing: AppSpacing.sm,
                runSpacing: AppSpacing.sm,
                children: [
                  StatusBadge(label: 'Pending', color: AppColors.pending),
                  StatusBadge(label: 'Accepted', color: AppColors.accepted),
                  StatusBadge(label: 'Preparing', color: AppColors.preparing),
                  StatusBadge(label: 'Completed', color: AppColors.completed),
                  StatusBadge(label: 'Rejected', color: AppColors.rejected),
                  StatusBadge(label: 'Cancelled', color: AppColors.cancelled),
                ],
              ),
              _section('ProductCard'),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: ProductCard(
                      name: 'Fresh Tomato',
                      price: 45,
                      unit: 'kg',
                      location: 'Sylhet',
                      rating: 4.5,
                      isAvailable: true,
                      onTap: () {},
                      trailing: IconButton.filledTonal(
                        tooltip: 'Wishlist',
                        icon: const Icon(Icons.favorite_border),
                        onPressed: () {},
                      ),
                    ),
                  ),
                  const SizedBox(width: AppSpacing.md),
                  Expanded(
                    child: ProductCard(
                      name: 'Basmati Rice',
                      price: 60,
                      unit: 'kg',
                      location: 'Bogura',
                      isAvailable: false,
                      onTap: () {},
                    ),
                  ),
                ],
              ),
              _section('Empty / Error / Loading'),
              const SizedBox(
                height: 200,
                child: EmptyStateWidget(
                  title: 'No products found',
                  message: 'Try changing your filters.',
                  icon: Icons.search_off,
                ),
              ),
              SizedBox(
                height: 200,
                child: ErrorStateWidget(
                  message: 'Something went wrong.',
                  onRetry: () {},
                ),
              ),
              const SizedBox(
                height: 100,
                child: LoadingWidget(message: 'Loading...'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}