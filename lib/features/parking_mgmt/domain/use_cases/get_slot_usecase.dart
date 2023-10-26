import 'package:parking_management_app/core/usecase.dart';
import 'package:parking_management_app/features/parking_mgmt/config/configurations.dart';
import 'package:parking_management_app/features/parking_mgmt/domain/entities/slot.dart';
import 'package:parking_management_app/features/parking_mgmt/domain/repositories/slot_repository.dart';

class GetSlotUsecase extends UsecaseWithParam<Slot, VehicleType> {
  const GetSlotUsecase(this._repository);

  final SlotRepository _repository;

  @override
  Future<Slot> call(VehicleType type) async => await _repository.getSlot(type);
}
