// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility in the flutter_test package. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:frontend/pages/HomePage.dart';

void main() {
  testWidgets('Application generation test', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(HomePage());
    var stack = find.byType(Stack);
    expect(stack, findsAtLeastNWidgets(1));
    var scaffold = find.byType(Scaffold);
    expect(scaffold, findsOneWidget);
  });
  testWidgets('Map generation', (WidgetTester tester) async {
    await tester.pumpWidget(HomePage());
    var map = find.byType(Center);
    expect(map, findsAtLeastNWidgets(1));
  });
  testWidgets('Information Box generation', (WidgetTester tester) async {
    await tester.pumpWidget(HomePage());
    var informationBox = find.byType(AnimatedPositioned);
    expect(informationBox, findsOneWidget);
  });
}
