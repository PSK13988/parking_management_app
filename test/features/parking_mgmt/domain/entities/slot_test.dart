import 'package:parking_management_app/features/parking_mgmt/config/configurations.dart';
import 'package:parking_management_app/features/parking_mgmt/domain/entities/slot.dart';
import 'package:test/test.dart';

void main() {
  const type = VehicleType.large;
  const tSlot = Slot(slot: 'slot', floor: 'floor', bayId: 'bayId', type: type);
  test('should create Slot object', () {
    const slot = Slot(slot: 'slot', floor: 'floor', bayId: 'bayId', type: type);
    expect(slot, equals(tSlot));
    expect(slot, isA<Slot>());
  });
}
