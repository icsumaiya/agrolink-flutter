import 'package:flutter/material.dart';

import '../core/theme/app_colors.dart';
import '../core/theme/app_spacing.dart';
import '../l10n/app_localizations.dart';
import 'price_text.dart';
import 'safe_image.dart';
import 'status_badge.dart';

/// Takes plain values (not the Product model) so it can be built before
/// models exist. Step 8 passes product fields into it.
class ProductCard extends StatelessWidget {
  const ProductCard({
    super.key,
    required this.name,
    required this.price,
    required this.unit,
    required this.location,
    required this.isAvailable,
    this.rating = 0,
    this.imagePath,
    this.onTap,
    this.trailing,
  });

  final String name;
  final double price;
  final String unit;
  final String location;
  final bool isAvailable;
  final double rating;
  final String? imagePath;
  final VoidCallback? onTap;
  final Widget? trailing; // e.g. wishlist heart button

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final theme = Theme.of(context);
    final text = theme.textTheme;
    final muted = theme.colorScheme.onSurfaceVariant;

    return Card(
      clipBehavior: Clip.antiAlias,
      child: InkWell(
        onTap: onTap,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Stack(
              children: [
                AspectRatio(
                  aspectRatio: 4 / 3,
                  child: SizedBox.expand(child: SafeImage(path: imagePath)),
                ),
                if (trailing != null)
                  Positioned(
                    top: AppSpacing.xs,
                    right: AppSpacing.xs,
                    child: trailing!,
                  ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.all(AppSpacing.sm),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    name,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: text.titleMedium,
                  ),
                  const SizedBox(height: AppSpacing.xs),
                  Row(
                    children: [
                      Icon(Icons.place_outlined, size: 14, color: muted),
                      const SizedBox(width: AppSpacing.xs),
                      Expanded(
                        child: Text(
                          location,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: text.bodySmall,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: AppSpacing.xs),
                  Row(
                    children: [
                      Expanded(child: PriceText(price: price, unit: unit)),
                      if (rating > 0) ...[
                        const Icon(Icons.star,
                            size: 14, color: AppColors.secondary),
                        const SizedBox(width: 2),
                        Text(rating.toStringAsFixed(1), style: text.bodySmall),
                      ],
                    ],
                  ),
                  const SizedBox(height: AppSpacing.xs),
                  StatusBadge(
                    label: isAvailable ? l10n.available : l10n.outOfStock,
                    color:
                        isAvailable ? AppColors.completed : AppColors.rejected,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}