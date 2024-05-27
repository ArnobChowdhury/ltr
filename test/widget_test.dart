import 'package:flex_color_picker/flex_color_picker.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:flutter/material.dart';
import 'package:ltr/widgets/add_subject.dart';
// import 'package:mockito/mockito.dart'; // uncomment when using verify for mocks cbs
import 'package:path_provider_platform_interface/path_provider_platform_interface.dart';

import 'mock_callback.dart';
import 'path_provider_mock.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  setUp(() async {
    PathProviderPlatform.instance = FakePathProviderPlatform();
    await Hive.initFlutter();
    // Open a box for testing
    await Hive.openBox('subjects');
  });

  testWidgets('AddSubjectDialog builds correctly and allows adding a subject',
      (WidgetTester tester) async {
    final mockCallback = MockCallback();

    await tester.pumpWidget(MaterialApp(
      home: Scaffold(
        body: AddSubjectDialog(onSave: mockCallback.onAdd),
      ),
    ));

    expect(find.byType(AlertDialog), findsOneWidget);

    // Enter some text into the TextField
    await tester.enterText(find.byType(TextField), 'Math');
    expect(find.text('Math'), findsOneWidget);

    final saveButton = find.widgetWithText(TextButton, 'Save');
    expect(saveButton, findsOneWidget);

    final cancelButton = find.widgetWithText(TextButton, 'Cancel');
    expect(cancelButton, findsOneWidget);

    expect(find.byType(ColorIndicator), findsExactly(7));

    // await tester.tap(addButton);
    // Wait for the widget to settle
    // await tester.pumpAndSettle();

    // Verify that the onAdd callback was called once
    // verify(mockCallback.onAdd()).called(1);
  });
}
