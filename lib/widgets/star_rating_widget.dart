import 'package:flutter/material.dart';

import '../core/theme/app_colors.dart';

/// Display mode (onChanged == null): shows [rating] with half stars.
/// Input mode (onChanged != null): tappable 1-5 stars for reviews.
class StarRatingWidget extends StatelessWidget {
  const StarRatingWidget({
    super.key,
    required this.rating,
    this.size = 20,
    this.onChanged,
  });

  final double rating;
  final double size;
  final ValueChanged<int>? onChanged;

  @override
  Widget build(BuildContext context) {
    const color = AppColors.secondary;

    if (onChanged == null) {
      return Semantics(
        value: '${rating.toStringAsFixed(1)} / 5',
        excludeSemantics: true,
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            for (var i = 0; i < 5; i++)
              Icon(_iconFor(i), size: size, color: color),
          ],
        ),
      );
    }

    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        for (var i = 0; i < 5; i++)
          IconButton(
            tooltip: '${i + 1}',
            onPressed: () => onChanged!(i + 1),
            icon: Icon(
              i < rating.round() ? Icons.star : Icons.star_border,
              size: size,
              color: color,
            ),
          ),
      ],
    );
  }

  IconData _iconFor(int index) {
    if (rating >= index + 1) return Icons.star;
    if (rating >= index + 0.5) return Icons.star_half;
    return Icons.star_border;
  }
}