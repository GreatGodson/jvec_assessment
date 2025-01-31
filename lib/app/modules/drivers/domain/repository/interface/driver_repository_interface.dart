import 'package:jvec_test/app/modules/drivers/data/get_drivers_response_model.dart';

abstract interface class DriverRepositoryInterface {
  Future<DriversResponseModel> getDrivers();

  Future<List<Driver>> getRideHistory();

  Future<List<Driver>> addRideToHistory(Driver model);
}
