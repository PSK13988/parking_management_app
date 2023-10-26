import 'package:mocktail/mocktail.dart';
import 'package:parking_management_app/features/parking_mgmt/config/configurations.dart';
import 'package:parking_management_app/features/parking_mgmt/data/data_sources/remote_datasource.dart';
import 'package:parking_management_app/features/parking_mgmt/data/models/slot_model.dart';
import 'package:test/test.dart';

class MockRemoteDataSourceImpl extends Mock implements RemoteDataSource {}

void main() {
  late RemoteDataSource dataSource;

  const tSlotModel = SlotModel(
    slot: '{ Slot : <Floor>-<Bay-ID> }',
    floor: 'floor',
    bayId: 'bayId',
    type: VehicleType.small,
  );

  const type = VehicleType.small;
  setUp(() {
    dataSource = MockRemoteDataSourceImpl();
  });

  group('getSlot', () {
    test('should call [RemoteDataSource.getSlot]', () async {
      //Arrange
      when(() => dataSource.getSlot(type)).thenAnswer((_) async => tSlotModel);

      //Act
      final response = await dataSource.getSlot(type);

      // Asset
      expect(response, equals(tSlotModel));
      verify(() => dataSource.getSlot(type)).called(1);
      verifyNoMoreInteractions(dataSource);
    });
  });

  group('releaseSlot', () {
    test('should call [RemoteDataSource.releaseSlot]', () async {
      //Arrange
      when(() => dataSource.releaseSlot()).thenAnswer((_) async => true);

      //Act
      await dataSource.releaseSlot();

      // Asset
      verify(() => dataSource.releaseSlot()).called(1);
      verifyNoMoreInteractions(dataSource);
    });
  });
}
