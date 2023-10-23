import 'package:parking_management_app/features/parking_mgmt/domain/entities/slot.dart';

abstract class SlotRepository {
  const SlotRepository();

  Future<Slot> getSlot();

  Future<void> releaseSlot();
}
