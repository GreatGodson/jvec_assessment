import 'dart:convert';

import 'package:get/get.dart';
import 'package:jvec_test/app/modules/authentication/data/models/request/login_request_dto.dart';
import 'package:jvec_test/app/modules/authentication/data/models/response/login_response_model.dart';
import 'package:jvec_test/app/modules/authentication/data/models/response/signup_response_dto.dart';
import 'package:jvec_test/app/modules/dashboard/presentation/pages/dashboard_page.dart';
import 'package:jvec_test/core/framework/local/storage_service.dart';

import '../../../../../core/framework/helpers/form_validator.dart';
import '../../domain/repository/interface/auth_repository_interface.dart';

class LoginController extends GetxController {
  final AuthRepositoryInterface _authService;

  LoginController() : _authService = Get.find<AuthRepositoryInterface>();
  RxBool isLoading = false.obs;
  Rxn<LoginRequestDto> loginData = Rxn<LoginRequestDto>();
  Rxn<LoginResponseModel> loginResponse = Rxn<LoginResponseModel>();

  @override
  void onInit() {
    super.onInit();
    loginData.value = LoginRequestDto();
  }

  bool get isFormValid {
    final data = loginData.value;
    return FormValidator.isEmailValid(data?.email.trim()) == null &&
        FormValidator.isEmpty(data?.password.trim()) == null;
  }

  void updateSignUpData({
    String? email,
    String? password,
  }) {
    loginData.value = loginData.value?.copyWith(
      email: email,
      password: password,
    );
  }

  void clearFields() {
    loginData.value = LoginRequestDto();
  }

  void login() async {
    try {
      isLoading.value = true;
      if (AppPreferences.signupCredentials.isEmpty) {
        Get.snackbar("Error", "No account found, kindly signup");
        return;
      }
      final logInUser = LoginRequestDto(
        email: loginData.value!.email,
        password: loginData.value!.password,
      );
      final decode = jsonDecode(AppPreferences.signupCredentials);
      SignupResponseModel existingUser =
          SignupResponseModel.fromJson(Map.from(decode));

      if (existingUser.password != logInUser.password ||
          existingUser.email != logInUser.email) {
        Get.snackbar("Error", "Invalid credentials");
        return;
      }

      final response = await _authService.login(logInUser);
      loginResponse.value = response;
      Get.offAll(
        () => DashboardPage(),
      );
    } catch (e) {
      Get.snackbar("Error", "Failed to login$e");
    } finally {
      isLoading.value = false;
    }
  }
}
