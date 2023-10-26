import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:parking_management_app/features/parking_mgmt/config/configurations.dart';
import 'package:parking_management_app/features/parking_mgmt/domain/entities/slot.dart';
import 'package:parking_management_app/features/parking_mgmt/domain/use_cases/get_slot_usecase.dart';
import 'package:parking_management_app/features/parking_mgmt/domain/use_cases/release_slot_usecase.dart';

part 'parking_state.dart';

class ParkingCubit extends Cubit<ParkingState> {
  ParkingCubit({
    required GetSlotUsecase getSlotUsecase,
    required ReleaseSlotUsecase releaseSlotUsecase,
  })  : _getSlotUsecase = getSlotUsecase,
        _releaseSlotUsecase = releaseSlotUsecase,
        super(ParkingInitial());

  final GetSlotUsecase _getSlotUsecase;
  final ReleaseSlotUsecase _releaseSlotUsecase;

  final occupiedSlot = <Slot>[];

  void startParking(VehicleType type) async {
    emit(ParkingInit());
    final slot = await _getSlotUsecase(type);
    await Future.delayed(const Duration(milliseconds: 500));
    occupiedSlot.add(slot);
    emit(ParkingOccupied(slot: slot));
  }

  void releaseParking(String slot) async {
    emit(ParkingInit());
    await _releaseSlotUsecase(slot);
    await Future.delayed(const Duration(milliseconds: 500));
    occupiedSlot.removeWhere((e) => e.slot == slot);
    emit(ParkingReleased());
    await Future.delayed(const Duration(milliseconds: 500));
    emit(ParkingInitial());
  }

  void releaseAll() async {
    emit(ParkingInit());
    await _releaseSlotUsecase(occupiedSlot.join(","));
    await Future.delayed(const Duration(milliseconds: 500));
    occupiedSlot.clear();
    emit(ParkingReleasedAll());
    await Future.delayed(const Duration(milliseconds: 500));
    emit(ParkingInitial());
  }
}
