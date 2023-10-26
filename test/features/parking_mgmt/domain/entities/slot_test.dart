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
  test('Slot object equality test', () {
    const slot = Slot(slot: 'slot', floor: 'floor', bayId: 'bayId', type: type);
    const slot1 =
        Slot(slot: 'slot', floor: 'floor', bayId: 'bayId', type: type);
    const slot2 = Slot(
      slot: 'slot2',
      floor: 'floor2',
      bayId: 'bayId2',
      type: VehicleType.xlarge,
    );
    final result = slot == slot1;
    final result1 = slot == slot2;
    expect(result, true);
    expect(result1, false);
  });
}
