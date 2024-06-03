class AuthModel {
  String username;
  String password;

  AuthModel({
    required this.username,
    required this.password,
  });

  Map<String, dynamic> toJson() =>
      {
        'username': username,
        'password': password,
      };
}
