// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility in the flutter_test package. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:ifl_example/main.dart';

void main() {
  testWidgets('KvStorage flow works in example app',
      (WidgetTester tester) async {
    await tester.pumpWidget(const MyApp());

    await tester.enterText(find.byKey(const Key('keyField')), 'token');
    await tester.enterText(find.byKey(const Key('valueField')), 'abc');
    await tester.tap(find.byKey(const Key('writeBtn')));
    await tester.pumpAndSettle();

    expect(find.text('Result: Saved'), findsOneWidget);

    await tester.tap(find.byKey(const Key('readBtn')));
    await tester.pumpAndSettle();
    expect(find.text('Result: abc'), findsOneWidget);

    await tester.tap(find.byKey(const Key('deleteBtn')));
    await tester.pumpAndSettle();
    expect(find.text('Result: Deleted'), findsOneWidget);

    await tester.tap(find.byKey(const Key('readBtn')));
    await tester.pumpAndSettle();
    expect(find.text('Result: Not found'), findsOneWidget);
  });
}
