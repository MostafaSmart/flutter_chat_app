import 'dart:convert';

import 'package:eyes_care_chat_app_last/chat/data/hive_box/user_box.dart';
import 'package:eyes_care_chat_app_last/chat/data/models/user_model.dart';
import 'package:http/http.dart' as http;

class RemoteUser {
  final authBox = AuthBox();

  Future<Map<String, dynamic>> login(
      String email, String password, http.Client client) async {
    final url = Uri.parse('http://192.168.43.59:8000/api/auth/login/');
    final response = await client.post(
      url,
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({'email': email, 'password': password}),
    );

    if (response.statusCode == 200) {
      final userData = jsonDecode(response.body);

      return userData; // إرجاع البيانات الخام
    } else {
      throw Exception('Login failed');
    }
  }

  Future<void> saveUser(UserModel user) async {
    authBox.saveUserData(user.toJson());
  }

  Future<UserModel> getUser() async {
    final data = await authBox.getUserData();

    if (data != null) {
      final userModel = UserModel.fromJson(data);

      return userModel;
    } else {
      throw Exception('no user');
    }
  }
}
