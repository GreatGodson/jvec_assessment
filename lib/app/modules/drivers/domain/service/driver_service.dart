import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:jvec_test/app/modules/drivers/data/get_drivers_response_model.dart';
import 'package:jvec_test/app/modules/drivers/domain/service/interface/driver_service_interface.dart';
import 'package:jvec_test/core/framework/local/storage_service.dart';

import '../../../../shared/constants/assets.dart';

class DriverService implements DriverServiceInterface {
  @override
  Future<DriversResponseModel> getDrivers() async {
    final data = await rootBundle.loadString(JsonPaths.drivers);
    final body = await jsonDecode(data);
    return DriversResponseModel.fromJson(Map.from(body));
  }

  @override
  Future<List<Driver>> getRideHistory() async {
    final local = AppPreferences.rideList;
    final decoded = await jsonDecode(local);
    final map = DriversResponseModel.fromJson(Map.from(decoded));
    return map.drivers ?? [];
  }

  // @override
  // Future<List<Driver>> addRideToHistory(Driver model) async {
  //   final local = AppPreferences.rideList;
  //   final decoded = await jsonDecode(local);
  //   final map = DriversResponseModel.fromJson(Map.from(decoded));
  //   final List<Driver> history = map.drivers ?? [];
  //   history.add(model);
  //   final encode = jsonEncode(DriversResponseModel(drivers: history));
  //   AppPreferences.storeRideList(encode);
  //   return history;
  // }

  @override
  Future<List<Driver>> addRideToHistory(Driver model) async {
    final local = AppPreferences.rideList;

    // Ensure it's not null or empty before decoding
    final decoded = (local.isEmpty)
        ? {"drivers": []} // Provide default empty JSON structure
        : jsonDecode(local);

    final map = DriversResponseModel.fromJson(Map.from(decoded));
    final List<Driver> history = map.drivers ?? [];

    history.add(model);

    final encode = jsonEncode(DriversResponseModel(drivers: history));
    await AppPreferences.storeRideList(encode);

    return history;
  }
}
