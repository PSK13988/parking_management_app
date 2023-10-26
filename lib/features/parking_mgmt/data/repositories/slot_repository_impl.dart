import 'package:parking_management_app/features/parking_mgmt/config/configurations.dart';
import 'package:parking_management_app/features/parking_mgmt/data/data_sources/remote_datasource.dart';
import 'package:parking_management_app/features/parking_mgmt/domain/entities/slot.dart';
import 'package:parking_management_app/features/parking_mgmt/domain/repositories/slot_repository.dart';

class SlotRepositoryImpl extends SlotRepository {
  const SlotRepositoryImpl(this._remoteDataSource);

  final RemoteDataSource _remoteDataSource;

  @override
  Future<Slot> getSlot(VehicleType type) async {
    final slotModel = await _remoteDataSource.getSlot(type);
    return slotModel.toEntity();
  }

  @override
  Future<bool> releaseSlot() => _remoteDataSource.releaseSlot();
}
