import 'package:get/get.dart';
import 'package:jvec_test/app/modules/onboarding/data/models/response/onboarding_model.dart';
import 'package:jvec_test/app/modules/onboarding/domain/repository/interface/onboarding_repository_interface.dart';

class OnboardingContentController extends GetxController {
  final OnboardingRepositoryInterface _onboardingService;

  OnboardingContentController()
      : _onboardingService = Get.find<OnboardingRepositoryInterface>();

  RxBool isLoading = true.obs;
  Rxn<OnboardingDto> onboardingData = Rxn<OnboardingDto>();

  @override
  void onInit() {
    super.onInit();
    loadOnboarding();
  }

  Future<void> loadOnboarding() async {
    try {
      isLoading.value = true;
      final dto = await _onboardingService.getOnBoardingContent();
      onboardingData.value = dto;
    } catch (e) {
      Get.snackbar("Error", "Failed to load onboarding data: $e");
    } finally {
      isLoading.value = false;
    }
  }
}
