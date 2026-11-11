import 'dart:io';

import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:flutter/material.dart';

/// Shows a local file, a bundled asset, or a network image if it exists;
/// otherwise a placeholder. Never throws and never leaves a blank space.
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

  bool get _isAsset => (path ?? '').startsWith('assets/');
  bool get _isNetwork =>
      (path ?? '').startsWith('http://') || (path ?? '').startsWith('https://');

  bool get _hasLocalFile {
    final p = path;
    if (p == null || p.isEmpty) return false;
    if (kIsWeb) return true; // dart:io File is unavailable on web
    return File(p).existsSync();
  }

  @override
  Widget build(BuildContext context) {
    final p = path;
    if (p == null || p.isEmpty) return _placeholder(context);

    Widget errorBuilder(BuildContext c, Object e, StackTrace? s) =>
        _placeholder(c);

    if (_isAsset) {
      return Image.asset(p, fit: fit, errorBuilder: errorBuilder);
    }
    if (_isNetwork) {
      return Image.network(p, fit: fit, errorBuilder: errorBuilder);
    }
    if (!_hasLocalFile) return _placeholder(context);

    return kIsWeb
        ? Image.network(p, fit: fit, errorBuilder: errorBuilder)
        : Image.file(File(p), fit: fit, errorBuilder: errorBuilder);
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