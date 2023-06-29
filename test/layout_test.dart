import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:platform_layout/layout.dart';

void main() {
  testWidgets('Test layout calculations', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(MaterialApp(
      home: LayoutPlatform(child: Container()),
    ));
  });
}
