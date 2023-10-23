import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
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

  void startParking() async {
    emit(ParkingInit());
    final slot = await _getSlotUsecase('');
    await Future.delayed(const Duration(milliseconds: 500));
    emit(ParkingOccupied(slot: slot));
  }

  void releaseParking() async {
    emit(ParkingInit());
    await _releaseSlotUsecase();
    await Future.delayed(const Duration(milliseconds: 500));
    emit(ParkingReleased());
    await Future.delayed(const Duration(milliseconds: 500));
    emit(ParkingInitial());
  }
}
