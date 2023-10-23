import 'package:parking_management_app/core/usecase.dart';
import 'package:parking_management_app/features/parking_mgmt/domain/entities/slot.dart';
import 'package:parking_management_app/features/parking_mgmt/domain/repositories/slot_repository.dart';

class GetSlotUsecase extends UsecaseWithParam<Slot, void> {
  const GetSlotUsecase(this._repository);

  final SlotRepository _repository;

  @override
  Future<Slot> call(void params) async => await _repository.getSlot();
}
