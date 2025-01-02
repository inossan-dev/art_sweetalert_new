import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:art_sweetalert_new/art_sweetalert_new.dart';

void main() {
  group('SweetAlert Widget Tests', () {
    testWidgets('should display title and content correctly', (WidgetTester tester) async {
      const title = Text('Test Title');
      const content = Text('Test Content');

      await tester.pumpWidget(
        const MaterialApp(
          home: ArtSweetAlert(
            title: title,
            content: content,
          ),
        ),
      );

      expect(find.text('Test Title'), findsOneWidget);
      expect(find.text('Test Content'), findsOneWidget);
    });

    testWidgets('should display actions correctly', (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: ArtSweetAlert(
            title: const Text('Title'),
            actions: [
              ArtAlertButton(
                child: const Text('OK'),
                onPressed: () {},
              ),
              ArtAlertButton(
                child: const Text('Cancel'),
                onPressed: () {},
              ),
            ],
          ),
        ),
      );

      expect(find.text('OK'), findsOneWidget);
      expect(find.text('Cancel'), findsOneWidget);
      expect(find.byType(ArtAlertButton), findsNWidgets(2));
    });

    testWidgets('should display icon based on type', (WidgetTester tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: ArtSweetAlert(
            title: Text('Title'),
            type: ArtAlertType.success,
          ),
        ),
      );

      expect(find.byType(ArtAlertIcon), findsOneWidget);
    });

    testWidgets('should apply custom styling', (WidgetTester tester) async {
      const customColor = Color(0xFF123456);
      const customBorderRadius = 16.0;

      await tester.pumpWidget(
        const MaterialApp(
          home: ArtSweetAlert(
            title: Text('Title'),
            backgroundColor: customColor,
            borderRadius: customBorderRadius,
          ),
        ),
      );

      final dialog = find.byType(Dialog);
      expect(dialog, findsOneWidget);

      final container = tester.widget<Dialog>(dialog);
      expect(container.backgroundColor, equals(customColor));

      final shape = container.shape as RoundedRectangleBorder;
      expect(shape.borderRadius, equals(BorderRadius.circular(customBorderRadius)));
    });
  });

  group('AlertIcon Tests', () {
    testWidgets('should render different icon types correctly', (WidgetTester tester) async {
      for (var type in ArtAlertType.values) {
        await tester.pumpWidget(
          MaterialApp(
            home: ArtAlertIcon(
              type: type,
              size: 80,
            ),
          ),
        );

        expect(find.byType(ArtAlertIcon), findsOneWidget);
        await tester.pump(const Duration(milliseconds: 500)); // Allow animation to progress
      }
    });

    testWidgets('should apply custom size', (WidgetTester tester) async {
      const customSize = 120.0;

      await tester.pumpWidget(
        const MaterialApp(
          home: ArtAlertIcon(
            type: ArtAlertType.success,
            size: customSize,
          ),
        ),
      );

      final icon = find.byType(ArtAlertIcon);
      expect(icon, findsOneWidget);

      final container = tester.widget<ArtAlertIcon>(icon);
      expect(container.size, equals(customSize));
    });
  });

  group('AlertButton Tests', () {
    testWidgets('should handle tap events', (WidgetTester tester) async {
      bool wasTapped = false;

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: ArtAlertButton(
              onPressed: () {
                wasTapped = true;
              },
              child: const Text('Test Button'),
            ),
          ),
        ),
      );

      await tester.tap(find.text('Test Button'));
      expect(wasTapped, isTrue);
    });

    testWidgets('should apply custom styling', (WidgetTester tester) async {
      const customColor = Color(0xFF123456);
      const customTextColor = Color(0xFFFFFFFF);

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: ArtAlertButton(
              backgroundColor: customColor,
              textColor: customTextColor,
              child: const Text('Test Button'),
              onPressed: () {},
            ),
          ),
        ),
      );

      final button = find.byType(ElevatedButton);
      expect(button, findsOneWidget);

      final buttonWidget = tester.widget<ElevatedButton>(button);
      final buttonStyle = buttonWidget.style!;

      final backgroundColor = buttonStyle.backgroundColor?.resolve({});
      expect(backgroundColor, equals(customColor));

      final foregroundColor = buttonStyle.foregroundColor?.resolve({});
      expect(foregroundColor, equals(customTextColor));
    });
  });

  group('SweetAlert.show() Tests', () {
    testWidgets('should show and dismiss dialog correctly', (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Builder(
            builder: (BuildContext context) {
              return ElevatedButton(
                onPressed: () {
                  ArtSweetAlert.show(
                    context: context,
                    title: const Text('Test Dialog'),
                  );
                },
                child: const Text('Show Dialog'),
              );
            },
          ),
        ),
      );

      // Verify dialog is not shown initially
      expect(find.text('Test Dialog'), findsNothing);

      // Tap button to show dialog
      await tester.tap(find.text('Show Dialog'));
      await tester.pumpAndSettle();

      // Verify dialog is shown
      expect(find.text('Test Dialog'), findsOneWidget);

      // Tap outside to dismiss (if barrierDismissible is true)
      await tester.tapAt(const Offset(10, 10));
      await tester.pumpAndSettle();

      // Verify dialog is dismissed
      expect(find.text('Test Dialog'), findsNothing);
    });

    testWidgets('should handle animation duration correctly', (WidgetTester tester) async {
      const customDuration = Duration(milliseconds: 800);

      await tester.pumpWidget(
        MaterialApp(
          home: Builder(
            builder: (BuildContext context) {
              return ElevatedButton(
                onPressed: () {
                  ArtSweetAlert.show(
                    context: context,
                    title: const Text('Test Dialog'),
                    animationDuration: customDuration,
                  );
                },
                child: const Text('Show Dialog'),
              );
            },
          ),
        ),
      );

      await tester.tap(find.text('Show Dialog'));

      // Verify animation is in progress
      await tester.pump();
      expect(find.text('Test Dialog'), findsOneWidget);

      // Verify animation completes after duration
      await tester.pump(customDuration);
      expect(find.text('Test Dialog'), findsOneWidget);
    });
  });
}

// Helper function to create test widget
Widget createTestWidget(Widget child) {
  return MaterialApp(
    home: Scaffold(
      body: child,
    ),
  );
}