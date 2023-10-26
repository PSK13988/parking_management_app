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
  test('', () {
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
}
