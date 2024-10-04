// data/repository/auth_repository_impl.dart
import 'package:hive/hive.dart';

class AuthBox {
  static const authToken = "access_token";
  static const currentId = "id";
  // static const userLoggedIn = "userLoggedIn";
  static const userType = 'user_type';

  final _box = Hive.box('authBox');

  Future<void> saveUserData(Map<String, dynamic> userData) async {
    await _box.put('user_data', userData);
  }

 Future< Map<String, dynamic>> getUserData() async{
    return await _box.get('user_data');
  }

  Future<void> clearUserData() async {
    await _box.delete('user_data');
  }

  Future<String> getAuthToken()  async{
  var  user = await getUserData();
    return user['access_token'];
  }

  Future<String> getUserType()async {
      var  user = await getUserData();
    return await user['user_type'];
    // return _box.get('user_type');
  }

  Future<int> getUserId() async {
             var  user = await getUserData();

    return await user['id'];
    // return _box.get('id');
  }
}
