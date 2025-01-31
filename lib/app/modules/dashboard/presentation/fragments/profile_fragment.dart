import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:jvec_test/app/modules/authentication/data/models/response/signup_response_dto.dart';
import 'package:jvec_test/app/shared/presentation/components/text_field_component.dart';
import 'package:jvec_test/core/framework/local/storage_service.dart';
import 'package:jvec_test/core/framework/theme/spacings/spacings.dart';

class ProfileFragment extends StatelessWidget {
  ProfileFragment({super.key});

  final decoded = jsonDecode(AppPreferences.signupCredentials);

  @override
  Widget build(BuildContext context) {
    final user = SignupResponseModel.fromJson(Map.from(decoded));

    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: Spacings.spacing24,
        ),
        child: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(
                height: Spacings.spacing60,
              ),
              CircleAvatar(
                radius: Spacings.spacing40,
                child: Text(
                  user.name![0],
                  style: TextStyle(
                    fontSize: Spacings.spacing30,
                  ),
                ),
              ),
              SizedBox(
                height: Spacings.spacing40,
              ),
              TextFieldComponent(
                initialValue: user.name,
                enabled: false,
              ),
              Divider(
                thickness: 0.5,
              ),
              TextFieldComponent(
                initialValue: user.email,
                enabled: false,
              ),
              Divider(
                thickness: 0.5,
              ),
              TextFieldComponent(
                initialValue: user.phoneNumber,
                enabled: false,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
