class AppException implements Exception {
  final dynamic failure;

  AppException(this.failure);
}

class ConnectionTimeoutException implements Exception {

}