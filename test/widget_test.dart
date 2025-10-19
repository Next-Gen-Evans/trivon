import 'package:flutter_test/flutter_test.dart';
import 'package:trivon/main.dart';

void main() {
  testWidgets('Quiz app loads start screen and navigates to quiz page',
      (WidgetTester tester) async {
    // Build the QuizApp
    await tester.pumpWidget(const QuizApp());

    // Verify the welcome page text and button appear
    expect(find.text('Flutter & Dart'), findsOneWidget);
    expect(find.text('Quiz Challenge'), findsOneWidget);
    expect(find.text('Start Quiz'), findsOneWidget);

    // Tap the Start Quiz button
    await tester.tap(find.text('Start Quiz'));
    await tester.pumpAndSettle();

    // Verify navigation to Quiz Page by checking for Question text
    expect(find.textContaining('Question'), findsOneWidget);
  });
}
