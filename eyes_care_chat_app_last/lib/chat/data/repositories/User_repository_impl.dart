// في data/repositories/user_repository_impl.dart
import 'package:eyes_care_chat_app_last/chat/data/remote/Remote_user.dart';

import '../../data/models/user_model.dart';
import '../../domain/repositories/user_repository.dart';
import 'package:http/http.dart' as http;


class UserRepositoryImpl implements UserRepository {
  final RemoteUser remote_user =RemoteUser() ;

  UserRepositoryImpl();

  @override
  Future<Map<String, dynamic>> login(
      String email, String password, http.Client client) async {
    final user_data = await remote_user.login(email, password, client);

    return user_data;
  }

  @override
  Future<UserModel?> getUser() {
    final userModel = remote_user.getUser();

    return userModel;
  }

  @override
  bool isLoggedIn() {
    // TODO: implement isLoggedIn
    throw UnimplementedError();
  }

  @override
  Future<void> saveUser(UserModel user) async {
    remote_user.saveUser(user);
  }
}
