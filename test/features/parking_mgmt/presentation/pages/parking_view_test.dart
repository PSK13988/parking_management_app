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
            ]),
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

  testWidgets('$parkingViewTitle smoke test, get slot for all type cars',
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

  testWidgets(
      '$parkingViewTitle smoke test, clear all occupied slots on tap '
      'of clear icon', (WidgetTester tester) async {
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
            ]),
          child: const ParkingView(),
        ),
      ),
    );
    await tester.pump();
    await tester.tap(find.byIcon(Icons.clear_all));
    await tester.pumpAndSettle(const Duration(seconds: 1));
    expect(find.byType(ListTile), findsNothing);
    expect(find.image(const AssetImage(Assets.small)), findsNothing);
    expect(find.image(const AssetImage(Assets.large)), findsNothing);
    expect(find.byIcon(Icons.delete_outline), findsNothing);
    expect(find.text(tapToGetParkingSlots), findsOneWidget);
  });

  testWidgets(
      '$parkingViewTitle smoke test, release specific slot'
      'of clear icon', (WidgetTester tester) async {
    const key = 'slot1';

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
                slot: key,
                floor: '3',
                bayId: '1000',
                type: VehicleType.large,
              ),
            ]),
          child: const ParkingView(),
        ),
      ),
    );
    await tester.pump();
    await tester.tap(find.byKey(const Key(key)));
    await tester.pumpAndSettle(const Duration(seconds: 1));
    expect(find.byType(ListTile), findsOneWidget);
    expect(find.image(const AssetImage(Assets.small)), findsOneWidget);
    expect(find.image(const AssetImage(Assets.large)), findsNothing);
    expect(find.byIcon(Icons.delete_outline), findsOneWidget);
    expect(find.text(tapToGetParkingSlots), findsNothing);
  });

  testWidgets('$parkingViewTitle smoke test, tap on floating Action button',
      (WidgetTester tester) async {
    const key = 'btnGetSlot';
    const dialogGetSlot = 'dialogGetSlot';

    await tester.pumpWidget(
      RootWidget(
        widget: BlocProvider(
          create: (context) => sl<ParkingCubit>(),
          child: const ParkingView(),
        ),
      ),
    );
    await tester.pump();
    await tester.tap(find.byKey(const Key(key)));
    await tester.pumpAndSettle(const Duration(seconds: 1));
    expect(find.text('CANCEL'), findsOneWidget);
    expect(find.text('GET SLOT'), findsNWidgets(2));
    await tester.tap(find.byKey(const Key(dialogGetSlot)));
    await tester.pumpAndSettle(const Duration(seconds: 1));
    expect(find.byType(ListTile), findsOneWidget);
    expect(find.image(const AssetImage(Assets.small)), findsOneWidget);
    expect(find.byIcon(Icons.delete_outline), findsOneWidget);
    await tester.tap(find.byIcon(Icons.delete_outline));
    await tester.pumpAndSettle(const Duration(seconds: 1));
    expect(find.text(tapToGetParkingSlots), findsOneWidget);
  });

  testWidgets('$parkingViewTitle smoke test, tap on dialog cancel button',
      (WidgetTester tester) async {
    const key = 'btnGetSlot';
    const dialogCancel = 'dialogCancel';

    await tester.pumpWidget(
      RootWidget(
        widget: BlocProvider(
          create: (context) => sl<ParkingCubit>(),
          child: const ParkingView(),
        ),
      ),
    );
    await tester.pump();
    await tester.tap(find.byKey(const Key(key)));
    await tester.pumpAndSettle(const Duration(seconds: 1));
    expect(find.text('CANCEL'), findsOneWidget);
    expect(find.text('GET SLOT'), findsNWidgets(2));
    await tester.tap(find.byKey(const Key(dialogCancel)));
    await tester.pumpAndSettle(const Duration(seconds: 1));
    expect(find.text(tapToGetParkingSlots), findsOneWidget);
  });

  testWidgets(
      '$parkingViewTitle smoke test, Change vehicle type to any other XLARGE '
      'type', (WidgetTester tester) async {
    const key = 'btnGetSlot';
    const dialogGetSlot = 'dialogGetSlot';

    await tester.pumpWidget(
      RootWidget(
        widget: BlocProvider(
          create: (context) => sl<ParkingCubit>(),
          child: const ParkingView(),
        ),
      ),
    );
    await tester.pump();
    await tester.tap(find.byKey(const Key(key)));
    await tester.pumpAndSettle(const Duration(seconds: 1));
    expect(find.text('CANCEL'), findsOneWidget);
    expect(find.text('GET SLOT'), findsNWidgets(2));
    expect(find.text(findSlot), findsOneWidget);
    expect(find.text(vehicleType), findsOneWidget);
    expect(find.text(VehicleType.small.name.toUpperCase()), findsNWidgets(2));
    expect(find.text(VehicleType.large.name.toUpperCase()), findsOneWidget);
    expect(find.text(VehicleType.medium.name.toUpperCase()), findsOneWidget);
    expect(find.text(VehicleType.xlarge.name.toUpperCase()), findsOneWidget);

    await tester.tap(find.byIcon(Icons.arrow_drop_down).first);
    await tester.pump();
    await tester.tap(find.text('XLARGE').last);
    await tester.pumpAndSettle();
    expect(find.text(VehicleType.small.name.toUpperCase()), findsOneWidget);
    expect(find.text(VehicleType.large.name.toUpperCase()), findsOneWidget);
    expect(find.text(VehicleType.medium.name.toUpperCase()), findsOneWidget);
    expect(find.text(VehicleType.xlarge.name.toUpperCase()), findsNWidgets(2));

    await tester.tap(find.byIcon(Icons.arrow_drop_down).first);
    await tester.pump();
    await tester.tap(find.text('LARGE').last);
    await tester.pumpAndSettle();
    expect(find.text(VehicleType.small.name.toUpperCase()), findsOneWidget);
    expect(find.text(VehicleType.xlarge.name.toUpperCase()), findsOneWidget);
    expect(find.text(VehicleType.medium.name.toUpperCase()), findsOneWidget);
    expect(find.text(VehicleType.large.name.toUpperCase()), findsNWidgets(2));

    await tester.tap(find.byIcon(Icons.arrow_drop_down).first);
    await tester.pump();
    await tester.tap(find.text('SMALL').last);
    await tester.pumpAndSettle();
    expect(find.text(VehicleType.medium.name.toUpperCase()), findsOneWidget);
    expect(find.text(VehicleType.xlarge.name.toUpperCase()), findsOneWidget);
    expect(find.text(VehicleType.large.name.toUpperCase()), findsOneWidget);
    expect(find.text(VehicleType.small.name.toUpperCase()), findsNWidgets(2));

    await tester.tap(find.byIcon(Icons.arrow_drop_down).first);
    await tester.pump();
    await tester.tap(find.text('MEDIUM').last);
    await tester.pumpAndSettle();
    expect(find.text(VehicleType.small.name.toUpperCase()), findsOneWidget);
    expect(find.text(VehicleType.xlarge.name.toUpperCase()), findsOneWidget);
    expect(find.text(VehicleType.large.name.toUpperCase()), findsOneWidget);
    expect(find.text(VehicleType.medium.name.toUpperCase()), findsNWidgets(2));

    await tester.tap(find.byKey(const Key(dialogGetSlot)));
    await tester.pumpAndSettle(const Duration(seconds: 1));

    expect(find.image(const AssetImage(Assets.medium)), findsOneWidget);

    expect(find.byType(ListTile), findsNWidgets(1));
    expect(find.byIcon(Icons.delete_outline), findsNWidgets(1));
  });
}
