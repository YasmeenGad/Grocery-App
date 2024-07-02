import 'package:supermarket/features/auth/domain/entities/user.dart';

class UserModel extends User {
  final String? token;

  UserModel({required String id, required String userName, required String email, required String password, this.token}) : super(id: id, userName: userName, email: email, password: password);

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json['_id'] ?? '',
      userName: json['userName'] ?? '',
      email: json['email'] ?? '',
      password: json['password'] ?? '',
      token: json['token']?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      '_id': id,
      'userName': userName,
      'email': email,
      'password': password,
      'token': token?? '',
    };
  }
}
