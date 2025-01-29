 import '../../../data/models/response/onboarding_model.dart';

abstract interface class OnboardingServiceInterface {
   Future<OnboardingDto> getOnBoardingContent();

 }