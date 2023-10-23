import 'package:mocktail/mocktail.dart';
import 'package:parking_management_app/features/parking_mgmt/domain/entities/slot.dart';
import 'package:parking_management_app/features/parking_mgmt/domain/repositories/slot_repository.dart';
import 'package:parking_management_app/features/parking_mgmt/domain/use_cases/get_slot_usecase.dart';
import 'package:test/test.dart';

import 'repository_mock.dart';

void main() {
  late SlotRepository repository;
  late GetSlotUsecase usecase;

  const tSlot = Slot(slot: 'slot', floor: 'floor', bayId: 'bayId');

  setUp(() {
    repository = MockSlotRepositoryImpl();
    usecase = GetSlotUsecase(repository);
  });

  group('GetSlotUsecase', () {
    test('should call GetSlotUseCase to return slot details when successful',
        () async {
      // Arrange
      when(() => repository.getSlot()).thenAnswer((_) async => tSlot);

      // Act
      final response = await usecase('');

      // Asset
      expect(response, isA<Slot>());
      expect(response, equals(tSlot));
      verify(() => repository.getSlot()).called(1);
      verifyNoMoreInteractions(repository);
    });
  });
}
