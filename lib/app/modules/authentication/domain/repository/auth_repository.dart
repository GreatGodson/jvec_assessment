import 'package:jvec_test/app/modules/authentication/data/models/request/login_request_dto.dart';
import 'package:jvec_test/app/modules/authentication/data/models/request/signup_request_dto.dart';
import 'package:jvec_test/app/modules/authentication/data/models/response/login_response_model.dart';
import 'package:jvec_test/app/modules/authentication/data/models/response/signup_response_dto.dart';
import 'package:jvec_test/app/modules/authentication/domain/repository/interface/auth_repository_interface.dart';
import 'package:jvec_test/app/modules/authentication/domain/service/auth_service.dart';

class AuthRepository implements AuthRepositoryInterface {
  final AuthService authService;

  AuthRepository({required this.authService});

  @override
  Future<SignupResponseModel> signup(SignupRequestDto model) {
    return authService.signup(model);
  }

  @override
  Future<LoginResponseModel> login(LoginRequestDto model) {
    return authService.login(model);
  }
}
