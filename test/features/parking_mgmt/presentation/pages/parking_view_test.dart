import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:parking_management_app/core/assets.dart';
import 'package:parking_management_app/features/parking_mgmt/config/configurations.dart';
import 'package:parking_management_app/features/parking_mgmt/config/strings.dart';
import 'package:parking_management_app/features/parking_mgmt/domain/entities/slot.dart';
import 'package:parking_management_app/features/parking_mgmt/presentation/cubit/parking_cubit.dart';
import 'package:parking_management_app/features/parking_mgmt/presentation/pages/parking_view.dart';
import 'package:parking_management_app/injection_container.dart';

import '../../../../test/root_widget.dart';

void main() async {
  await init();
  testWidgets('$parkingViewTitle smoke test, verification for initial state',
      (WidgetTester tester) async {
    await tester.pumpWidget(
      RootWidget(
        widget: BlocProvider(
          create: (context) => sl<ParkingCubit>(),
          child: const ParkingView(),
        ),
      ),
    );
    await tester.pump();
    expect(find.text(tapToGetParkingSlots), findsOneWidget);
    expect(find.text(btnGetSlot), findsOneWidget);
    expect(find.byIcon(Icons.add), findsOneWidget);
  });

  testWidgets('$parkingViewTitle smoke test, when tap on floatingActionButton',
      (WidgetTester tester) async {
    await tester.pumpWidget(
      RootWidget(
        widget: BlocProvider(
          create: (context) => sl<ParkingCubit>(),
          child: const ParkingView(),
        ),
      ),
    );
    await tester.pump();
    await tester.tap(find.text(btnGetSlot));
    await tester.pumpAndSettle(const Duration(seconds: 1));
    expect(find.text(findSlot), findsOneWidget);
    expect(find.text(btnCancel), findsOneWidget);
    expect(find.text(btnGetSlot), findsNWidgets(2));
  });

  testWidgets('$parkingViewTitle smoke test, get slot for small car',
      (WidgetTester tester) async {
    await tester.pumpWidget(
      RootWidget(
        widget: BlocProvider(
          create: (context) => sl<ParkingCubit>()
            ..occupiedSlot.add(
              const Slot(
                slot: 'slot',
                floor: '2',
                bayId: '100',
                type: VehicleType.small,
              ),
            )
            ..occupiedSlot.add(
              const Slot(
                slot: 'slot1',
                floor: '3',
                bayId: '1000',
                type: VehicleType.large,
              ),
            ),
          child: const ParkingView(),
        ),
      ),
    );
    await tester.pump();
    await tester.tap(find.text(btnGetSlot));
    await tester.pumpAndSettle(const Duration(seconds: 1));
    expect(find.byType(ListTile), findsNWidgets(2));
    expect(find.image(const AssetImage(Assets.small)), findsOneWidget);
    expect(find.image(const AssetImage(Assets.large)), findsOneWidget);
    expect(find.byIcon(Icons.delete_outline), findsNWidgets(2));
  });
  testWidgets('$parkingViewTitle smoke test, get slot for small car',
      (WidgetTester tester) async {
    await tester.pumpWidget(
      RootWidget(
        widget: BlocProvider(
          create: (context) => sl<ParkingCubit>()
            ..occupiedSlot.addAll([
              const Slot(
                slot: 'slot',
                floor: '2',
                bayId: '100',
                type: VehicleType.small,
              ),
              const Slot(
                slot: 'slot1',
                floor: '3',
                bayId: '1000',
                type: VehicleType.large,
              ),
              const Slot(
                slot: 'slot2',
                floor: '1',
                bayId: '1100',
                type: VehicleType.medium,
              ),
              const Slot(
                slot: 'slot3',
                floor: '2',
                bayId: '1110',
                type: VehicleType.xlarge,
              ),
            ]),
          child: const ParkingView(),
        ),
      ),
    );
    await tester.pump();
    await tester.tap(find.text(btnGetSlot));
    await tester.pumpAndSettle(const Duration(seconds: 1));
    expect(find.byType(ListTile), findsNWidgets(4));
    expect(find.image(const AssetImage(Assets.small)), findsOneWidget);
    expect(find.image(const AssetImage(Assets.large)), findsOneWidget);
    expect(find.byIcon(Icons.delete_outline), findsNWidgets(4));
  });
}
