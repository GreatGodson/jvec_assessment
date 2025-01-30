import 'package:flutter/material.dart';
import 'package:jvec_test/core/framework/helpers/form_validator.dart';

import '../../../../../core/framework/theme/spacings/spacings.dart';
import '../../../../shared/presentation/components/button_component.dart';
import '../../../../shared/presentation/components/text_field_component.dart';
import '../controller/location_controller.dart';

class IdleRideStatePortion extends StatelessWidget {
  IdleRideStatePortion({
    super.key,
    required this.locationController,
    required this.onFindDriver,
    required this.destinationController,
    required this.pickupController,
  });

  final LocationController locationController;
  final VoidCallback onFindDriver;
  final TextEditingController pickupController;
  final TextEditingController destinationController;

  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Form(
      key: formKey,
      child: Column(
        children: [
          TextFieldComponent(
            validator: (val) {
              return FormValidator.isEmpty(
                pickupController.text,
                customMessage: "Oops, Tell us your pick up location",
              );
            },
            textEditingController: pickupController,
            header: "Pick Up",
            hint: "Current Location",
          ),
          SizedBox(
            height: Spacings.spacing10,
          ),
          TextFieldComponent(
            textEditingController: destinationController,
            header: "Destination",
            validator: (val) {
              return FormValidator.isEmpty(
                destinationController.text,
                customMessage: "Oops, Tell us your destination",
              );
            },
            hint: "Search destination",
          ),
          SizedBox(
            height: Spacings.spacing14,
          ),
          ButtonComponent(
            expanded: true,
            text: "Find Driver",
            onPressed: () {
              if (formKey.currentState!.validate()) {
                onFindDriver();
              }
            },
          ),
        ],
      ),
    );
  }
}
