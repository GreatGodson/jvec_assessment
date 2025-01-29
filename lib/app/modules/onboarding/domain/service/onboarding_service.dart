import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:jvec_test/app/modules/onboarding/domain/service/interface/onboarding_service_interface.dart';

import '../../../../shared/constants/assets.dart';
import '../../data/models/response/onboarding_model.dart';

class OnboardingService implements OnboardingServiceInterface{

  @override
  Future<OnboardingDto> getOnBoardingContent() async  {
    final data = await rootBundle.loadString(JsonPaths.onBoarding);
    final body = jsonDecode(data);
    return OnboardingDto.fromJson(Map.from(body));
  }
}
