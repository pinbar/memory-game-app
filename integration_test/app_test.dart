import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';

import 'package:memory_game/main.dart' as app;

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  group('end to end test', () {
    testWidgets('app loads', (tester) async {
      app.main();
      await tester.pumpAndSettle();
      expect(find.text('Letter Match Memory Game'), findsOneWidget);
    });

    testWidgets('instructions loads and speaker works', (tester) async {
      app.main();
      await tester.pumpAndSettle();

      // Tap the 'i' icon and trigger a frame.
      await tester.tap(find.byIcon(Icons.info));
      await tester.pumpAndSettle();

      // Verify that the instructions widget has loaded and the instruction title is shown
      expect(find.text('Instructions'), findsOneWidget);

      // Tap the 'speaker' icon and trigger a frame.
      await tester.tap(find.byIcon(Icons.volume_down));
      await tester.pumpAndSettle(const Duration(seconds: 2));
      // sleep(const Duration(seconds: 2));      
      await tester.tapAt(const Offset(5, 5));
      // sleep(const Duration(seconds: 5));
    });

    testWidgets('tap a tile', (tester) async {
      app.main();
      await tester.pumpAndSettle();
      
      // make sure 6 tiles are loaded
      expect(find.byKey(const Key('wordTile')), findsNWidgets(6), reason: 'found 6 tiles');
      expect(find.byIcon(Icons.question_mark), findsNWidgets(6), reason: 'found 6 ?s');

      // Tap the first ? and trigger a frame.
      await tester.tap(find.byIcon(Icons.question_mark).first);
      await tester.pumpAndSettle();
      // make sure 5 ? are remaining
      expect(find.byIcon(Icons.question_mark), findsNWidgets(5), reason: 'found 5 ?s');
      await tester.tap(find.byKey(const Key('wordTile')).first);
      await tester.pumpAndSettle();
      // make sure 6 ? are showing now
      expect(find.byIcon(Icons.question_mark), findsNWidgets(6), reason: 'found 6 ?s');

      await tester.tap(find.byIcon(Icons.question_mark).first);
      await tester.pumpAndSettle();
      await tester.tap(find.byIcon(Icons.question_mark).last);
      await tester.pumpAndSettle();
    });
  });
}
