import 'package:flutter/material.dart';
import 'package:jvec_test/app/modules/drivers/data/get_drivers_response_model.dart';
import 'package:jvec_test/app/modules/rides/presentation/controller/ride_flow_controller.dart';

import '../../../../../core/framework/theme/spacings/spacings.dart';
import '../../../../shared/presentation/components/button_component.dart';

class DriverDetailPortion extends StatelessWidget {
  const DriverDetailPortion({
    super.key,
    required this.onIHaveSeenDriver,
    required this.driver,
    required this.rideState,
  });

  final VoidCallback onIHaveSeenDriver;
  final Driver driver;
  final RideStates rideState;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                CircleAvatar(
                  child: Text(driver.name![0]),
                ),
                SizedBox(
                  width: Spacings.spacing10,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      driver.name!,
                    ),
                    Text(
                      driver.type!,
                    ),
                    Row(
                      children: [
                        Text(driver.rating!),
                        SizedBox(
                          width: Spacings.spacing6,
                        ),
                        Icon(Icons.star),
                      ],
                    ),
                  ],
                )
              ],
            ),
            Row(
              children: [
                CircleAvatar(
                  child: Icon(
                    Icons.chat,
                    size: Spacings.spacing20,
                  ),
                ),
                SizedBox(
                  width: Spacings.spacing12,
                ),
                CircleAvatar(
                  child: Icon(
                    Icons.phone_enabled,
                    size: Spacings.spacing20,
                  ),
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
                  CircleAvatar(
                    child: Icon(Icons.share),
                  ),
                ],
              ),
          ],
        ),
      ],
    );
  }
}
