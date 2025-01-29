import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
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
              const SizedBox(
                height: Spacings.spacing24,
              ),
              Text(
                "Log In",
                style: TextStyle(
                  fontSize: Spacings.spacing20,
                  fontWeight: FontWeight.w500,
                ),
              ),
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      const SizedBox(
                        height: Spacings.spacing30,
                      ),
                      TextFieldComponent(
                        validator: (val) {
                          return FormValidator.isEmailValid(
                            loginController.loginData.value?.email.trim(),
                          );
                        },
                        keyboardType: TextInputType.emailAddress,
                        hint: "Email Address",
                        onChanged: (email) {
                          loginController.updateSignUpData(email: email.trim());
                        },
                      ),
                      SizedBox(
                        height: Spacings.spacing16,
                      ),
                      TextFieldComponent(
                        validator: (val) {
                          return FormValidator.isEmpty(
                            loginController.loginData.value?.password.trim(),
                          );
                        },
                        hint: "Enter Password",
                        onChanged: (password) {
                          loginController.updateSignUpData(
                              password: password.trim());
                        },
                      ),
                      SizedBox(
                        height: Spacings.spacing24,
                      ),
                      Text.rich(
                        TextSpan(
                          children: [
                            TextSpan(text: "Don't have an account? "),
                            TextSpan(
                              text: "Sign Up",
                              style: TextStyle(
                                color: Colors.purple,
                              ),
                              recognizer: TapGestureRecognizer()
                                ..onTap = () {
                                  Get.off(() => SignupPage());
                                },
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              ),
              const SizedBox(
                height: Spacings.spacing10,
              ),
              ButtonComponent(
                isLoading: loginController.isLoading.value,
                validator: () => loginController.isFormValid,
                text: "Log In",
                onPressed: () {
                  loginController.login();
                },
                expanded: true,
              ),
              const SizedBox(
                height: Spacings.spacing6,
              ),
            ],
          ),
        ));
      }),
    );
  }
}
