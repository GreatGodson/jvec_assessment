import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:get/get.dart';
import 'package:jvec_test/app/modules/authentication/presentation/controller/login_controller.dart';
import 'package:jvec_test/app/modules/authentication/presentation/pages/signup_page.dart';
import 'package:jvec_test/app/shared/presentation/components/button_component.dart';
import 'package:jvec_test/app/shared/presentation/components/text_field_component.dart';
import 'package:jvec_test/core/framework/theme/spacings/spacings.dart';

import '../../../../../core/framework/helpers/form_validator.dart';

class LoginPage extends StatelessWidget {
  LoginPage({super.key});

  final loginController = Get.find<LoginController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Obx(() {
        final state = loginController.loginData.value;
        return SafeArea(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: Spacings.spacing24),
            child: Column(
              children: [
                const SizedBox(height: Spacings.spacing24),
                Text(
                  "Log In",
                  style: TextStyle(
                    fontSize: Spacings.spacing20,
                    fontWeight: FontWeight.w500,
                  ),
                ).animate().fade(duration: 500.ms).scale(delay: 300.ms),
                Expanded(
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        const SizedBox(height: Spacings.spacing30),
                        _animatedTextField(
                          TextFieldComponent(
                            validator: (val) {
                              return FormValidator.isEmailValid(
                                loginController.loginData.value?.email.trim(),
                              );
                            },
                            keyboardType: TextInputType.emailAddress,
                            hint: "Email Address",
                            onChanged: (email) {
                              loginController.updateSignUpData(
                                  email: email.trim());
                            },
                          ),
                          0,
                        ),
                        const SizedBox(height: Spacings.spacing16),
                        _animatedTextField(
                          TextFieldComponent(
                            validator: (val) {
                              return FormValidator.isEmpty(
                                loginController.loginData.value?.password
                                    .trim(),
                              );
                            },
                            hint: "Enter Password",
                            onChanged: (password) {
                              loginController.updateSignUpData(
                                  password: password.trim());
                            },
                          ),
                          1,
                        ),
                        const SizedBox(height: Spacings.spacing24),
                        Text.rich(
                          TextSpan(
                            children: [
                              TextSpan(text: "Don't have an account? "),
                              TextSpan(
                                text: "Sign Up",
                                style: TextStyle(color: Colors.purple),
                                recognizer: TapGestureRecognizer()
                                  ..onTap = () {
                                    Get.off(() => SignupPage());
                                  },
                              ),
                            ],
                          ),
                        )
                            .animate()
                            .fade(duration: 500.ms, delay: 1000.ms)
                            .slideX(begin: 0.3, end: 0, curve: Curves.easeOut),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: Spacings.spacing10),
                ButtonComponent(
                  isLoading: loginController.isLoading.value,
                  validator: () => loginController.isFormValid,
                  text: "Log In",
                  onPressed: () {
                    loginController.login();
                  },
                  expanded: true,
                )
                    .animate()
                    .fade(duration: 400.ms, delay: 600.ms)
                    .scale(delay: 700.ms),
                const SizedBox(height: Spacings.spacing6),
              ],
            ),
          ),
        ).animate().fade(duration: 500.ms).slideY(begin: 0.2, end: 0);
      }),
    );
  }

  Widget _animatedTextField(Widget textField, int index) {
    return textField
        .animate()
        .fade(duration: 500.ms, delay: (index * 100).ms)
        .slideX(begin: 0.4, end: 0, curve: Curves.easeOut);
  }
}
