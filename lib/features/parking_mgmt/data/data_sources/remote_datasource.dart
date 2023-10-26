import 'package:http/http.dart' as http;
import 'package:parking_management_app/features/parking_mgmt/config/configurations.dart';

import 'package:parking_management_app/features/parking_mgmt/data/models/slot_model.dart';
import 'package:parking_management_app/core/utils.dart';

abstract class RemoteDataSource {
  const RemoteDataSource();

  Future<SlotModel> getSlot(VehicleType type);

  Future<bool> releaseSlot();
}

class RemoteDataSourceImpl extends RemoteDataSource {
  const RemoteDataSourceImpl(this._client);

  final http.Client _client;

  @override
  Future<SlotModel> getSlot(VehicleType type) async {
    // Assuming, call getSlot REST api here which will return data
    // below json format
    // _client.get(
    //   Uri.https(
    //     'http://parkingservice.com',
    //     'getslot',
    //     {
    //       'Parking_lot_id': '1',
    //       'Size': 'small',
    //     },
    //   ),
    // );
    final floor = random(1, 4);
    final bayId = random(0, 1201);
    return SlotModel(
      slot: '{ Slot : $floor-$bayId }',
      floor: floor.toString(),
      bayId: bayId.toString(),
      type: type,
    );
  }

  @override
  Future<bool> releaseSlot() async {
    // Assuming, call releaseSlot REST api here
    // _client.get(
    //   Uri.https(
    //     'http://parkingservice.com',
    //     'releaseslot',
    //     {
    //       'Parking_lot_id': '1',
    //       'SlotID': '2-64772',
    //     },
    //   ),
    // );
    // when success it will return nothing
    return true;
  }
}
