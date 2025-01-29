class SignupRequestDto {
  final String name;
  final String email;
  final String phoneNumber;
  final String password;
  final String confirmPassword;

  SignupRequestDto({
    this.name = '',
    this.email = '',
    this.phoneNumber = '',
    this.password = '',
    this.confirmPassword = '',
  });

  SignupRequestDto copyWith({
    String? name,
    String? email,
    String? phoneNumber,
    String? password,
    String? confirmPassword,
  }) {
    return SignupRequestDto(
      name: name ?? this.name,
      email: email ?? this.email,
      phoneNumber: phoneNumber ?? this.phoneNumber,
      password: password ?? this.password,
      confirmPassword: confirmPassword ?? this.confirmPassword,
    );
  }

  Map<String, String> toMap() => {
        "name": name,
        "email": email,
        "phone_number": phoneNumber,
        "password": password,
      };
}
