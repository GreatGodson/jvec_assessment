class LoginRequestDto {
  final String email;
  final String password;
  final bool isLoggedIn;

  LoginRequestDto({
    this.email = '',
    this.password = '',
    this.isLoggedIn = false,
  });

  LoginRequestDto copyWith({
    String? email,
    String? password,
    bool? isLoggedIn,
  }) {
    return LoginRequestDto(
      email: email ?? this.email,
      password: password ?? this.password,
      isLoggedIn: isLoggedIn ?? this.isLoggedIn,
    );
  }

  Map<String, dynamic> toMap() => {
        "email": email,
        "password": password,
        "isLoggedIn": isLoggedIn,
      };
}
