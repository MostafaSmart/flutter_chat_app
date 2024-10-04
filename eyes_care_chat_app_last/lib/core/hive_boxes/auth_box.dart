// // data/repository/auth_repository_impl.dart
// import 'package:hive/hive.dart';

// class AuthLocalDataSource {

//   static const authToken = "access_token";
//   static const currentId = "id";
//   // static const userLoggedIn = "userLoggedIn";
//   static const userType = 'user_type';
//   final Box _box;

//   AuthLocalDataSource(this._box);

//   Future<void> saveUserData(Map<String, dynamic> userData) async {
//     await _box.put('user_data', userData);
//   }

//   Map<String, dynamic>? getUserData() {
//     return  _box.get('user_data');
//   }

//   Future<void> clearUserData() async {
//     await _box.delete('user_data');
//   }


//   static String? getAuthToken() {
//     final authBox = Hive.box(AuthBox.boxKey);
//     return authBox.get(AuthBox.authToken);
//   }


// }

// import 'package:eyes_care_app/core/helper/app_print_class.dart';
// import 'package:eyes_care_app/features/authentication/data/models/user_model.dart';
// import 'package:hive_flutter/adapters.dart';

// class AuthBox {
//   static const boxKey = "authBox";
//   static const authToken = "authToken";
//   static const currentUserData = "currentUserData";
//   static const userLoggedIn = "userLoggedIn";
//   static const userType = 'userType';
//   static const skip = 'skip';
//   static void setSkip(bool isSkip) {
//     Hive.box(AuthBox.boxKey).put(AuthBox.skip, isSkip);
//   }

//   static bool isSkip() {
//     final authBox = Hive.box(AuthBox.boxKey);
//     return authBox.get(AuthBox.skip, defaultValue: false);
//   }

//   static bool isUserLoggedIn() {
//     final authBox = Hive.box(AuthBox.boxKey);
//     return authBox.get(AuthBox.userLoggedIn, defaultValue: false);
//   }

//   static void setAuthToken(String token) {
//     final authBox = Hive.box(AuthBox.boxKey);
//     authBox.put(AuthBox.authToken, token);
//   }

//   static void setUserLoggedIn(bool isUserLoggedIn) {
//     final authBox = Hive.box(AuthBox.boxKey);
//     authBox.put(AuthBox.userLoggedIn, isUserLoggedIn);
//   }

//   static String? getAuthToken() {
//     final authBox = Hive.box(AuthBox.boxKey);
//     return authBox.get(AuthBox.authToken);
//   }

//   static void setUserType(String type) {
//     Hive.box(boxKey).put(userType, type);
//   }

//   static String? getUserType() {
//     return Hive.box(boxKey).get(userType);
//   }

//   static void setCurrentUserData(UserModel user) {
//     final authBox = Hive.box(AuthBox.boxKey);
//     authBox.put(AuthBox.currentUserData, user.toJson());
//   }

//   static UserModel getCurrentUserData() {
//     final authBox = Hive.box(AuthBox.boxKey);
//     final jsonData = authBox.get(AuthBox.currentUserData);
//     return UserModel.fromJson(jsonData);
//   }

//   static bool isDoctor() => getUserType() == 'doctor';

//   static void logout() {
//     final authBox = Hive.box(AuthBox.boxKey);
//     authBox.delete(AuthBox.authToken);
//     authBox.delete(AuthBox.userLoggedIn);
//     authBox.delete(AuthBox.currentUserData);
//     authBox.delete(AuthBox.userType);
//     AppPrint.printError('User logged out successfully.');
//   }
// }
