import 'package:agrolink/core/routing/route_guard.dart';
import 'package:agrolink/models/enums.dart';
import 'package:agrolink/providers/auth_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:provider/provider.dart';

void main() {
  Widget wrap(Widget child, AuthProvider auth) => MaterialApp(
        home: ChangeNotifierProvider.value(value: auth, child: child),
      );

  testWidgets('Buyer cannot see farmer-only screen', (tester) async {
    final auth = AuthProvider()..login('buyer1@agrolink.demo', 'demo1234');
    await tester.pumpWidget(
      wrap(
        const RouteGuard.only(role: UserRole.farmer, child: Text('Farmer content')),
        auth,
      ),
    );
    expect(find.text('Farmer content'), findsNothing);
    expect(find.text('Access denied for this role.'), findsOneWidget);
  });

  testWidgets('Farmer cannot see buyer-only screen', (tester) async {
    final auth = AuthProvider()..login('farmer1@agrolink.demo', 'demo1234');
    await tester.pumpWidget(
      wrap(
        const RouteGuard.only(role: UserRole.buyer, child: Text('Buyer content')),
        auth,
      ),
    );
    expect(find.text('Buyer content'), findsNothing);
  });

  testWidgets('Matching role sees the screen', (tester) async {
    final auth = AuthProvider()..login('buyer1@agrolink.demo', 'demo1234');
    await tester.pumpWidget(
      wrap(
        const RouteGuard.only(role: UserRole.buyer, child: Text('Buyer content')),
        auth,
      ),
    );
    expect(find.text('Buyer content'), findsOneWidget);
  });
}