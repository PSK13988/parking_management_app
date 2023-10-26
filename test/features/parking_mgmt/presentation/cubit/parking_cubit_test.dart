import 'package:bloc_test/bloc_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:parking_management_app/features/parking_mgmt/config/configurations.dart';
import 'package:parking_management_app/features/parking_mgmt/domain/entities/slot.dart';
import 'package:parking_management_app/features/parking_mgmt/domain/use_cases/get_slot_usecase.dart';
import 'package:parking_management_app/features/parking_mgmt/domain/use_cases/release_slot_usecase.dart';
import 'package:parking_management_app/features/parking_mgmt/presentation/cubit/parking_cubit.dart';
import 'package:test/test.dart';

class MockGetSlotUsecase extends Mock implements GetSlotUsecase {}

class MockReleaseSlotUsecase extends Mock implements ReleaseSlotUsecase {}

void main() {
  late GetSlotUsecase getSlotUsecase;
  late ReleaseSlotUsecase releaseSlotUsecase;
  late ParkingCubit cubit;

  const tSlot = Slot(
    slot: 'slot',
    floor: 'floor',
    bayId: 'bayId',
    type: VehicleType.small,
  );

  const type = VehicleType.small;

  setUp(() {
    getSlotUsecase = MockGetSlotUsecase();
    releaseSlotUsecase = MockReleaseSlotUsecase();
    cubit = ParkingCubit(
      getSlotUsecase: getSlotUsecase,
      releaseSlotUsecase: releaseSlotUsecase,
    );
  });

  group('startParking', () {
    blocTest<ParkingCubit, ParkingState>(
      'should emit [ParkingInit, ParkingOccupied] when successful',
      build: () {
        when(() => getSlotUsecase(type)).thenAnswer((_) async => tSlot);
        return cubit;
      },
      act: (cubit) => cubit.startParking(type),
      expect: () => [ParkingInit(), const ParkingOccupied(slot: tSlot)],
      verify: (_) {
        verify(() => getSlotUsecase(type)).called(1);
        verifyNoMoreInteractions(getSlotUsecase);
      },
    );
  });

  group('releaseParking', () {
    blocTest<ParkingCubit, ParkingState>(
      'should emit [ParkingInit, ParkingOccupied] when successful',
      build: () {
        when(() => releaseSlotUsecase('')).thenAnswer((_) async => true);
        return cubit;
      },
      act: (cubit) => cubit.releaseParking(''),
      expect: () => [ParkingInit(), ParkingReleased(), ParkingInitial()],
      verify: (_) {
        verify(() => releaseSlotUsecase('')).called(1);
        verifyNoMoreInteractions(releaseSlotUsecase);
      },
    );
  });

  group('releaseAll', () {
    blocTest<ParkingCubit, ParkingState>(
      'should emit [ParkingInit, ParkingOccupied] when successful',
      build: () {
        when(() => releaseSlotUsecase('')).thenAnswer((_) async => true);
        return cubit;
      },
      act: (cubit) => cubit.releaseAll(),
      expect: () => [ParkingInit(), ParkingReleasedAll(), ParkingInitial()],
      verify: (_) {
        verify(() => releaseSlotUsecase('')).called(1);
        verifyNoMoreInteractions(releaseSlotUsecase);
      },
    );
  });
}
