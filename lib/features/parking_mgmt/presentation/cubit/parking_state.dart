part of 'parking_cubit.dart';

abstract class ParkingState extends Equatable {
  const ParkingState();

  @override
  List<Object> get props => [];
}

class ParkingInitial extends ParkingState {} // Slot available to allocate

class ParkingInit extends ParkingState {} // Slot Allocating to Car

class ParkingOccupied extends ParkingState {
  const ParkingOccupied({
    required this.slot,
  });
  final Slot slot;
} // Slot occupied

class ParkingReleased extends ParkingState {} // Slot released

class ParkingReleasedAll extends ParkingState {} // Slot released
