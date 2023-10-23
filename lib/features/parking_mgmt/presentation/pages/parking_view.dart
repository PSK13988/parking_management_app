import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:parking_management_app/features/parking_mgmt/presentation/cubit/parking_cubit.dart';
import 'package:parking_management_app/features/parking_mgmt/presentation/widgets/floating_action_button_extended.dart';
import 'package:parking_management_app/features/parking_mgmt/presentation/widgets/text_widget.dart';

class ParkingView extends StatelessWidget {
  const ParkingView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Parking app'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Center(
          child: BlocBuilder<ParkingCubit, ParkingState>(
            builder: (context, state) {
              if (state is ParkingOccupied) {
                return Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const TextWidget('Parking slot available'),
                    TextWidget(
                      'Floor Number: ${state.slot.floor} and '
                      'bay area: ${state.slot.bayId}',
                      color: Colors.blue,
                    ),
                  ],
                );
              }
              if (state is ParkingReleased) {
                return const TextWidget(
                  'Parking Released',
                );
              }
              return const TextWidget(
                'Please tap to get the parking slot',
              );
            },
          ),
        ),
      ),
      floatingActionButton: BlocBuilder<ParkingCubit, ParkingState>(
        builder: (context, state) {
          if (state is! ParkingOccupied) {
            return FloatingActionButtonExtended(
              onPressed: () => context.read<ParkingCubit>().startParking(),
              title: 'Get Parking Slot',
              icon: Icons.add,
            );
          }
          return FloatingActionButtonExtended(
            onPressed: () => context.read<ParkingCubit>().releaseParking(),
            title: 'Release Slot',
            icon: Icons.remove,
          );
        },
      ),
    );
  }
}
