class LoginResponseModel {
  final String? email;
  final String? password;

  LoginResponseModel({
    this.email,
    this.password,
  });

  factory LoginResponseModel.fromJson(Map<String, dynamic> json) =>
      LoginResponseModel(
        email: json["email"],
        password: json["password"],
      );

  Map<String, dynamic> toJson() => {
        "email": email,
        "password": password,
      };
}
