import 'package:equatable/equatable.dart';
import 'package:parking_management_app/features/parking_mgmt/domain/entities/slot.dart';

class SlotModel extends Equatable {
  const SlotModel({required this.slot});

  final String slot;

  @override
  List<Object?> get props => [slot];

  SlotModel copyWith({
    String? slot,
  }) {
    return SlotModel(
      slot: slot ?? this.slot,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'slot': slot,
    };
  }

  factory SlotModel.fromMap(Map<String, dynamic> map) {
    return SlotModel(
      slot: map['slot'] as String,
    );
  }

  Slot toEntity() {
    var split = slot.contains('-') ? slot.split('-') : ['NA', 'NA'];
    return Slot(slot: slot, floor: split.first, bayId: split.last);
  }
}
