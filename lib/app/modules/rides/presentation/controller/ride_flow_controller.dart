import 'dart:math';

import 'package:get/get.dart';

import '../../../drivers/data/get_drivers_response_model.dart';
import '../../../drivers/domain/repository/interface/driver_repository_interface.dart';

class RideFlowController extends GetxController {
  final DriverRepositoryInterface _driverService;

  RideFlowController() : _driverService = Get.find<DriverRepositoryInterface>();
  Rxn<RideStates> rideState = Rxn<RideStates>(RideStates.idle);
  Rxn<bool> isLoading = Rxn<bool>(false);
  final Rxn<DriversResponseModel> _driverResponse = Rxn<DriversResponseModel>();
  Rxn<Driver> selectedDriver = Rxn<Driver>(null);
  Rxn<String> rideStatus = Rxn<String>("");

  void updateRide(RideStates newState, {int? waitTime}) async {
    isLoading.value = true;
    await Future.delayed(
      Duration(seconds: waitTime ?? 3),
    );
    rideState.value = newState;
    isLoading.value = false;
  }

  void searchRide() async {
    isLoading.value = true;
    final random = Random();
    bool decision = random.nextBool();
    if (decision) {
      await Future.delayed(Duration(seconds: 6));
      final drivers = await _driverService.getDrivers();
      _driverResponse.value = drivers;
      final driverList = drivers.drivers;
      selectedDriver.value = driverList?[random.nextInt(driverList.length)];
      isLoading.value = false;
      rideState.value = RideStates.driverFound;
      rideStatus.value = RideCompletionStatus.ongoing.name;
    } else {
      await Future.delayed(Duration(seconds: 15));
      isLoading.value = false;
      selectedDriver.value = null;
      rideState.value = RideStates.driverPending;
    }
  }

  void cancelRide() async {
    rideStatus.value = RideCompletionStatus.canceled.name;
    rideState.value = RideStates.idle;
  }
}

enum RideStates {
  idle,
  driverFound,
  driverPending,
  driverArrived,
  tripStarted,
  completed,
}

enum RideCompletionStatus { ongoing, completed, canceled }

extension RideStateExtension on RideStates {
  bool get isIdle => this == RideStates.idle;

  bool get isDriverFound => this == RideStates.driverFound;

  bool get isDriverPending => this == RideStates.driverPending;

  bool get hasDriverArrived => this == RideStates.driverArrived;

  bool get hasTripStarted => this == RideStates.tripStarted;

  bool get isCompleted => this == RideStates.completed;
}
