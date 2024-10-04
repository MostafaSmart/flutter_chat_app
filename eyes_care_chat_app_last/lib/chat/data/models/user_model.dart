

import 'package:eyes_care_chat_app_last/chat/domain/entities/user.dart';

class UserModel {
  final int id;
  final String email;
  final String firstName;
  final String lastName;
  final String userType;
  final String accessToken;
  final String refreshToken;


  UserModel({
    required this.id,
    required this.email,
    required this.firstName,
    required this.lastName,
    required this.userType,
    required this.accessToken,
    required this.refreshToken,

  });

  // تحويل JSON إلى كائن Dart (LoginModel)
  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json['id'],
      email: json['email'],
      firstName: json['first_name'],
      lastName: json['last_name'],
      userType: json['user_type'],
      accessToken: json['access_token'],
      refreshToken: json['refresh'],
 
    );
  }

  // تحويل كائن Dart (LoginModel) إلى JSON
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'email': email,
      'first_name': firstName,
      'last_name': lastName,
      'user_type': userType,
      'access_token': accessToken,
      'refresh': refreshToken,

    };
  }

  // تحويل Model إلى Entity
  UserEntity toEntity() {
    return UserEntity(
      id: id,
      email: email,
      firstName: firstName,
      lastName: lastName,
      userType: userType,
      accessToken: accessToken,
      refreshToken: refreshToken,

    );
  }
}
