import 'package:flutter/material.dart';

import '../../../../../core/framework/theme/spacings/spacings.dart';
import '../../../../shared/presentation/components/button_component.dart';
import '../../../../shared/presentation/components/text_field_component.dart';
import '../controller/location_controller.dart';

class IdleRideStatePortion extends StatelessWidget {
  const IdleRideStatePortion(
      {super.key,
      required this.locationController,
      required this.onFindDriver});

  final LocationController locationController;
  final VoidCallback onFindDriver;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TextFieldComponent(
          textEditingController: TextEditingController(
            text: locationController.locationName.value,
          ),
          hint: "Current Location",
        ),
        SizedBox(
          height: Spacings.spacing10,
        ),
        TextFieldComponent(
          hint: "Search destination",
        ),
        SizedBox(
          height: Spacings.spacing14,
        ),
        ButtonComponent(
          expanded: true,
          text: "Find Driver",
          onPressed: onFindDriver,
        ),
      ],
    );
  }
}
