import 'package:flutter/material.dart';

import '../../l10n/app_localizations.dart';
import '../common/coming_soon_screen.dart';
import '../common/settings_screen.dart';

/// Farmer-only bottom navigation. Section 2: a farmer never sees buyer tabs.
class FarmerShell extends StatefulWidget {
  const FarmerShell({super.key});

  @override
  State<FarmerShell> createState() => _FarmerShellState();
}

class _FarmerShellState extends State<FarmerShell> {
  int _index = 0;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);

    final pages = [
      const ComingSoonScreen(label: 'Dashboard', icon: Icons.dashboard_outlined), // Step 9
      const ComingSoonScreen(label: 'My Products', icon: Icons.inventory_2_outlined), // Step 9
      const ComingSoonScreen(label: 'Incoming Orders', icon: Icons.list_alt_outlined), // Step 9
      const SettingsScreen(),
    ];

    return Scaffold(
      body: IndexedStack(index: _index, children: pages),
      bottomNavigationBar: NavigationBar(
        selectedIndex: _index,
        onDestinationSelected: (i) => setState(() => _index = i),
        destinations: [
          const NavigationDestination(
            icon: Icon(Icons.dashboard_outlined),
            selectedIcon: Icon(Icons.dashboard),
            label: 'Dashboard',
          ),
          const NavigationDestination(
            icon: Icon(Icons.inventory_2_outlined),
            selectedIcon: Icon(Icons.inventory_2),
            label: 'Products',
          ),
          const NavigationDestination(
            icon: Icon(Icons.list_alt_outlined),
            selectedIcon: Icon(Icons.list_alt),
            label: 'Orders',
          ),
          NavigationDestination(
            icon: const Icon(Icons.settings_outlined),
            selectedIcon: const Icon(Icons.settings),
            label: l10n.settings,
          ),
        ],
      ),
    );
  }
}