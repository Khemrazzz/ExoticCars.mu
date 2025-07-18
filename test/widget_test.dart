import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:exotic_cars_apk/core/widgets/input_field.dart';
import 'package:exotic_cars_apk/core/widgets/primary_button.dart';

void main() {
  testWidgets('InputField updates controller text', (tester) async {
    final controller = TextEditingController();
    await tester.pumpWidget(
      MaterialApp(
        home: Material(
          child: InputField(controller: controller, label: 'Email'),
        ),
      ),
    );

    await tester.enterText(find.byType(TextFormField), 'hello@example.com');
    expect(controller.text, 'hello@example.com');
    expect(find.text('Email'), findsOneWidget);
  });

  testWidgets('PrimaryButton shows progress indicator when loading',
      (tester) async {
    await tester.pumpWidget(
      const MaterialApp(
        home: Material(
          child: PrimaryButton(text: 'Submit', loading: true),
        ),
      ),
    );

    expect(find.byType(CircularProgressIndicator), findsOneWidget);
  });
}
