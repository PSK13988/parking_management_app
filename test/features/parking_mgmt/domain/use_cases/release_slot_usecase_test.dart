import 'package:mocktail/mocktail.dart';
import 'package:parking_management_app/features/parking_mgmt/domain/repositories/slot_repository.dart';
import 'package:parking_management_app/features/parking_mgmt/domain/use_cases/release_slot_usecase.dart';
import 'package:test/test.dart';

import 'repository_mock.dart';

void main() {
  late SlotRepository repository;
  late ReleaseSlotUsecase usecase;

  setUp(() {
    repository = MockSlotRepositoryImpl();
    usecase = ReleaseSlotUsecase(repository);
  });

  group('ReleaseSlotUsecase', () {
    test('should call ReleaseSlotUsecase, return nothing when successful',
        () async {
      // Arrange
      when(() => repository.releaseSlot()).thenAnswer((_) async => true);

      // Act
      await usecase('');

      // Asset
      verify(() => repository.releaseSlot()).called(1);
      verifyNoMoreInteractions(repository);
    });
  });
}
