class Auth {
  final String access_token;
  final String token_type;

  Auth({required this.access_token, required this.token_type});

  factory Auth.fromJson(Map<String, dynamic> json) {
    return Auth(
      access_token: json['access_token'],
      token_type: json['token_type'],
    );
  }
}