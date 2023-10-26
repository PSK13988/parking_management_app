import 'package:mocktail/mocktail.dart';
import 'package:parking_management_app/features/parking_mgmt/config/configurations.dart';
import 'package:parking_management_app/features/parking_mgmt/data/data_sources/remote_datasource.dart';
import 'package:parking_management_app/features/parking_mgmt/data/models/slot_model.dart';
import 'package:parking_management_app/features/parking_mgmt/data/repositories/slot_repository_impl.dart';
import 'package:test/test.dart';

class MockRemoteDataSource extends Mock implements RemoteDataSource {}

void main() {
  late RemoteDataSource dataSource;
  late SlotRepositoryImpl repositoryImpl;
  const type = VehicleType.medium;
  const tSlotModel = SlotModel(
    slot: '{ Slot : <Floor>-<Bay-ID> }',
    floor: 'floor',
    bayId: 'bayId',
    type: VehicleType.small,
  );

  final tSlot = tSlotModel.toEntity();

  setUp(() {
    dataSource = MockRemoteDataSource();
    repositoryImpl = SlotRepositoryImpl(dataSource);
  });

  group('getSlot', () {
    test('should call [SlotRepositoryImpl.getSlot]', () async {
      //Arrange
      when(() => dataSource.getSlot(type)).thenAnswer((_) async => tSlotModel);

      //Act
      final response = await repositoryImpl.getSlot(type);

      // Asset
      expect(response, equals(tSlot));
      verify(() => dataSource.getSlot(type)).called(1);
      verifyNoMoreInteractions(dataSource);
    });
  });

  group('releaseSlot', () {
    test('should call [SlotRepositoryImpl.releaseSlot]', () async {
      //Arrange
      when(() => dataSource.releaseSlot()).thenAnswer((_) async => true);

      //Act
      await repositoryImpl.releaseSlot();

      // Asset
      verify(() => dataSource.releaseSlot()).called(1);
      verifyNoMoreInteractions(dataSource);
    });
  });
}
