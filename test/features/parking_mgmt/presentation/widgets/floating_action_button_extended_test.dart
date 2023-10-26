import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:parking_management_app/features/parking_mgmt/presentation/widgets/floating_action_button_extended.dart';

import '../../../../test/root_widget.dart';

void main() {
  testWidgets(
      'FloatingActionButtonExtended smoke test, verification for initial state',
      (WidgetTester tester) async {
    await tester.pumpWidget(
      RootWidget(
        widget: FloatingActionButtonExtended(
          onPressed: () {},
          title: 'Add',
          icon: Icons.add,
        ),
      ),
    );
    await tester.pump();
    expect(find.text('Add'), findsOneWidget);
    expect(find.byIcon(Icons.add), findsOneWidget);
  });
}
