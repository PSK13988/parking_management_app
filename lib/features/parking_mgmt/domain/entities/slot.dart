import 'package:equatable/equatable.dart';
import 'package:parking_management_app/features/parking_mgmt/config/configurations.dart';

class Slot extends Equatable {
  const Slot({
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
}
