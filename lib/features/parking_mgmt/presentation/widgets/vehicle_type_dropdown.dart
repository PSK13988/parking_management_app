import 'package:flutter/material.dart';
import 'package:parking_management_app/features/parking_mgmt/config/strings.dart';

class VehicleTypeDropdown extends StatefulWidget {
  const VehicleTypeDropdown({
    super.key,
    required this.items,
    required this.onSelected,
  });

  final List<String> items;
  final Function(String value) onSelected;

  @override
  State<VehicleTypeDropdown> createState() => _VehicleTypeDropdownState();
}

class _VehicleTypeDropdownState extends State<VehicleTypeDropdown> {
  late String dropdownValue;

  @override
  void initState() {
    dropdownValue = widget.items.first;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        const Text(vehicleType, style: TextStyle(fontSize: 18)),
        const SizedBox(width: 10),
        DropdownMenu<String>(
          initialSelection: widget.items.first,
          onSelected: (String? value) {
            setState(() {
              dropdownValue = value!;
            });
            widget.onSelected.call(value!);
          },
          dropdownMenuEntries:
              widget.items.map<DropdownMenuEntry<String>>((String value) {
            return DropdownMenuEntry<String>(
              value: value,
              label: value.toUpperCase(),
            );
          }).toList(),
        ),
      ],
    );
  }
}
