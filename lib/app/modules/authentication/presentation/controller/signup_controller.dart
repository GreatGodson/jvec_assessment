import 'package:get/get.dart';
import 'package:jvec_test/app/modules/authentication/data/models/request/signup_request_dto.dart';
import 'package:jvec_test/app/modules/authentication/data/models/response/signup_response_dto.dart';
import 'package:jvec_test/app/modules/dashboard/presentation/pages/dashboard_page.dart';

import '../../../../../core/framework/helpers/form_validator.dart';
import '../../domain/repository/interface/auth_repository_interface.dart';

class SignUpController extends GetxController {
  final AuthRepositoryInterface _authService;

  SignUpController() : _authService = Get.find<AuthRepositoryInterface>();
  RxBool isLoading = false.obs;
  Rxn<SignupRequestDto> signupData = Rxn<SignupRequestDto>();
  final Rxn<SignupResponseModel> _signupResponse = Rxn<SignupResponseModel>();
  final Rxn<bool> _passwordVisible = Rxn<bool>(false);
  final Rxn<bool> _confirmPasswordVisible = Rxn<bool>(false);

  @override
  void onInit() {
    super.onInit();
    signupData.value = SignupRequestDto();
  }

  bool get isFormValid {
    final data = signupData.value;
    return FormValidator.isEmailValid(data?.email.trim()) == null &&
        FormValidator.isEmpty(data?.name.trim()) == null &&
        FormValidator.isPhoneNumberValid(data?.phoneNumber.trim()) == null &&
        FormValidator.isPasswordValid(data?.password.trim()) == null &&
        FormValidator.passwordMatch(
              data?.password.trim(),
              data!.confirmPassword.trim(),
            ) ==
            null;
  }

  bool get isPasswordVisible {
    final data = _passwordVisible.value;
    return data!;
  }

  bool get isConfirmPasswordVisible {
    final data = _confirmPasswordVisible.value;
    return data!;
  }

  void togglePasswordVisibility() {
    _passwordVisible.value = !_passwordVisible.value!;
  }

  void togglePasswordConfirmVisibility() {
    _confirmPasswordVisible.value = !_confirmPasswordVisible.value!;
  }

  void updateSignUpData({
    String? name,
    String? email,
    String? phoneNumber,
    String? password,
    String? confirmPassword,
  }) {
    signupData.value = signupData.value?.copyWith(
      name: name,
      email: email,
      phoneNumber: phoneNumber,
      password: password,
      confirmPassword: confirmPassword,
    );
  }

  void clearFields() {
    signupData.value = SignupRequestDto();
  }

  void signUp() async {
    try {
      isLoading.value = true;
      final model = SignupRequestDto(
        name: signupData.value!.name,
        email: signupData.value!.email.toLowerCase(),
        phoneNumber: signupData.value!.phoneNumber,
        password: signupData.value!.password,
      );
      final response = await _authService.signup(model);
      _signupResponse.value = response;
      Get.offAll(
        () => DashboardPage(),
      );
    } catch (e) {
      Get.snackbar("Error", "Failed to sign up $e");
    } finally {
      isLoading.value = false;
    }
  }
}
