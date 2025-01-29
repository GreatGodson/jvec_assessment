class SignupResponseModel {
  final String? name;
  final String? email;
  final String? phoneNumber;
  final String? password;

  SignupResponseModel({
    this.name,
    this.email,
    this.phoneNumber,
    this.password,
  });

  factory SignupResponseModel.fromJson(Map<String, dynamic> json) =>
      SignupResponseModel(
        name: json["name"],
        email: json["email"],
        phoneNumber: json["phone_number"],
        password: json["password"],
      );

  Map<String, dynamic> toJson() => {
        "name": name,
        "email": email,
        "phone_number": phoneNumber,
        "password": password,
      };
}
