import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:get/get.dart';
import 'package:jvec_test/app/modules/drivers/presentation/controller/ride_history_controller.dart';
import 'package:jvec_test/app/modules/rides/presentation/controller/ride_flow_controller.dart';
import 'package:jvec_test/core/framework/theme/spacings/spacings.dart';

class RideHistoryFragment extends StatelessWidget {
  RideHistoryFragment({super.key});

  final rideHistoryController = Get.find<RideHistoryController>()
    ..fetchDrivers();

  @override
  Widget build(BuildContext context) {
    return Obx(
      () {
        return Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: Spacings.spacing14,
          ),
          child: SingleChildScrollView(
            child: rideHistoryController.isLoading.value &&
                    rideHistoryController.rideHistory.value!.isEmpty
                ? Column(
                    children: [
                      SizedBox(height: MediaQuery.of(context).size.height / 2),
                      Center(
                        child: CupertinoActivityIndicator(
                          radius: Spacings.spacing12,
                        ),
                      ),
                    ],
                  )
                : Column(
                    children: [
                      rideHistoryController.rideHistory.value!.isNotEmpty
                          ? SafeArea(
                              child: Column(
                                  children: List.generate(
                                      rideHistoryController
                                          .rideHistory.value!.length, (index) {
                                final ride = rideHistoryController
                                    .rideHistory.value?[index];
                                final split = ride?.name!.split(" ");
                                final firstname = split?[0];
                                final lastname = split?[1];
                                return Container(
                                  margin: EdgeInsets.only(
                                    bottom: Spacings.spacing24,
                                  ),
                                  padding: EdgeInsets.symmetric(
                                    horizontal: Spacings.spacing10,
                                    vertical: Spacings.spacing16,
                                  ),
                                  decoration: BoxDecoration(
                                    color: Colors.blue.withOpacity(0.05),
                                    borderRadius: BorderRadius.circular(
                                        Spacings.spacing20),
                                  ),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(ride?.date ??
                                          DateTime.now().toString()),
                                      SizedBox(
                                        height: Spacings.spacing6,
                                      ),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Row(
                                            children: [
                                              CircleAvatar(
                                                child: Text(
                                                  "${firstname?[0]}${lastname?[0]}",
                                                ),
                                              ),
                                              SizedBox(
                                                width: Spacings.spacing10,
                                              ),
                                              Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Text(ride!.name!),
                                                  Text(ride!.phone!),
                                                ],
                                              ),
                                            ],
                                          ),
                                          Row(
                                            children: [
                                              Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Text(ride.price!),
                                                  ride.rating!.isNotEmpty
                                                      ? Row(
                                                          children: [
                                                            Text(ride.rating!),
                                                            Icon(Icons.star),
                                                          ],
                                                        )
                                                      : Text("No rating"),
                                                  Text(
                                                    ride.status ?? "canceled",
                                                    style: TextStyle(
                                                        color: ride.status ==
                                                                null
                                                            ? Colors.red
                                                            : ride.status!
                                                                        .toLowerCase() ==
                                                                    RideCompletionStatus
                                                                        .canceled
                                                                        .name
                                                                        .toLowerCase()
                                                                ? Colors.red
                                                                : Colors.green),
                                                  )
                                                ],
                                              )
                                            ],
                                          )
                                        ],
                                      ),
                                      SizedBox(
                                        height: Spacings.spacing30,
                                      ),
                                      Row(
                                        children: [
                                          CircleAvatar(
                                            backgroundColor: Colors.red,
                                            radius: 10,
                                            child: CircleAvatar(
                                              radius: 8,
                                              backgroundColor: Colors.white,
                                            ),
                                          ),
                                          SizedBox(
                                            width: Spacings.spacing6,
                                          ),
                                          Text(ride.pickup ?? ""),
                                        ],
                                      ),
                                      Container(
                                        margin: EdgeInsets.only(
                                          left: Spacings.spacing8,
                                        ),
                                        height: Spacings.spacing20,
                                        width: 2,
                                        color: Colors.grey,
                                      ),
                                      Row(
                                        children: [
                                          CircleAvatar(
                                            backgroundColor: Colors.green,
                                            radius: 10,
                                            child: CircleAvatar(
                                              radius: 8,
                                              backgroundColor: Colors.white,
                                            ),
                                          ),
                                          SizedBox(
                                            width: Spacings.spacing6,
                                          ),
                                          Text(ride.dropOff ?? ""),
                                        ],
                                      ),
                                    ],
                                  ),
                                )
                                    .animate()
                                    .scale(
                                        begin: const Offset(0.95, 0.95),
                                        end: const Offset(1, 1),
                                        duration:
                                            const Duration(milliseconds: 500))
                                    .fadeIn(
                                      duration:
                                          const Duration(milliseconds: 500),
                                      delay: ((index * 200).ms),
                                    );
                              })),
                            )
                          : Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                SizedBox(
                                  height:
                                      MediaQuery.of(context).size.height / 2,
                                ),
                                Icon(
                                  Icons.ac_unit_outlined,
                                  size: Spacings.spacing40,
                                ),
                                SizedBox(
                                  height: Spacings.spacing24,
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      "You have no rides",
                                      style: TextStyle(
                                        fontSize: Spacings.spacing16,
                                      ),
                                    ),
                                  ],
                                ),
                                SizedBox(
                                  height: Spacings.spacing6,
                                ),
                                Text(
                                  "Book your first ride and see your history appear here",
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    fontSize: Spacings.spacing14,
                                  ),
                                ),
                              ],
                            )
                    ],
                  ),
          ),
        );
      },
    );
  }
}
