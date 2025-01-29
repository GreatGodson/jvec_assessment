import 'package:jvec_test/app/modules/authentication/data/models/request/signup_request_dto.dart';
import 'package:jvec_test/app/modules/authentication/data/models/response/signup_response_dto.dart';

import '../../../data/models/request/login_request_dto.dart';
import '../../../data/models/response/login_response_model.dart';

abstract interface class AuthServiceInterface {
  Future<SignupResponseModel> signup(SignupRequestDto model);

  Future<LoginResponseModel> login(LoginRequestDto model);
}
