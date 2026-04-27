import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hostel_app/main.dart';

void main() {
  testWidgets('Smoke test - FlutterApp builds', (WidgetTester tester) async {
    // Build our app
    await tester.pumpWidget(const FlutterApp());

    // Wait for UI to settle
    await tester.pumpAndSettle();

    // Verify that AppBar title exists
    expect(find.text('HostelMart'), findsOneWidget);

    // Verify bottom navigation bar exists
    expect(find.byType(BottomNavigationBar), findsOneWidget);

    // Verify Sell & Request buttons exist
    expect(find.text('+ Sell Item'), findsOneWidget);
    expect(find.text('Request Item'), findsOneWidget);
  });
}
