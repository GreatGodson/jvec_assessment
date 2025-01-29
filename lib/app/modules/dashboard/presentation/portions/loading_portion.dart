import 'package:flutter/material.dart';
import 'package:jvec_test/app/modules/rides/presentation/controller/ride_flow_controller.dart';

import '../../../../../core/framework/theme/spacings/spacings.dart';
import '../../../../shared/presentation/components/shimmer.dart';

class LoadingPortion extends StatelessWidget {
  const LoadingPortion({
    super.key,
    required this.rideStates,
  });

  final RideStates rideStates;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            Text(
              rideStates == RideStates.idle ? "Finding Driver" : "Loading...",
              style: TextStyle(
                fontSize: Spacings.spacing24,
              ),
            ),
          ],
        ),
        SizedBox(
          height: Spacings.spacing24,
        ),
        ShimmerWidget(
          width: double.infinity,
          height: Spacings.spacing24,
        ),
        SizedBox(
          height: Spacings.spacing10,
        ),
        ShimmerWidget(
          width: double.infinity,
          height: Spacings.spacing24,
        ),
      ],
    );
  }
}
