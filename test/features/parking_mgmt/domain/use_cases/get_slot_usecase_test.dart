import 'package:mocktail/mocktail.dart';
import 'package:parking_management_app/features/parking_mgmt/config/configurations.dart';
import 'package:parking_management_app/features/parking_mgmt/domain/entities/slot.dart';
import 'package:parking_management_app/features/parking_mgmt/domain/repositories/slot_repository.dart';
import 'package:parking_management_app/features/parking_mgmt/domain/use_cases/get_slot_usecase.dart';
import 'package:test/test.dart';

import 'repository_mock.dart';

void main() {
  late SlotRepository repository;
  late GetSlotUsecase usecase;

  const tSlot = Slot(
    slot: 'slot',
    floor: 'floor',
    bayId: 'bayId',
    type: VehicleType.small,
  );

  const type = VehicleType.small;

  setUp(() {
    repository = MockSlotRepositoryImpl();
    usecase = GetSlotUsecase(repository);
  });

  group('GetSlotUsecase', () {
    test('should call GetSlotUseCase to return slot details when successful',
        () async {
      // Arrange
      when(() => repository.getSlot(type)).thenAnswer((_) async => tSlot);

      // Act
      final response = await usecase(type);

      // Asset
      expect(response, isA<Slot>());
      expect(response, equals(tSlot));
      verify(() => repository.getSlot(type)).called(1);
      verifyNoMoreInteractions(repository);
    });
  });
}
