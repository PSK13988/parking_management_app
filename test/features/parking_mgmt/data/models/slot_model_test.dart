import 'package:parking_management_app/features/parking_mgmt/config/configurations.dart';
import 'package:parking_management_app/features/parking_mgmt/data/models/slot_model.dart';
import 'package:test/test.dart';

void main() {
  const type = VehicleType.small;
  const tSlotModel = SlotModel(
    slot: 'slot',
    floor: 'floor',
    bayId: 'bayId',
    type: type,
  );
  final tSlot = tSlotModel.toEntity();
  test('should create SlotModel and toEntity should get Slot object', () {
    const slotModel = SlotModel(
      slot: 'slot',
      floor: 'floor',
      bayId: 'bayId',
      type: type,
    );

    expect(slotModel, tSlotModel);
    expect(slotModel, isA<SlotModel>());
    expect(tSlot, slotModel.toEntity());
  });
  test('SlotModel object equality test', () {
    const slotModel = SlotModel(
      slot: 'slot',
      floor: 'floor',
      bayId: 'bayId',
      type: type,
    );
    const slotModel1 = SlotModel(
      slot: 'slot',
      floor: 'floor',
      bayId: 'bayId',
      type: type,
    );
    const slotModel2 = SlotModel(
      slot: 'slot2',
      floor: 'floor2',
      bayId: 'bayId2',
      type: type,
    );
    final result = slotModel == slotModel1;
    final result1 = slotModel1 == slotModel2;
    expect(result, true);
    expect(result1, false);
  });
}
