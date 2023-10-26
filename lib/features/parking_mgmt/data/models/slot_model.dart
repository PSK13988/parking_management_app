import 'package:equatable/equatable.dart';
import 'package:parking_management_app/features/parking_mgmt/config/configurations.dart';
import 'package:parking_management_app/features/parking_mgmt/domain/entities/slot.dart';

class SlotModel extends Equatable {
  const SlotModel({
    required this.slot,
    required this.floor,
    required this.bayId,
    required this.type,
  });

  final String slot;
  final String floor;
  final String bayId;
  final VehicleType type;

  @override
  List<Object?> get props => [slot, floor, bayId, type];

  Slot toEntity() => Slot(
        slot: slot,
        floor: floor,
        bayId: bayId,
        type: type,
      );
}
