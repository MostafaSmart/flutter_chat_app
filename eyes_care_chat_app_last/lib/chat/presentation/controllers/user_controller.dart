// في presentation/controllers/user_controller.dart

import 'package:eyes_care_chat_app_last/chat/data/repositories/User_repository_impl.dart';
import 'package:eyes_care_chat_app_last/chat/domain/use_cases/login_use_case.dart';
import 'package:get/get.dart';
import '../../data/models/user_model.dart';
import 'package:http/http.dart' as http;

class UserController extends GetxController {
  final LoginUseCase loginUseCase =
      LoginUseCase(UserRepositoryImpl(), http.Client());

  final SaveUser saveuser = SaveUser(UserRepositoryImpl());

  final GetUserUseCase getUserUseCase = GetUserUseCase(UserRepositoryImpl());

  var isLoading = false.obs;
  var errorMessage = ''.obs;
  var user = Rxn<UserModel>();

  UserController();

  Future<void> login(String email, String password) async {
    final userdata = await loginUseCase.call(email, password);
    saveUser(userdata);
  }

  Future<void> saveUser(UserModel userdata) async {
    saveuser.call(userdata);
  }

  // جلب بيانات المستخدم من Hive
  Future<void> loadUser() async {
    user.value = await getUserUseCase.call();
  }

  Future<UserModel> getUser() async {
    user.value = await getUserUseCase.call();
    return user.value!;
  }

  // التحقق من تسجيل الدخول
  bool isLoggedIn() {
    return user.value != null;
  }

  // دالة تسجيل الدخول
}
