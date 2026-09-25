import '../l10n/app_localizations.dart';
import '../models/enums.dart';
import 'package:flutter/material.dart';

extension ProductCategoryLabel on ProductCategory {
  String label(AppLocalizations l10n) {
    switch (this) {
      case ProductCategory.vegetables:
        return l10n.categoryVegetables;
      case ProductCategory.fruits:
        return l10n.categoryFruits;
      case ProductCategory.rice:
        return l10n.categoryRice;
      case ProductCategory.fish:
        return l10n.categoryFish;
      case ProductCategory.meat:
        return l10n.categoryMeat;
      case ProductCategory.grains:
        return l10n.categoryGrains;
      case ProductCategory.spices:
        return l10n.categorySpices;
      case ProductCategory.other:
        return l10n.categoryOther;
    }
  }

  IconData get icon {
    switch (this) {
      case ProductCategory.vegetables:
        return Icons.eco_outlined;
      case ProductCategory.fruits:
        return Icons.apple;
      case ProductCategory.rice:
        return Icons.rice_bowl_outlined;
      case ProductCategory.fish:
        return Icons.set_meal_outlined;
      case ProductCategory.meat:
        return Icons.kebab_dining_outlined;
      case ProductCategory.grains:
        return Icons.grain;
      case ProductCategory.spices:
        return Icons.local_fire_department_outlined;
      case ProductCategory.other:
        return Icons.category_outlined;
    }
  }
}