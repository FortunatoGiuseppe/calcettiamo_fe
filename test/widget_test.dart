// Un test di base per verificare che la LoginPage sia costruita correttamente.

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_application_1/main.dart';
import 'package:flutter_application_1/login.dart';

void main() {
  testWidgets('LoginPage build and elements test', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(const MyApp());

    // Verifica che la LoginPage sia visualizzata.
    expect(find.byType(LoginPage), findsOneWidget);

    // Verifica la presenza dei campi di testo per email e password.
    expect(find.widgetWithText(TextField, 'Email'), findsOneWidget);
    expect(find.widgetWithText(TextField, 'Password'), findsOneWidget);

    // Verifica la presenza del pulsante di accesso.
    expect(find.widgetWithText(ElevatedButton, 'Accedi'), findsOneWidget);

    // Verifica la presenza del pulsante di registrazione.
    expect(find.widgetWithText(TextButton, 'Non hai un account? Registrati'), findsOneWidget);
  });
}