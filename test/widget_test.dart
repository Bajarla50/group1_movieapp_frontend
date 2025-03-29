import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:movieapp/screens/Login/login_screen.dart';

void main() {
  testWidgets('Login Screen UI test', (WidgetTester tester) async {
    // Build the LoginScreen widget
    await tester.pumpWidget(MaterialApp(home: LoginScreen()));

    // Verify the presence of login text
    expect(find.text('Log in to Your Account'), findsOneWidget);

    // Check if Email and Password fields are present
    expect(find.byType(TextField), findsNWidgets(2));

    // Check if buttons exist
    expect(find.text("Continue"), findsOneWidget);
    expect(find.text("Continue with Google"), findsOneWidget);
    expect(find.text("Continue with Facebook"), findsOneWidget);

    // Tap the Continue button (assuming it does something)
    await tester.tap(find.text("Continue"));
    await tester.pump();

    // Check if "Sign up" and "Forgot Password?" texts exist
    expect(find.text("Sign up"), findsOneWidget);
    expect(find.text("Forgot Password?"), findsOneWidget);
  });
}
