import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

/// Renders prices consistently: ৳ symbol, Arabic numerals in every language.
class PriceText extends StatelessWidget {
  const PriceText({super.key, required this.price, this.unit, this.style});

  final double price;
  final String? unit;
  final TextStyle? style;

  static const String symbol = '৳';
  // Locale fixed to 'en' so numbers stay 0-9 even when the app is in Bangla.
  static final NumberFormat _format = NumberFormat('#,##0.##', 'en');

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final unitPart = (unit == null || unit!.isEmpty) ? '' : ' / $unit';

    return Text(
      '$symbol${_format.format(price)}$unitPart',
      maxLines: 1,
      overflow: TextOverflow.ellipsis,
      style: style ??
          theme.textTheme.titleMedium?.copyWith(
            color: theme.colorScheme.primary,
          ),
    );
  }
}