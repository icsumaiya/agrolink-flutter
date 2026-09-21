import 'dart:io';

import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:flutter/material.dart';

/// Shows a local image if it exists; otherwise a placeholder.
/// Never throws and never leaves a blank space (missing/null/corrupt file).
/// Used for product images and profile pictures.
class SafeImage extends StatelessWidget {
  const SafeImage({
    super.key,
    this.path,
    this.fit = BoxFit.cover,
    this.placeholderIcon = Icons.image_outlined,
  });

  final String? path;
  final BoxFit fit;
  final IconData placeholderIcon;

  bool get _hasImage {
    final p = path;
    if (p == null || p.isEmpty) return false;
    if (kIsWeb) return true; // dart:io File is unavailable on web
    return File(p).existsSync();
  }

  @override
  Widget build(BuildContext context) {
    if (!_hasImage) return _placeholder(context);

    Widget errorBuilder(BuildContext c, Object e, StackTrace? s) =>
        _placeholder(c);

    return kIsWeb
        ? Image.network(path!, fit: fit, errorBuilder: errorBuilder)
        : Image.file(File(path!), fit: fit, errorBuilder: errorBuilder);
  }

  Widget _placeholder(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    return ColoredBox(
      color: scheme.surfaceContainerHighest,
      child: Center(
        child: Icon(placeholderIcon, size: 40, color: scheme.onSurfaceVariant),
      ),
    );
  }
}