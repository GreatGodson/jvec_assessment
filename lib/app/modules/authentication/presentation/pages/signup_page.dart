import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:jvec_test/app/modules/authentication/presentation/controller/signup_controller.dart';

import '../../../../../core/framework/helpers/form_validator.dart';
import '../../../../../core/framework/theme/spacings/spacings.dart';
import '../../../../shared/presentation/components/button_component.dart';
import '../../../../shared/presentation/components/text_field_component.dart';
import 'login_page.dart';

class SignupPage extends StatelessWidget {
  SignupPage({super.key});

  final signupController = Get.find<SignUpController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(body: Obx(
      () {
        final state = signupController.signupData.value;
        return SafeArea(
          child: Padding(
            padding: EdgeInsets.symmetric(
              horizontal: Spacings.spacing24,
            ),
            child: Column(
              children: [
                const SizedBox(
                  height: Spacings.spacing24,
                ),
                Text(
                  "Sign Up",
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
                        Column(
                          children: [
                            TextFieldComponent(
                              validator: (val) {
                                return FormValidator.isEmpty(
                                  signupController.signupData.value?.name
                                      .toString(),
                                );
                              },
                              hint: "Full Name",
                              onChanged: (name) {
                                signupController.updateSignUpData(name: name);
                              },
                            ),
                            const SizedBox(
                              height: Spacings.spacing16,
                            ),
                            TextFieldComponent(
                              validator: (val) {
                                return FormValidator.isEmailValid(
                                  signupController.signupData.value?.email
                                      .trim(),
                                );
                              },
                              keyboardType: TextInputType.emailAddress,
                              hint: "Email Address",
                              onChanged: (email) {
                                signupController.updateSignUpData(
                                    email: email.trim());
                              },
                            ),
                            const SizedBox(
                              height: Spacings.spacing16,
                            ),
                            TextFieldComponent(
                              inputFormatters: [
                                FilteringTextInputFormatter.digitsOnly,
                                LengthLimitingTextInputFormatter(11),
                              ],
                              validator: (val) {
                                return FormValidator.isPhoneNumberValid(
                                  signupController.signupData.value?.phoneNumber
                                      .trim(),
                                );
                              },
                              keyboardType: TextInputType.phone,
                              hint: "Enter phone number",
                              onChanged: (number) {
                                signupController.updateSignUpData(
                                    phoneNumber: number.trim());
                              },
                            ),
                            const SizedBox(
                              height: Spacings.spacing16,
                            ),
                            TextFieldComponent(
                              validator: (val) {
                                return FormValidator.isPasswordValid(
                                  signupController.signupData.value?.password
                                      .trim(),
                                );
                              },
                              hint: "Enter Password",
                              onChanged: (password) {
                                signupController.updateSignUpData(
                                    password: password.trim());
                              },
                            ),
                            const SizedBox(
                              height: Spacings.spacing16,
                            ),
                            TextFieldComponent(
                              validator: (val) {
                                return FormValidator.passwordMatch(
                                  signupController.signupData.value?.password
                                      .trim(),
                                  signupController
                                      .signupData.value!.confirmPassword
                                      .trim(),
                                );
                              },
                              hint: "Confirm Password",
                              onChanged: (password) {
                                signupController.updateSignUpData(
                                    confirmPassword: password.trim());
                              },
                            ),
                          ],
                        ),
                        SizedBox(
                          height: Spacings.spacing24,
                        ),
                        Text.rich(
                          TextSpan(
                            children: [
                              TextSpan(text: "Already have an account? "),
                              TextSpan(
                                text: "Log In",
                                style: TextStyle(
                                  color: Colors.purple,
                                ),
                                recognizer: TapGestureRecognizer()
                                  ..onTap = () {
                                    Get.off(() => LoginPage());
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
                  isLoading: signupController.isLoading.value,
                  validator: () => signupController.isFormValid,
                  text: "Continue",
                  onPressed: () {
                    signupController.signUp();
                  },
                  expanded: true,
                ),
                SizedBox(
                  height: Spacings.spacing6,
                ),
              ],
            ),
          ),
        );
      },
    ));
  }
}
