import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:parking_management_app/core/assets.dart';
import 'package:parking_management_app/features/parking_mgmt/config/configurations.dart';
import 'package:parking_management_app/features/parking_mgmt/presentation/cubit/parking_cubit.dart';
import 'package:parking_management_app/features/parking_mgmt/presentation/widgets/floating_action_button_extended.dart';
import 'package:parking_management_app/features/parking_mgmt/presentation/widgets/text_widget.dart';
import 'package:parking_management_app/features/parking_mgmt/presentation/widgets/vehicle_type_dropdown.dart';

import '../../config/strings.dart';

class ParkingView extends StatelessWidget {
  const ParkingView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(parkingViewTitle),
        actions: [
          IconButton(
            onPressed: () => context.read<ParkingCubit>().releaseAll(),
            icon: const Icon(Icons.clear_all),
          )
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: BlocBuilder<ParkingCubit, ParkingState>(
          builder: (context, state) {
            return context.read<ParkingCubit>().occupiedSlot.isEmpty
                ? const Center(child: TextWidget(tapToGetParkingSlots))
                : ListView.builder(
                    shrinkWrap: true,
                    itemCount: context.read<ParkingCubit>().occupiedSlot.length,
                    itemBuilder: (BuildContext context, int index) {
                      final item =
                          context.read<ParkingCubit>().occupiedSlot[index];
                      return Card(
                        margin: const EdgeInsets.symmetric(
                          vertical: 8,
                          horizontal: 0,
                        ),
                        elevation: 2,
                        shadowColor: Colors.grey,
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: ListTile(
                            leading:
                                Image.asset(_getIcon(item.type), width: 50),
                            title: Text(
                              '$vehicleType: ${item.type.name.toUpperCase()}'
                              '\n$floorNo ${item.floor} $at ${item.bayId}',
                              style: const TextStyle(fontSize: 18),
                            ),
                            trailing: InkWell(
                              onTap: () {
                                context
                                    .read<ParkingCubit>()
                                    .releaseParking(item.slot);
                              },
                              child: const Icon(
                                Icons.delete_outline,
                                color: Colors.red,
                                size: 35,
                              ),
                            ),
                          ),
                        ),
                      );
                    },
                  );
          },
        ),
      ),
      floatingActionButton: FloatingActionButtonExtended(
        key: const Key('btnGetSlot'),
        onPressed: () => _showCarTypeDialog(context),
        title: btnGetSlot,
        icon: Icons.add,
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }

  void _showCarTypeDialog(BuildContext context) {
    VehicleType type = VehicleType.small;
    Widget cancelButton = TextButton(
      child: const Text(btnCancel),
      onPressed: () => Navigator.pop(context),
    );
    Widget continueButton = TextButton(
      child: const Text(btnGetSlot),
      onPressed: () {
        context.read<ParkingCubit>().startParking(type);
        Navigator.pop(context);
      },
    );

    AlertDialog alert = AlertDialog(
      title: const Text(findSlot),
      actions: [cancelButton, continueButton],
      content: VehicleTypeDropdown(
        items: VehicleType.values.map((e) => e.name).toList(),
        onSelected: (String? value) {
          type = _getVehicleType(value!);
        },
      ),
    );
    showDialog(context: context, builder: (context) => alert);
  }
}

String _getIcon(VehicleType type) {
  String result;
  switch (type) {
    case VehicleType.small:
      result = Assets.small;
    case VehicleType.large:
      result = Assets.large;
    case VehicleType.medium:
      result = Assets.medium;
    case VehicleType.xlarge:
      result = Assets.xlarge;
  }
  return result;
}

VehicleType _getVehicleType(String type) {
  VehicleType result;
  switch (type) {
    case 'small':
      result = VehicleType.small;
    case 'large':
      result = VehicleType.large;
    case 'medium':
      result = VehicleType.medium;
    case 'xlarge':
      result = VehicleType.xlarge;
    default:
      result = VehicleType.small;
  }
  return result;
}
