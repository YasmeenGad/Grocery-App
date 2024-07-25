import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:supermarket/core/constants/ip.dart';
import 'package:supermarket/features/auth/data/models/login_response.dart';

abstract class AuthRemoteDatasource {
  Future<LoginResponse> login(String email, String password);
  Future<String> register(String username, String email, String password);
  Future<String> sendOtp(String email);
  Future<String> verifyOtp(String otp);
  Future<String> resetPassword(String token, String newPassword);
}

class AuthRemoteDatasourceImp implements AuthRemoteDatasource {
  final http.Client client;

  AuthRemoteDatasourceImp({required this.client});

  @override
  Future<LoginResponse> login(String email, String password) async {
    final loginUrl = Uri.parse('http://$ip:4000/user/login');
    final requestBody = {'email': email, 'password': password};
    final requestHeaders = {'Content-Type': 'application/json'};
    final response = await client.post(loginUrl,
        body: jsonEncode(requestBody), headers: requestHeaders);
    if (response.statusCode == 200) {
      return LoginResponse.fromJson(jsonDecode(response.body));
    } else {
      final errorResponse = jsonDecode(response.body);
      throw ('${errorResponse['message']}');
    }
  }

  @override
  Future<String> register(
      String userName, String email, String password) async {
    final registerUrl = Uri.parse('http://$ip:4000/user/register');
    final data = {'userName': userName, 'email': email, 'password': password};
    final response = await client.post(registerUrl,
        body: jsonEncode(data), headers: {'Content-Type': 'application/json'});
    final responseBody = jsonDecode(response.body);

    if (response.statusCode == 200 || response.statusCode == 201) {
      if (responseBody['status'] == true) {
        return '${responseBody['message']}';
      } else {
        throw ('Unexpected response structure: $responseBody');
      }
    } else {
      throw ('${responseBody['message']}');
    }
  }

  @override
  Future<String> resetPassword(String token, String newPassword) async {
    final url = Uri.parse('http://$ip:4000/user/reset');
    final requestBody = {'password': newPassword};
    final requestHeaders = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $token'
    };
    print('Token: $token');
    final response = await client.patch(url,
        body: jsonEncode(requestBody), headers: requestHeaders);

    if (response.statusCode == 200 || response.statusCode == 201) {
      final responseBody = jsonDecode(response.body);
      return responseBody['message'];
    } else {
      final errorResponse = jsonDecode(response.body);
      throw ('${errorResponse['message']}');
    }
  }

  @override
  Future<String> sendOtp(String email) async {
    final url = Uri.parse('http://$ip:4000/user/sendCode');
    final response = await client.post(
      url,
      body: jsonEncode({'email': email}),
      headers: {'Content-Type': 'application/json'},
    );

    if (response.statusCode == 200) {
      final responseBody = jsonDecode(response.body);
      return responseBody['message'];
    } else {
      throw Exception('Failed to send OTP');
    }
  }

  @override
  Future<String> verifyOtp(String otp) async {
    final url = Uri.parse('http://$ip:4000/user/verify');
    print('Sending OTP: $otp');
    final response = await client.post(
      url,
      body: jsonEncode({'otp': otp}),
      headers: {'Content-Type': 'application/json'},
    );

    if (response.statusCode == 200 || response.statusCode == 201) {
      final responseBody = jsonDecode(response.body);
      return responseBody['token'];
    } else {
      throw Exception('Failed to verify OTP');
    }
  }
}
