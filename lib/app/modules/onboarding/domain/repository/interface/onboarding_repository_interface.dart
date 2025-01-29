import 'package:jvec_test/app/modules/onboarding/data/models/response/onboarding_model.dart';

abstract interface class OnboardingRepositoryInterface{
  Future<OnboardingDto> getOnBoardingContent();
}