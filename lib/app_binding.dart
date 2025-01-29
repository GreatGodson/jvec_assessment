import 'package:get/get.dart';
import 'package:jvec_test/app/modules/authentication/domain/repository/auth_repository.dart';
import 'package:jvec_test/app/modules/authentication/domain/service/auth_service.dart';
import 'package:jvec_test/app/modules/authentication/presentation/controller/signup_controller.dart';
import 'package:jvec_test/app/modules/dashboard/presentation/controller/location_controller.dart';
import 'package:jvec_test/app/modules/drivers/domain/repository/driver_repository.dart';
import 'package:jvec_test/app/modules/drivers/domain/repository/interface/driver_repository_interface.dart';
import 'package:jvec_test/app/modules/drivers/domain/service/driver_service.dart';
import 'package:jvec_test/app/modules/onboarding/domain/repository/interface/onboarding_repository_interface.dart';
import 'package:jvec_test/app/modules/onboarding/domain/service/onboarding_service.dart';
import 'package:jvec_test/app/modules/onboarding/presentation/controllers/onboarding_content_controller.dart';
import 'package:jvec_test/app/modules/rides/presentation/controller/ride_flow_controller.dart';

import 'app/modules/authentication/domain/repository/interface/auth_repository_interface.dart';
import 'app/modules/authentication/presentation/controller/login_controller.dart';
import 'app/modules/onboarding/domain/repository/onboarding_repository.dart';

class AppBindings extends Bindings {
  @override
  void dependencies() {
    /// Repositories
    Get.lazyPut<OnboardingRepositoryInterface>(
      () => OnboardingRepository(
        onboardingService: OnboardingService(),
      ),
    );
    Get.lazyPut<AuthRepositoryInterface>(
      () => AuthRepository(
        authService: AuthService(),
      ),
      fenix: true,
    );
    Get.lazyPut<DriverRepositoryInterface>(
      () => DriverRepository(
        driverService: DriverService(),
      ),
      fenix: true,
    );

    /// Controllers
    Get.lazyPut<OnboardingContentController>(
      () => OnboardingContentController(),
    );
    Get.lazyPut<SignUpController>(
      () => SignUpController(),
      fenix: true,
    );
    Get.lazyPut<LoginController>(
      () => LoginController(),
      fenix: true,
    );
    Get.lazyPut<LocationController>(
      () => LocationController(),
      fenix: true,
    );
    Get.lazyPut<RideFlowController>(
      () => RideFlowController(),
      fenix: true,
    );
  }
}
