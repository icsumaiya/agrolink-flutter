import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../core/theme/app_spacing.dart';
import '../../data/sample_data.dart';
import '../../l10n/app_localizations.dart';
import '../../models/enums.dart';
import '../../providers/auth_provider.dart';
import '../../widgets/price_text.dart';
import '../common/profile_screen.dart';

/// Stats come only from real sample data (Section 17): never hardcoded.
/// Phase 2 recomputes these from Hive via the repository layer.
class FarmerDashboardScreen extends StatelessWidget {
  const FarmerDashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final theme = Theme.of(context);
    final text = theme.textTheme;
    final farmer = context.watch<AuthProvider>().currentUser;
    if (farmer == null) return const SizedBox.shrink();

    final myProducts =
        SampleData.products.where((p) => p.farmerId == farmer.id).toList();
    final myOrders =
        SampleData.orders.where((o) => o.farmerId == farmer.id).toList();

    final activeCount = myProducts.where((p) => p.isActive).length;
    final pendingCount =
        myOrders.where((o) => o.status == OrderStatus.pending).length;
    final completedCount =
        myOrders.where((o) => o.status == OrderStatus.completed).length;

    final topSelling = [...myProducts]
      ..sort((a, b) => b.totalSold.compareTo(a.totalSold));
    final topFive = topSelling.where((p) => p.totalSold > 0).take(5).toList();

    return Scaffold(
      appBar: AppBar(
        title: Text(l10n.dashboard),
        actions: [
          IconButton(
            tooltip: l10n.profile,
            icon: const Icon(Icons.person_outline),
            onPressed: () => Navigator.of(context).push(
              MaterialPageRoute(builder: (_) => const ProfileScreen()),
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
              Text('${farmer.name}', style: text.headlineMedium),
              const SizedBox(height: AppSpacing.lg),
              GridView.count(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                crossAxisCount: 2,
                mainAxisSpacing: AppSpacing.sm,
                crossAxisSpacing: AppSpacing.sm,
                childAspectRatio: 1.6,
                children: [
                  _StatCard(label: l10n.totalProducts, value: '${myProducts.length}'),
                  _StatCard(label: l10n.activeProducts, value: '$activeCount'),
                  _StatCard(label: l10n.pendingOrders, value: '$pendingCount'),
                  _StatCard(label: l10n.completedOrders, value: '$completedCount'),
                ],
              ),
              const SizedBox(height: AppSpacing.lg),
              Text(l10n.topSellingProducts, style: text.titleMedium),
              const SizedBox(height: AppSpacing.sm),
              if (topFive.isEmpty)
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: AppSpacing.md),
                  child: Text(l10n.noProductsYet, style: text.bodyMedium),
                )
              else
                for (var i = 0; i < topFive.length; i++)
                  Card(
                    margin: const EdgeInsets.only(bottom: AppSpacing.sm),
                    child: ListTile(
                      leading: CircleAvatar(child: Text('${i + 1}')),
                      title: Text(topFive[i].name),
                      subtitle: Text(
                        '${topFive[i].totalSold} ${l10n.unitsSold} • '
                        '${topFive[i].quantity} ${l10n.inStock}',
                      ),
                      trailing: PriceText(
                        price: topFive[i].price,
                        unit: topFive[i].unit,
                      ),
                    ),
                  ),
            ],
          ),
        ),
      ),
    );
  }
}

class _StatCard extends StatelessWidget {
  const _StatCard({required this.label, required this.value});

  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(AppSpacing.md),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              value,
              style: theme.textTheme.headlineMedium
                  ?.copyWith(color: theme.colorScheme.primary),
            ),
            const SizedBox(height: AppSpacing.xs),
            Text(
              label,
              style: theme.textTheme.bodySmall,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
          ],
        ),
      ),
    );
  }
}