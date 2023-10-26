import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:parking_management_app/features/parking_mgmt/presentation/widgets/text_widget.dart';

import '../../../../test/root_widget.dart';

void main() {
  testWidgets('TextWidget smoke test, verification for initial state',
      (WidgetTester tester) async {
    await tester.pumpWidget(
      const RootWidget(
          widget: TextWidget(
        'Sample',
      )),
    );
    await tester.pump();
    expect(find.text('Sample'), findsOneWidget);
  });
}
