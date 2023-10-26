import 'package:parking_management_app/core/usecase.dart';
import 'package:parking_management_app/features/parking_mgmt/domain/repositories/slot_repository.dart';

class ReleaseSlotUsecase extends UsecaseWithParam<bool, String> {
  const ReleaseSlotUsecase(this._repository);

  final SlotRepository _repository;

  @override
  // Assuming can send one or multiple slots ids to release them
  Future<bool> call(String id) async => await _repository.releaseSlot();
}
