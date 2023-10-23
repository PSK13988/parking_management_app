import 'package:http/http.dart' as http;
import 'dart:math';

import 'package:parking_management_app/features/parking_mgmt/data/models/slot_model.dart';

abstract class RemoteDataSource {
  const RemoteDataSource();

  Future<SlotModel> getSlot();

  Future<void> releaseSlot();
}

class RemoteDataSourceImpl extends RemoteDataSource {
  const RemoteDataSourceImpl(this._client);

  final http.Client _client;

  @override
  Future<SlotModel> getSlot() async {
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

    return SlotModel(slot: '{ Slot : ${_random(1, 4)}-${_random(0, 1201)} }');
  }

  @override
  Future<void> releaseSlot() async {
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
  }

  int _random(int min, int max) => min + Random().nextInt(max - min);
}
