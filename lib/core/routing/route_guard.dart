import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../models/enums.dart';
import '../../providers/auth_provider.dart';
import '../../screens/auth/login_screen.dart';

/// Route guard (Section 2 of the spec): even if a UI button were somehow
/// bypassed, a buyer can never land on a farmer-only screen and vice versa.
/// Wrap any role-restricted screen's route with RouteGuard.only(...).
class RouteGuard extends StatelessWidget {
  const RouteGuard.only({
    super.key,
    required this.role,
    required this.child,
  });

  final UserRole role;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    final user = context.watch<AuthProvider>().currentUser;

    if (user == null) return const LoginScreen();
    if (user.role != role) {
      return Scaffold(
        appBar: AppBar(),
        body: const Center(child: Text('Access denied for this role.')),
      );
    }
    return child;
  }
}