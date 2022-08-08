import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:flutter_driver/driver_extension.dart';
import 'package:integration_test/integration_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:vault_inmobia/models/login_response_model.dart';
import 'package:vault_inmobia/services/api.dart';
import 'package:vault_inmobia/pages/login.dart';
import 'package:mockito/mockito.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/widgets.dart';

class MockClient extends Mock implements http.Client {}

//2 widget tests
//2 unit tests
//2 integration tests
void main() async {
  enableFlutterDriverExtension();
  final MockClient client = MockClient();


//Initialize page objects

  group('Vault  Tests', () {
    final binding = IntegrationTestWidgetsFlutterBinding.ensureInitialized()
    as IntegrationTestWidgetsFlutterBinding;
    var ensureInitialized = WidgetsFlutterBinding.ensureInitialized();
 //widget tests +unit tests
    testWidgets("Flutter Integration, Unit , Widget Tests",  (WidgetTester tester) async {
      await tester.pumpWidget(LoginPage());
      var textField = find.byType(TextField);
      expect(textField, findsOneWidget);
      await tester.enterText(textField, 'a@b.com');
      expect(find.text('a@b.com'), findsOneWidget);
      print('Text field test okay');

      var button = find.text("Login");
      expect(button,findsOneWidget);
      print('Found Login Button');

      await tester.tap(button);
      await tester.pump();
      expect(find.text("a@b.com"),findsOneWidget);
      print('Found Text after pressing Login button');

    });

//integrration tests
    group('User details Tests', () {
      test('returns a user profile', () async {
        final client = MockClient(); //no need for this now
        when(APIService.getUserProfile())
            .thenAnswer((_) async => await APIService.getUserProfile());
//"/4100333445674567",'{"amount": "300","expiry": "2028-06-30","number": "4100333445674567","username": "Mureri","transactions": []}'

        expect(await APIService.getUserProfile(), loginResponseJson(APIService.getUserProfile().toString()));
      });

      test('throws an exception if API call was unsuccessful', () {
        final client = MockClient();

        when(APIService.getUserProfile())
            .thenAnswer((_) async => await APIService.getUserProfile());

        expect(APIService.getUserProfile(), throwsException);
      });
    });

  });
}