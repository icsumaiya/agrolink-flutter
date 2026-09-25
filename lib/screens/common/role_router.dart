import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../core/routing/route_guard.dart';
import '../../models/enums.dart';
import '../../providers/auth_provider.dart';
import '../auth/login_screen.dart';
import '../buyer/buyer_shell.dart';
import '../farmer/farmer_shell.dart';

/// Single entry point after login. Reads the logged-in user's LOCKED role
/// and routes to the matching shell, each wrapped in RouteGuard.only(...).
class RoleRouter extends StatelessWidget {
  const RoleRouter({super.key});

  @override
  Widget build(BuildContext context) {
    final user = context.watch<AuthProvider>().currentUser;
    if (user == null) return const LoginScreen();

    return user.role == UserRole.farmer
        ? const RouteGuard.only(role: UserRole.farmer, child: FarmerShell())
        : const RouteGuard.only(role: UserRole.buyer, child: BuyerShell());
  }
}