import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:jvec_test/app/modules/drivers/data/get_drivers_response_model.dart';
import 'package:jvec_test/app/modules/drivers/domain/service/interface/driver_service_interface.dart';

import '../../../../shared/constants/assets.dart';

class DriverService implements DriverServiceInterface {
  @override
  Future<DriversResponseModel> getDrivers() async {
    final data = await rootBundle.loadString(JsonPaths.drivers);
    final body = jsonDecode(data);
    return DriversResponseModel.fromJson(Map.from(body));
  }
}
