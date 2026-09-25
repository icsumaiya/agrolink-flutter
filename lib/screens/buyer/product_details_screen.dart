import 'package:flutter/material.dart';

import '../../core/theme/app_colors.dart';
import '../../core/theme/app_spacing.dart';
import '../../data/sample_data.dart';
import '../../l10n/app_localizations.dart';
import '../../models/product.dart';
import '../../utils/app_feedback.dart';
import '../../utils/category_labels.dart';
import '../../widgets/app_button.dart';
import '../../widgets/price_text.dart';
import '../../widgets/safe_image.dart';
import '../../widgets/star_rating_widget.dart';
import '../../widgets/status_badge.dart';

class ProductDetailsScreen extends StatefulWidget {
  const ProductDetailsScreen({super.key, required this.product});

  final Product product;

  @override
  State<ProductDetailsScreen> createState() => _ProductDetailsScreenState();
}

class _ProductDetailsScreenState extends State<ProductDetailsScreen> {
  bool _wishlisted = false;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final theme = Theme.of(context);
    final text = theme.textTheme;
    final p = widget.product;
    final farmer = SampleData.userById(p.farmerId);
    final reviews = SampleData.reviews.where((r) => r.productId == p.id).toList()
      ..sort((a, b) => b.createdAt.compareTo(a.createdAt));

    return Scaffold(
      appBar: AppBar(
        title: Text(l10n.productDetails),
        actions: [
          IconButton(
            tooltip: 'Wishlist',
            icon: Icon(_wishlisted ? Icons.favorite : Icons.favorite_border),
            onPressed: () {
              setState(() => _wishlisted = !_wishlisted);
              AppFeedback.success(
                context,
                _wishlisted ? l10n.addedToWishlist : l10n.removedFromWishlist,
              );
            },
          ),
        ],
      ),
      body: SafeArea(
        child: Center(
          child: ConstrainedBox(
            constraints:
                const BoxConstraints(maxWidth: AppSpacing.maxContentWidth),
            child: ListView(
              padding: const EdgeInsets.all(AppSpacing.md),
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(AppSpacing.radiusMd),
                  child: AspectRatio(
                    aspectRatio: 16 / 9,
                    child: SafeImage(path: p.imagePath),
                  ),
                ),
                const SizedBox(height: AppSpacing.md),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(p.name, style: text.headlineMedium),
                          const SizedBox(height: AppSpacing.xs),
                          Row(
                            children: [
                              Icon(p.category.icon,
                                  size: 16,
                                  color: theme.colorScheme.onSurfaceVariant),
                              const SizedBox(width: AppSpacing.xs),
                              Text(
                                p.category.label(l10n),
                                style: text.bodyMedium,
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    StatusBadge(
                      label: p.isAvailable ? l10n.available : l10n.outOfStock,
                      color: p.isAvailable
                          ? AppColors.completed
                          : AppColors.rejected,
                    ),
                  ],
                ),
                const SizedBox(height: AppSpacing.sm),
                Row(
                  children: [
                    StarRatingWidget(rating: p.averageRating),
                    const SizedBox(width: AppSpacing.xs),
                    Text(
                      '${p.averageRating.toStringAsFixed(1)} '
                      '(${p.reviewCount})  •  ${p.totalSold} ${l10n.sold}',
                      style: text.bodySmall,
                    ),
                  ],
                ),
                const SizedBox(height: AppSpacing.md),
                PriceText(
                  price: p.price,
                  unit: p.unit,
                  style: text.headlineMedium
                      ?.copyWith(color: theme.colorScheme.primary),
                ),
                const SizedBox(height: AppSpacing.lg),
                Text(l10n.description, style: text.titleMedium),
                const SizedBox(height: AppSpacing.xs),
                Text(p.description, style: text.bodyMedium),
                const SizedBox(height: AppSpacing.lg),
                Text(l10n.location, style: text.titleMedium),
                const SizedBox(height: AppSpacing.xs),
                Row(
                  children: [
                    Icon(Icons.place_outlined,
                        size: 18, color: theme.colorScheme.onSurfaceVariant),
                    const SizedBox(width: AppSpacing.xs),
                    Expanded(child: Text(p.location, style: text.bodyMedium)),
                  ],
                ),
                const SizedBox(height: AppSpacing.xs),
                // Static map preview placeholder; real flutter_map view is Phase 2.
                Container(
                  height: 140,
                  decoration: BoxDecoration(
                    color: theme.colorScheme.surfaceContainerHighest,
                    borderRadius: BorderRadius.circular(AppSpacing.radiusMd),
                  ),
                  alignment: Alignment.center,
                  child: Icon(Icons.map_outlined,
                      size: 40, color: theme.colorScheme.onSurfaceVariant),
                ),
                const SizedBox(height: AppSpacing.lg),
                Text(l10n.farmerInfo, style: text.titleMedium),
                const SizedBox(height: AppSpacing.sm),
                Card(
                  child: Padding(
                    padding: const EdgeInsets.all(AppSpacing.md),
                    child: Row(
                      children: [
                        CircleAvatar(
                          radius: 24,
                          backgroundColor: theme.colorScheme.primaryContainer,
                          child: ClipOval(
                            child: SizedBox(
                              width: 48,
                              height: 48,
                              child: SafeImage(
                                path: farmer?.imagePath,
                                placeholderIcon: Icons.person,
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(width: AppSpacing.md),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(farmer?.name ?? '', style: text.titleMedium),
                              Text(farmer?.location ?? '',
                                  style: text.bodySmall),
                            ],
                          ),
                        ),
                        IconButton.filledTonal(
                          tooltip: l10n.callFarmer,
                          icon: const Icon(Icons.call_outlined),
                          onPressed: () => AppFeedback.success(
                            context,
                            l10n.comingSoonFeature,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: AppSpacing.lg),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(l10n.reviews, style: text.titleMedium),
                    Text('${p.reviewCount}', style: text.bodyMedium),
                  ],
                ),
                const SizedBox(height: AppSpacing.sm),
                if (reviews.isEmpty)
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: AppSpacing.md),
                    child: Text(l10n.noReviewsYet, style: text.bodyMedium),
                  )
                else
                  for (final r in reviews)
                    Padding(
                      padding: const EdgeInsets.only(bottom: AppSpacing.sm),
                      child: Card(
                        child: Padding(
                          padding: const EdgeInsets.all(AppSpacing.md),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(r.buyerDisplayName,
                                      style: text.titleMedium),
                                  StarRatingWidget(
                                    rating: r.rating.toDouble(),
                                    size: 16,
                                  ),
                                ],
                              ),
                              if (r.comment.isNotEmpty) ...[
                                const SizedBox(height: AppSpacing.xs),
                                Text(r.comment, style: text.bodyMedium),
                              ],
                            ],
                          ),
                        ),
                      ),
                    ),
                const SizedBox(height: AppSpacing.xl),
              ],
            ),
          ),
        ),
      ),
      bottomNavigationBar: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(AppSpacing.md),
          child: AppButton(
            label: l10n.sendOrderRequest,
            icon: Icons.shopping_basket_outlined,
            onPressed: p.isAvailable
                ? () => AppFeedback.success(context, l10n.comingSoonFeature)
                : null,
          ),
        ),
      ),
    );
  }
}