import 'package:flutter/foundation.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:ifl_example/main.dart';

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  testWidgets('example app write/read flow', (WidgetTester tester) async {
    await tester.pumpWidget(const MyApp());

    await tester.enterText(find.byKey(const Key('keyField')), 'k1');
    await tester.enterText(find.byKey(const Key('valueField')), 'v1');
    await tester.tap(find.byKey(const Key('writeBtn')));
    await tester.pumpAndSettle();
    expect(find.text('Result: Saved'), findsOneWidget);

    await tester.tap(find.byKey(const Key('readBtn')));
    await tester.pumpAndSettle();
    expect(find.text('Result: v1'), findsOneWidget);
  });
}
