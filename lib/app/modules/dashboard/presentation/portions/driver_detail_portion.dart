import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jvec_test/app/modules/drivers/data/get_drivers_response_model.dart';
import 'package:jvec_test/app/modules/drivers/presentation/pages/chat_page.dart';
import 'package:jvec_test/app/modules/rides/presentation/controller/ride_flow_controller.dart';
import 'package:jvec_test/core/framework/helpers/call_helper.dart';
import 'package:jvec_test/core/framework/helpers/share_helper.dart';

import '../../../../../core/framework/theme/spacings/spacings.dart';
import '../../../../shared/presentation/components/button_component.dart';
import '../controller/location_controller.dart';

class DriverDetailPortion extends StatelessWidget {
  DriverDetailPortion({
    super.key,
    required this.onIHaveSeenDriver,
    required this.driver,
    required this.rideState,
  });

  final VoidCallback onIHaveSeenDriver;
  final Driver driver;
  final RideStates rideState;

  final _locationController = Get.find<LocationController>();

  @override
  Widget build(BuildContext context) {
    final split = driver.name?.split(" ");
    final firstname = split?[0];
    final lastname = split?[1];
    final String googleMapsUrl =
        "https://www.google.com/maps/search/?api=1&query=${_locationController.currentLocation.value?.latitude},${_locationController.currentLocation.value?.longitude}";

    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CircleAvatar(
                  radius: Spacings.spacing24,
                  child: Text(
                    "${firstname?[0]}${lastname?[0]}".toUpperCase(),
                    style: TextStyle(
                      fontWeight: FontWeight.w500,
                      fontSize: Spacings.spacing18,
                    ),
                  ),
                ),
                SizedBox(
                  width: Spacings.spacing14,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      driver.name!,
                      style: TextStyle(
                        fontWeight: FontWeight.w400,
                        fontSize: Spacings.spacing18,
                      ),
                    ),
                    SizedBox(
                      height: Spacings.spacing2,
                    ),
                    Text(
                      driver.type!,
                      style: TextStyle(
                        fontWeight: FontWeight.w500,
                        fontSize: Spacings.spacing14,
                        color: Colors.grey,
                      ),
                    ),
                    SizedBox(
                      height: Spacings.spacing2,
                    ),
                    Text(
                      driver.plateNo!,
                      style: TextStyle(
                        fontWeight: FontWeight.w500,
                        fontSize: Spacings.spacing14,
                        color: Colors.grey,
                      ),
                    ),
                    SizedBox(
                      height: Spacings.spacing10,
                    ),
                    Row(
                      children: [
                        Text(
                          driver.rating!,
                          style: TextStyle(
                            fontWeight: FontWeight.w500,
                            fontSize: Spacings.spacing16,
                          ),
                        ),
                        SizedBox(
                          width: Spacings.spacing4,
                        ),
                        Icon(
                          Icons.star,
                          color: Colors.grey,
                        ),
                      ],
                    ),
                  ],
                )
              ],
            ),
            Column(
              children: [
                Text(
                  driver.price!,
                  style: TextStyle(
                    fontSize: Spacings.spacing16,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                SizedBox(
                  height: Spacings.spacing12,
                ),
                Row(
                  children: [
                    InkWell(
                      onTap: () {
                        Get.to(
                          () => ChatScreen(
                            number: driver.phone!,
                          ),
                        );
                      },
                      child: CircleAvatar(
                        child: Icon(
                          Icons.chat,
                          size: Spacings.spacing20,
                        ),
                      ),
                    ),
                    SizedBox(
                      width: Spacings.spacing12,
                    ),
                    InkWell(
                      onTap: () {
                        CallHelper.makePhoneCall(driver.phone!);
                      },
                      child: CircleAvatar(
                        child: Icon(
                          Icons.phone_enabled,
                          size: Spacings.spacing20,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            )
          ],
        ),
        SizedBox(
          height: Spacings.spacing24,
        ),
        Row(
          children: [
            Expanded(
              child: ButtonComponent(
                expanded: true,
                text: rideState == RideStates.driverFound
                    ? "I have seen my driver"
                    : "I have arrived my destination",
                onPressed: onIHaveSeenDriver,
              ),
            ),
            if (rideState == RideStates.driverArrived)
              Row(
                children: [
                  SizedBox(
                    width: Spacings.spacing24,
                  ),
                  InkWell(
                    onTap: () {
                      ShareHelper.shareText("""
Hey, I’m sharing my ride details with you. My driver is ${driver.name} ${driver.phone}, driving a ${driver.type} with plate number ${driver.plateNo}. My current location: $googleMapsUrl. I’ll keep you updated! """);
                    },
                    child: CircleAvatar(
                      child: Icon(Icons.share),
                    ),
                  ),
                ],
              ),
          ],
        ),
      ],
    );
  }
}
