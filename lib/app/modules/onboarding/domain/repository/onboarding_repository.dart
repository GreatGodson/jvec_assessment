import 'package:jvec_test/app/modules/onboarding/data/models/response/onboarding_model.dart';
import 'package:jvec_test/app/modules/onboarding/domain/repository/interface/onboarding_repository_interface.dart';
import '../service/onboarding_service.dart';

class OnboardingRepository implements OnboardingRepositoryInterface{
  final OnboardingService onboardingService;

  OnboardingRepository({
    required this.onboardingService,
});


  @override
  Future<OnboardingDto> getOnBoardingContent() {
  return onboardingService.getOnBoardingContent();
  }


}