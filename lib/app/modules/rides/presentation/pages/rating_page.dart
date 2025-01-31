import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:get/get.dart';
import 'package:jvec_test/app/modules/dashboard/presentation/controller/location_controller.dart';
import 'package:jvec_test/app/modules/drivers/data/get_drivers_response_model.dart';
import 'package:jvec_test/app/modules/rides/presentation/controller/ride_flow_controller.dart';
import 'package:jvec_test/app/shared/helpers/date_converter.dart';
import 'package:jvec_test/app/shared/presentation/components/button_component.dart';
import 'package:jvec_test/app/shared/presentation/components/text_field_component.dart';
import 'package:jvec_test/core/framework/theme/spacings/spacings.dart';

import '../../../drivers/presentation/controller/ride_history_controller.dart';

class RatingPage extends StatelessWidget {
  RatingPage({
    super.key,
    required this.totalAmount,
    required this.dropOff,
    required this.pickup,
  });

  final String totalAmount;
  final String dropOff;
  final String pickup;

  final rateUnselect = const Icon(
    Icons.star_outline,
    color: Colors.grey,
  );

  final rateSelect = const Icon(
    Icons.star_outlined,
    color: Colors.yellow,
  );

  bool isRating = false;

  String starRating = '';
  String ratingContent = '';

  final rideHistoryController = Get.find<RideHistoryController>();
  final locationController = Get.find<LocationController>();
  final rideController = Get.find<RideFlowController>();

  void addToHistory() {
    rideHistoryController.addToHistory(
      Driver(
        dropOff: dropOff,
        pickup: pickup,
        plateNo: rideController.selectedDriver.value?.plateNo,
        phone: rideController.selectedDriver.value?.phone,
        price: rideController.selectedDriver.value?.price,
        name: rideController.selectedDriver.value?.name,
        type: rideController.selectedDriver.value?.type,
        rating: starRating,
        comments: ratingContent,
        status: rideController.rideStatus.value,
        date: convertDateFormat(
          DateTime.now().toString(),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        elevation: 0.0,
        leading: IconButton(
            onPressed: () {
              addToHistory();

              Get.back();
            },
            icon: Icon(Icons.close)),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: Spacings.spacing24,
          ),
          child: Column(
            children: [
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      Text(
                        'Please take a moment to tell us about your experience.',
                        style: TextStyle(
                          fontSize: Spacings.spacing18,
                        ),
                      ),
                      SizedBox(
                        height: Spacings.spacing14,
                      ),
                      Text(
                        '(Your feedback will help us improve your ride experience)',
                      ),
                      SizedBox(
                        height: Spacings.spacing50,
                      ),
                      Text(
                        "$totalAmount.00",
                        style: TextStyle(
                          fontSize: Spacings.spacing30,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      RatingBar.builder(
                        itemPadding: const EdgeInsets.only(top: 30, bottom: 30),
                        initialRating: 0,
                        itemCount: 5,
                        itemBuilder: (context, index) {
                          switch (index) {
                            case 0:
                              return rateSelect;
                            case 1:
                              return rateSelect;
                            case 2:
                              return rateSelect;
                            case 3:
                              return rateSelect;
                            case 4:
                              return rateSelect;
                          }
                          return const SizedBox.shrink();
                        },
                        onRatingUpdate: (rating) {
                          starRating = rating.toString();
                          // print(starRating);
                        },
                      ),
                      SizedBox(
                        height: Spacings.spacing24,
                      ),
                      Row(
                        children: const [
                          Text(
                            'Additional Comments',
                          ),
                        ],
                      ),
                      SizedBox(
                        height: Spacings.spacing8,
                      ),
                      TextFieldComponent(
                        hint: "Comments",
                        minLines: 3,
                        lines: 3,
                      ),
                      SizedBox(
                        height: Spacings.spacing30,
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(
                height: Spacings.spacing8,
              ),
              ButtonComponent(
                expanded: true,
                text: "Submit",
                onPressed: () {
                  addToHistory();
                  Get.back();
                },
              ),
              SizedBox(
                height: Spacings.spacing8,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
