import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:get/get.dart';
import 'package:jvec_test/app/modules/dashboard/presentation/controller/location_controller.dart';
import 'package:jvec_test/app/modules/rides/presentation/controller/ride_flow_controller.dart';
import 'package:jvec_test/app/modules/rides/presentation/pages/rating_page.dart';
import 'package:jvec_test/core/framework/theme/spacings/spacings.dart';

import '../portions/driver_detail_portion.dart';
import '../portions/driver_not_foud_portion.dart';
import '../portions/idle_ride_portion.dart';
import '../portions/loading_portion.dart';

class HomeFragment extends StatefulWidget {
  const HomeFragment({super.key});

  @override
  State<HomeFragment> createState() => _HomeFragmentState();
}

class _HomeFragmentState extends State<HomeFragment>
    with SingleTickerProviderStateMixin {
  final MapController _mapController = MapController();
  late AnimationController _animationController;
  final locationController = Get.find<LocationController>();
  final rideFlowController = Get.find<RideFlowController>();

  late TextEditingController _pickUpController;
  late TextEditingController _destinationController;

  @override
  void initState() {
    super.initState();
    _animationController = BottomSheet.createAnimationController(this)
      ..duration = const Duration(milliseconds: 500);
    _destinationController = TextEditingController(
      text: locationController.destination.value,
    );
    _pickUpController = TextEditingController(
      text: locationController.locationName.value ?? "",
    );
    ever(locationController.destination, (value) {
      _destinationController.text = value!;
    });
    ever(locationController.locationName, (value) {
      _pickUpController.text = value!;
    });
  }

  @override
  void dispose() {
    _animationController.dispose();
    _destinationController.dispose();
    _pickUpController.dispose();
    super.dispose();
  }

  Widget _buildRideStatePortion() {
    if (rideFlowController.isLoading.value == true) {
      return LoadingPortion(
        rideStates: rideFlowController.rideState.value!,
      );
    }

    switch (rideFlowController.rideState.value) {
      case RideStates.idle:
        return IdleRideStatePortion(
          destinationController: _destinationController,
          pickupController: _pickUpController,
          locationController: locationController,
          onFindDriver: rideFlowController.searchRide,
        );

      case RideStates.driverFound:
        return DriverDetailPortion(
          rideState: RideStates.driverFound,
          driver: rideFlowController.selectedDriver.value!,
          onIHaveSeenDriver: () =>
              rideFlowController.updateRide(RideStates.driverArrived),
        );

      case RideStates.driverPending:
        return DriverNotFoundPortion(
          onCancel: rideFlowController.cancelRide,
          onRetry: rideFlowController.searchRide,
        );
      case RideStates.driverArrived:
        return DriverDetailPortion(
          rideState: RideStates.driverArrived,
          driver: rideFlowController.selectedDriver.value!,
          onIHaveSeenDriver: () {
            rideFlowController.rideStatus.value =
                RideCompletionStatus.completed.name;

            rideFlowController.updateRide(RideStates.idle);
            Get.to(
              () => RatingPage(
                pickup: _pickUpController.text,
                dropOff: _destinationController.text,
                totalAmount: rideFlowController.selectedDriver.value!.price!,
              ),
            );
          },
        );

      default:
        return IdleRideStatePortion(
          destinationController: _destinationController,
          pickupController: _pickUpController,
          locationController: locationController,
          onFindDriver: () {
            rideFlowController.searchRide();
          },
        );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      final locationState = locationController.locationName.value;
      final destinationName = locationController.destination.value;

      final rideState = rideFlowController.rideState.value;
      final rideStateLoading = rideFlowController.isLoading.value;

      return Column(
        children: [
          locationController.currentLocation.value == null
              ? const Center(child: CircularProgressIndicator())
              : Flexible(
                  child: Stack(
                    alignment: Alignment.bottomCenter,
                    clipBehavior: Clip.none,
                    children: [
                      Padding(
                        padding: EdgeInsets.only(
                          bottom: MediaQuery.of(context).size.height / 3.5,
                        ),
                        child: FlutterMap(
                          mapController: _mapController,
                          options: MapOptions(
                            onMapReady: () {
                              WidgetsBinding.instance.addPostFrameCallback(
                                (_) {
                                  _mapController.move(
                                    locationController.currentLocation.value!,
                                    16,
                                  );
                                },
                              );
                              // Ensure the map is centered when it is ready
                              // _mapController.moveAndRotate(_initialLocation, 12, 180);
                            },
                            // center: _currentLocation,
                            // zoom: 15.0,
                            onTap: (pos, latLng) {
                              locationController.getDestinationName(latLng);
                            },
                          ),
                          children: [
                            TileLayer(
                              urlTemplate:
                                  'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
                              userAgentPackageName: 'com.jvec.app',
                            ),
                            MarkerLayer(
                              markers: [
                                Marker(
                                  point:
                                      locationController.currentLocation.value!,
                                  width: 50,
                                  height: 50,
                                  child: Icon(
                                    Icons.location_history,
                                    color: Colors.red,
                                    size: 40,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                      Positioned(
                        bottom: 0,
                        left: 0,
                        right: 0,
                        child: BottomSheet(
                          animationController: _animationController,
                          showDragHandle: true,
                          enableDrag: true,
                          onClosing: () {},
                          // onDragStart: (val) {},
                          // onDragEnd: (value, {isClosing = false}) {},
                          builder: (BuildContext context) {
                            return Padding(
                              padding: const EdgeInsets.symmetric(
                                vertical: Spacings.spacing24,
                                horizontal: Spacings.spacing24,
                              ),
                              child: _buildRideStatePortion(),
                            );
                          },
                        ),
                      ),
                    ],
                  ),
                ),
        ],
      );
    });
  }
}

/// aditional features
//call , chat, ride share details, star rating
