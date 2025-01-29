import 'dart:convert';

import 'package:jvec_test/app/modules/authentication/data/models/request/login_request_dto.dart';
import 'package:jvec_test/app/modules/authentication/data/models/request/signup_request_dto.dart';
import 'package:jvec_test/app/modules/authentication/data/models/response/login_response_model.dart';
import 'package:jvec_test/app/modules/authentication/data/models/response/signup_response_dto.dart';
import 'package:jvec_test/app/modules/authentication/domain/service/interface/auth_service_interface.dart';
import 'package:jvec_test/core/framework/local/storage_service.dart';

class AuthService implements AuthServiceInterface {
  @override
  Future<SignupResponseModel> signup(SignupRequestDto model) async {
    await Future.delayed(Duration(seconds: 3));
    final json = model.toMap();
    final user = jsonEncode(json);
    await AppPreferences.storeSignupCredentials(user);
    return SignupResponseModel.fromJson(Map.from(json));
  }

  @override
  Future<LoginResponseModel> login(LoginRequestDto model) async {
    await Future.delayed(Duration(seconds: 3));
    final json = model.toMap();
    return LoginResponseModel.fromJson(Map.from(json));
  }
}
