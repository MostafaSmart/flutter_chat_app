// في domain/use_cases/login_use_case.dart
import 'package:eyes_care_chat_app_last/chat/data/models/user_model.dart';

import '../../domain/repositories/user_repository.dart';
import 'package:http/http.dart' as http;

class LoginUseCase {
  final UserRepository userRepository;
  final http.Client client;

  LoginUseCase(this.userRepository, this.client);

  Future<UserModel> call(String email, String password) async {
    final data = await userRepository.login(email, password, client);

    final userModel = UserModel.fromJson(data['data']);

    return userModel;
  }
}



class SaveUser {
  final UserRepository userRepository;
 
  SaveUser(this.userRepository);

  Future<void> call(UserModel userModel) async {
    await userRepository.saveUser(userModel);
  }
}


class GetUserUseCase {
  final UserRepository userRepository;
  GetUserUseCase(this.userRepository);

  Future<UserModel> call() async {
    final data = await userRepository.getUser();

    return data!;
  }
}