import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../core/theme/app_spacing.dart';
import '../../data/sample_data.dart';
import '../../l10n/app_localizations.dart';
import '../../models/enums.dart';
import '../../providers/auth_provider.dart';
import '../../utils/category_labels.dart';
import '../../widgets/product_card.dart';
import '../common/profile_screen.dart';
import 'product_details_screen.dart';
import 'product_list_screen.dart';

class BuyerHomeScreen extends StatelessWidget {
  const BuyerHomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final user = context.watch<AuthProvider>().currentUser;
    final theme = Theme.of(context);
    final text = theme.textTheme;

    final featured = SampleData.products.where((p) => p.isActive).take(4).toList();

    return Scaffold(
      appBar: AppBar(
        title: Text(l10n.appName),
        actions: [
          IconButton(
            tooltip: l10n.profile,
            icon: const Icon(Icons.person_outline),
            onPressed: () => Navigator.of(context).push(
              MaterialPageRoute(builder: (_) => const ProfileScreen()),
            ),
          ),
          IconButton(
            tooltip: l10n.allProducts,
            icon: const Icon(Icons.search),
            onPressed: () => Navigator.of(context).push(
              MaterialPageRoute(builder: (_) => const ProductListScreen()),
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
              Text(
                'Hi, ${user?.name ?? ''}',
                style: text.headlineMedium,
              ),
              const SizedBox(height: AppSpacing.xs),
              Text(l10n.tagline, style: text.bodyMedium),
              const SizedBox(height: AppSpacing.lg),

              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(l10n.categories, style: text.titleMedium),
                ],
              ),
              const SizedBox(height: AppSpacing.sm),
              SizedBox(
                height: 84,
                child: ListView.separated(
                  scrollDirection: Axis.horizontal,
                  itemCount: ProductCategory.values.length,
                  separatorBuilder: (_, __) =>
                      const SizedBox(width: AppSpacing.sm),
                  itemBuilder: (context, i) {
                    final c = ProductCategory.values[i];
                    return InkWell(
                      borderRadius: BorderRadius.circular(AppSpacing.radiusMd),
                      onTap: () => Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (_) =>
                              ProductListScreen(initialCategory: c),
                        ),
                      ),
                      child: SizedBox(
                        width: 72,
                        child: Column(
                          children: [
                            CircleAvatar(
                              radius: 26,
                              backgroundColor: theme.colorScheme.primaryContainer,
                              child: Icon(c.icon,
                                  color: theme.colorScheme.onPrimaryContainer),
                            ),
                            const SizedBox(height: AppSpacing.xs),
                            Text(
                              c.label(l10n),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: text.bodySmall,
                              textAlign: TextAlign.center,
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ),
              const SizedBox(height: AppSpacing.lg),

              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(l10n.featuredProducts, style: text.titleMedium),
                  TextButton(
                    onPressed: () => Navigator.of(context).push(
                      MaterialPageRoute(builder: (_) => const ProductListScreen()),
                    ),
                    child: Text(l10n.allProducts),
                  ),
                ],
              ),
              GridView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  mainAxisSpacing: AppSpacing.sm,
                  crossAxisSpacing: AppSpacing.sm,
                  childAspectRatio: 0.68,
                ),
                itemCount: featured.length,
                itemBuilder: (context, i) {
                  final p = featured[i];
                  return ProductCard(
                    name: p.name,
                    price: p.price,
                    unit: p.unit,
                    location: p.location,
                    isAvailable: p.isAvailable,
                    rating: p.averageRating,
                    imagePath: p.imagePath,
                    onTap: () => Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (_) => ProductDetailsScreen(product: p),
                      ),
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}