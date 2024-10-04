// في domain/repositories/user_repository.dart
import 'package:eyes_care_chat_app_last/chat/data/models/user_model.dart';
  import 'package:http/http.dart' as http;



abstract class UserRepository {
  Future<Map<String, dynamic>> login(String email, String password,http.Client client);
  Future<void> saveUser(UserModel user);
  Future<UserModel?> getUser();
  bool isLoggedIn();
}
