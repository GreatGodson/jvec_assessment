import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:get/get.dart';
import 'package:jvec_test/app/modules/authentication/presentation/controller/signup_controller.dart';

import '../../../../../core/framework/helpers/form_validator.dart';
import '../../../../../core/framework/theme/spacings/spacings.dart';
import '../../../../shared/presentation/components/button_component.dart';
import '../../../../shared/presentation/components/text_field_component.dart';
import 'login_page.dart';

class SignupPage extends StatelessWidget {
  SignupPage({super.key});

  final _signupController = Get.find<SignUpController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Obx(
        () {
          final state = _signupController.signupData.value;
          return SafeArea(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: Spacings.spacing24),
              child: Column(
                children: [
                  const SizedBox(height: Spacings.spacing24),
                  Text(
                    "Sign Up",
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
                          Column(
                            children: [
                              _animatedTextField(
                                TextFieldComponent(
                                  validator: (val) {
                                    return FormValidator.isEmpty(
                                      _signupController.signupData.value?.name
                                          .toString(),
                                    );
                                  },
                                  hint: "Full Name",
                                  onChanged: (name) {
                                    _signupController.updateSignUpData(
                                        name: name);
                                  },
                                ),
                                0,
                              ),
                              SizedBox(
                                height: Spacings.spacing16,
                              ),
                              _animatedTextField(
                                TextFieldComponent(
                                  validator: (val) {
                                    return FormValidator.isEmailValid(
                                      _signupController.signupData.value?.email
                                          .trim(),
                                    );
                                  },
                                  keyboardType: TextInputType.emailAddress,
                                  hint: "Email Address",
                                  onChanged: (email) {
                                    _signupController.updateSignUpData(
                                        email: email.trim());
                                  },
                                ),
                                1,
                              ),
                              SizedBox(
                                height: Spacings.spacing16,
                              ),
                              _animatedTextField(
                                TextFieldComponent(
                                  inputFormatters: [
                                    FilteringTextInputFormatter.digitsOnly,
                                    LengthLimitingTextInputFormatter(11),
                                  ],
                                  validator: (val) {
                                    return FormValidator.isPhoneNumberValid(
                                      _signupController
                                          .signupData.value?.phoneNumber
                                          .trim(),
                                    );
                                  },
                                  keyboardType: TextInputType.phone,
                                  hint: "Enter phone number",
                                  onChanged: (number) {
                                    _signupController.updateSignUpData(
                                        phoneNumber: number.trim());
                                  },
                                ),
                                2,
                              ),
                              SizedBox(
                                height: Spacings.spacing16,
                              ),
                              _animatedTextField(
                                TextFieldComponent(
                                  suffix: Builder(
                                    builder: (context) {
                                      if (_signupController.isPasswordVisible) {
                                        return IconButton(
                                          onPressed: () {
                                            _signupController
                                                .togglePasswordVisibility();
                                          },
                                          icon: const Icon(
                                            Icons.visibility_off,
                                            size: Spacings.spacing20,
                                            color: Color(0xff808080),
                                          ),
                                        );
                                      } else {
                                        return IconButton(
                                            onPressed: () {
                                              _signupController
                                                  .togglePasswordVisibility();
                                            },
                                            icon: const Icon(
                                              Icons.visibility_outlined,
                                              size: Spacings.spacing20,
                                              color: Color(0xff808080),
                                            ));
                                      }
                                    },
                                  ),
                                  obscureText:
                                      !_signupController.isPasswordVisible,
                                  validator: (val) {
                                    return FormValidator.isPasswordValid(
                                      _signupController
                                          .signupData.value?.password
                                          .trim(),
                                    );
                                  },
                                  hint: "Enter Password",
                                  onChanged: (password) {
                                    _signupController.updateSignUpData(
                                        password: password.trim());
                                  },
                                ),
                                3,
                              ),
                              SizedBox(
                                height: Spacings.spacing16,
                              ),
                              _animatedTextField(
                                TextFieldComponent(
                                  suffix: Builder(
                                    builder: (context) {
                                      if (_signupController
                                          .isConfirmPasswordVisible) {
                                        return IconButton(
                                          onPressed: () {
                                            _signupController
                                                .togglePasswordConfirmVisibility();
                                          },
                                          icon: const Icon(
                                            Icons.visibility_off,
                                            size: Spacings.spacing20,
                                            color: Color(0xff808080),
                                          ),
                                        );
                                      } else {
                                        return IconButton(
                                            onPressed: () {
                                              _signupController
                                                  .togglePasswordConfirmVisibility();
                                            },
                                            icon: const Icon(
                                              Icons.visibility_outlined,
                                              size: Spacings.spacing20,
                                              color: Color(0xff808080),
                                            ));
                                      }
                                    },
                                  ),
                                  obscureText: !_signupController
                                      .isConfirmPasswordVisible,
                                  validator: (val) {
                                    return FormValidator.passwordMatch(
                                      _signupController
                                          .signupData.value?.password
                                          .trim(),
                                      _signupController
                                          .signupData.value!.confirmPassword
                                          .trim(),
                                    );
                                  },
                                  hint: "Confirm Password",
                                  onChanged: (password) {
                                    _signupController.updateSignUpData(
                                        confirmPassword: password.trim());
                                  },
                                ),
                                4,
                              ),
                            ],
                          ),
                          SizedBox(height: Spacings.spacing24),
                          Text.rich(
                            TextSpan(
                              children: [
                                TextSpan(text: "Already have an account? "),
                                TextSpan(
                                  text: "Log In",
                                  style: TextStyle(color: Colors.purple),
                                  recognizer: TapGestureRecognizer()
                                    ..onTap = () {
                                      Get.off(() => LoginPage());
                                    },
                                ),
                              ],
                            ),
                          )
                              .animate()
                              .fade(duration: 500.ms, delay: 1000.ms)
                              .slideX(
                                  begin: 0.3, end: 0, curve: Curves.easeOut),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: Spacings.spacing10),
                  ButtonComponent(
                    isLoading: _signupController.isLoading.value,
                    validator: () => _signupController.isFormValid,
                    text: "Continue",
                    onPressed: () {
                      _signupController.signUp();
                    },
                    expanded: true,
                  )
                      .animate()
                      .fade(duration: 400.ms, delay: 600.ms)
                      .scale(delay: 700.ms),
                  SizedBox(height: Spacings.spacing6),
                ],
              ),
            ),
          ).animate().fade(duration: 500.ms).slideY(begin: 0.2, end: 0);
        },
      ),
    );
  }

  Widget _animatedTextField(Widget textField, int index) {
    return textField
        .animate()
        .fade(duration: 500.ms, delay: (index * 100).ms)
        .slideX(begin: 0.4, end: 0, curve: Curves.easeOut);
  }
}
