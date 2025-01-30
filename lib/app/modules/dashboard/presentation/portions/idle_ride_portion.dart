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
  });

  final LocationController locationController;
  final VoidCallback onFindDriver;

  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Form(
      key: formKey,
      child: Column(
        children: [
          TextFieldComponent(
            header: "Pick Up",
            textEditingController: TextEditingController(
              text: locationController.locationName.value,
            ),
            hint: "Current Location",
          ),
          SizedBox(
            height: Spacings.spacing10,
          ),
          TextFieldComponent(
            header: "Destination",
            validator: (val) {
              return FormValidator.isEmpty(
                locationController.destination.value,
                customMessage: "Oops, Tell us your destination",
              );
            },
            textEditingController: TextEditingController(
              text: locationController.destination.value,
            ),
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
