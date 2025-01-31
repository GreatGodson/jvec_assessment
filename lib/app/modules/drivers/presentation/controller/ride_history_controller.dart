import 'package:get/get.dart';
import 'package:jvec_test/app/modules/drivers/data/get_drivers_response_model.dart';

import '../../domain/repository/interface/driver_repository_interface.dart';

class RideHistoryController extends GetxController {
  final DriverRepositoryInterface _driverService;

  RideHistoryController()
      : _driverService = Get.find<DriverRepositoryInterface>();
  RxBool isLoading = false.obs;
  Rxn<List<Driver>> rideHistory = Rxn<List<Driver>>([]);

  void addToHistory(Driver newRide) async {
    await _driverService.addRideToHistory(newRide);
  }

  void fetchDrivers() async {
    try {
      isLoading.value = true;
      await Future.delayed(Duration(seconds: 3));

      final response = await _driverService.getRideHistory();
      rideHistory.value = response.reversed.toList();
    } catch (e) {
      Get.snackbar("Error", "Failed to load history $e");
    } finally {
      isLoading.value = false;
    }
  }
}
