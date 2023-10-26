import 'package:parking_management_app/features/parking_mgmt/config/configurations.dart';
import 'package:parking_management_app/features/parking_mgmt/domain/entities/slot.dart';

abstract class SlotRepository {
  const SlotRepository();

  Future<Slot> getSlot(VehicleType type);

  Future<bool> releaseSlot();
}
