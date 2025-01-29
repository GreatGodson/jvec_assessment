import 'package:jvec_test/app/modules/drivers/data/get_drivers_response_model.dart';
import 'package:jvec_test/app/modules/drivers/domain/repository/interface/driver_repository_interface.dart';
import 'package:jvec_test/app/modules/drivers/domain/service/driver_service.dart';

class DriverRepository implements DriverRepositoryInterface {
  final DriverService driverService;

  DriverRepository({
    required this.driverService,
  });

  @override
  Future<DriversResponseModel> getDrivers() {
    return driverService.getDrivers();
  }
}
