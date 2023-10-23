import 'package:parking_management_app/core/usecase.dart';
import 'package:parking_management_app/features/parking_mgmt/domain/repositories/slot_repository.dart';

class ReleaseSlotUsecase extends UsecaseNoParams<void> {
  const ReleaseSlotUsecase(this._repository);

  final SlotRepository _repository;

  @override
  Future<void> call() async => await _repository.releaseSlot();
}
