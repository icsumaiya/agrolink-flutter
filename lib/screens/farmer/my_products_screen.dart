import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../core/theme/app_spacing.dart';
import '../../data/sample_data.dart';
import '../../l10n/app_localizations.dart';
import '../../providers/auth_provider.dart';
import '../../utils/app_feedback.dart';
import '../../widgets/empty_state_widget.dart';
import '../../widgets/product_card.dart';
import '../buyer/product_details_screen.dart';

/// Ownership rule (Section 3): only products where farmerId == currentUser.id
/// are ever shown or editable here. Add/Edit Product forms arrive in Phase 2.
class MyProductsScreen extends StatelessWidget {
  const MyProductsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final farmer = context.watch<AuthProvider>().currentUser;
    if (farmer == null) return const SizedBox.shrink();

    final myProducts =
        SampleData.products.where((p) => p.farmerId == farmer.id).toList();

    return Scaffold(
      appBar: AppBar(
        title: Text(l10n.myProducts),
        actions: [
          IconButton(
            tooltip: l10n.addProduct,
            icon: const Icon(Icons.add),
            onPressed: () =>
                AppFeedback.success(context, l10n.comingSoonFeature),
          ),
        ],
      ),
      body: Center(
        child: ConstrainedBox(
          constraints:
              const BoxConstraints(maxWidth: AppSpacing.maxContentWidth),
          child: myProducts.isEmpty
              ? EmptyStateWidget(
                  title: l10n.noProductsYet,
                  message: l10n.noProductsYetHint,
                  icon: Icons.inventory_2_outlined,
                  actionLabel: l10n.addProduct,
                  onAction: () =>
                      AppFeedback.success(context, l10n.comingSoonFeature),
                )
              : GridView.builder(
                  padding: const EdgeInsets.all(AppSpacing.md),
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    mainAxisSpacing: AppSpacing.sm,
                    crossAxisSpacing: AppSpacing.sm,
                    childAspectRatio: 0.68,
                  ),
                  itemCount: myProducts.length,
                  itemBuilder: (context, i) {
                    final p = myProducts[i];
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
        ),
      ),
    );
  }
}