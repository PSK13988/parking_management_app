import 'package:equatable/equatable.dart';

class Slot extends Equatable {
  const Slot({
    required this.slot,
    required this.floor,
    required this.bayId,
  });

  final String slot;
  final String floor;
  final String bayId;

  @override
  List<Object?> get props => [slot, floor, bayId];
}
