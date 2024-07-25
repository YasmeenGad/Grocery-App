import 'package:supermarket/features/auth/domain/entities/user.dart';

class UserModel extends User {
  UserModel(
      {required String userName,
      required String email,
      required String password})
      : super(userName: userName, email: email, password: password);

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      userName: json['userName'] ?? '',
      email: json['email'] ?? '',
      password: json['password'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'userName': userName,
      'email': email,
      'password': password,
    };
  }
}
