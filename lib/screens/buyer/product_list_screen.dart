import 'package:flutter/material.dart';

import '../../core/theme/app_spacing.dart';
import '../../data/sample_data.dart';
import '../../l10n/app_localizations.dart';
import '../../models/enums.dart';
import '../../models/product.dart';
import '../../utils/category_labels.dart';
import '../../widgets/empty_state_widget.dart';
import '../../widgets/product_card.dart';
import 'product_details_screen.dart';

/// UI only in Phase 1: search/category filter run on the in-memory list.
/// Phase 2 moves this logic into ProductProvider (with price/availability
/// filters and sort, per Section 17).
class ProductListScreen extends StatefulWidget {
  const ProductListScreen({super.key, this.initialCategory});

  final ProductCategory? initialCategory;

  @override
  State<ProductListScreen> createState() => _ProductListScreenState();
}

class _ProductListScreenState extends State<ProductListScreen> {
  final _searchController = TextEditingController();
  String _query = '';
  ProductCategory? _category;

  @override
  void initState() {
    super.initState();
    _category = widget.initialCategory;
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  List<Product> get _filtered {
    return SampleData.products.where((p) {
      if (!p.isActive) return false;
      final matchesQuery =
          _query.isEmpty || p.name.toLowerCase().contains(_query.toLowerCase());
      final matchesCategory = _category == null || p.category == _category;
      return matchesQuery && matchesCategory;
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final results = _filtered;

    return Scaffold(
      appBar: AppBar(title: Text(l10n.allProducts)),
      body: Center(
        child: ConstrainedBox(
          constraints:
              const BoxConstraints(maxWidth: AppSpacing.maxContentWidth),
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(AppSpacing.md),
                child: TextField(
                  controller: _searchController,
                  onChanged: (v) => setState(() => _query = v),
                  decoration: InputDecoration(
                    hintText: l10n.searchProducts,
                    prefixIcon: const Icon(Icons.search),
                    suffixIcon: _query.isEmpty
                        ? null
                        : IconButton(
                            icon: const Icon(Icons.clear),
                            onPressed: () {
                              _searchController.clear();
                              setState(() => _query = '');
                            },
                          ),
                  ),
                ),
              ),
              SizedBox(
                height: 40,
                child: ListView(
                  scrollDirection: Axis.horizontal,
                  padding: const EdgeInsets.symmetric(horizontal: AppSpacing.md),
                  children: [
                    _CategoryChip(
                      label: l10n.allProducts,
                      selected: _category == null,
                      onTap: () => setState(() => _category = null),
                    ),
                    for (final c in ProductCategory.values)
                      Padding(
                        padding: const EdgeInsets.only(left: AppSpacing.sm),
                        child: _CategoryChip(
                          label: c.label(l10n),
                          selected: _category == c,
                          onTap: () => setState(() => _category = c),
                        ),
                      ),
                  ],
                ),
              ),
              const SizedBox(height: AppSpacing.sm),
              Expanded(
                child: results.isEmpty
                    ? EmptyStateWidget(
                        title: l10n.noProductsFound,
                        message: l10n.noProductsHint,
                        icon: Icons.search_off,
                      )
                    : GridView.builder(
                        padding: const EdgeInsets.all(AppSpacing.md),
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          mainAxisSpacing: AppSpacing.sm,
                          crossAxisSpacing: AppSpacing.sm,
                          childAspectRatio: 0.68,
                        ),
                        itemCount: results.length,
                        itemBuilder: (context, i) {
                          final p = results[i];
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
                                builder: (_) =>
                                    ProductDetailsScreen(product: p),
                              ),
                            ),
                          );
                        },
                      ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _CategoryChip extends StatelessWidget {
  const _CategoryChip({
    required this.label,
    required this.selected,
    required this.onTap,
  });

  final String label;
  final bool selected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return ChoiceChip(label: Text(label), selected: selected, onSelected: (_) => onTap());
  }
}