import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:get/get.dart';
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

  final _rateUnselect = const Icon(
    Icons.star_outline,
    color: Colors.grey,
  );

  final _rateSelect = const Icon(
    Icons.star_outlined,
    color: Colors.yellow,
  );

  String _starRating = '';
  final String _ratingContent = '';

  final _rideHistoryController = Get.find<RideHistoryController>();
  final _rideController = Get.find<RideFlowController>();

  void addToHistory() {
    _rideHistoryController.addToHistory(
      Driver(
        dropOff: dropOff,
        pickup: pickup,
        plateNo: _rideController.selectedDriver.value?.plateNo,
        phone: _rideController.selectedDriver.value?.phone,
        price: _rideController.selectedDriver.value?.price,
        name: _rideController.selectedDriver.value?.name,
        type: _rideController.selectedDriver.value?.type,
        rating: _starRating,
        comments: _ratingContent,
        status: _rideController.rideStatus.value,
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
                              return _rateSelect;
                            case 1:
                              return _rateSelect;
                            case 2:
                              return _rateSelect;
                            case 3:
                              return _rateSelect;
                            case 4:
                              return _rateSelect;
                          }
                          return const SizedBox.shrink();
                        },
                        onRatingUpdate: (rating) {
                          _starRating = rating.toString();
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
