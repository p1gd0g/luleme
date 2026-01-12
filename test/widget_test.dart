import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:luleme/main.dart';

void main() {
  testWidgets('App launches successfully', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(const MyApp());

    // Verify app title is displayed
    expect(find.text('撸了么'), findsOneWidget);
    
    // Verify the main action button exists
    expect(find.text('快速记录'), findsOneWidget);
  });
}
