
import 'dart:io';

abstract class NetworkInfo {
  Future<bool> get isConnected;
  Future<bool> checkInternet();
}

class NetworkInfoImpl implements NetworkInfo {
  @override
  Future<bool> get isConnected => checkInternet();

  @override
  Future<bool> checkInternet() async {
    try {
      // return true;
      var result = await InternetAddress.lookup('google.com');
      if ((result.isNotEmpty && result[0].rawAddress.isNotEmpty)) {
        return true;
      }
    } on SocketException {
      return false;
    }
    return false;
  }
}