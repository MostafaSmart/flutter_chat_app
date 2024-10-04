abstract class Success{
  final String? code;
  final String message;

  const Success(this.message, {this.code});
}

class ServerSuccess extends Success{
  const ServerSuccess(super.message);
}