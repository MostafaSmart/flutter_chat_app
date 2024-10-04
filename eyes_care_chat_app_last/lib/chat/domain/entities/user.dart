class UserEntity {
  final int id;
  final String email;
  final String firstName;
  final String lastName;
  final String userType;
  final String accessToken;
  final String refreshToken;


  UserEntity({
    required this.id,
    required this.email,
    required this.firstName,
    required this.lastName,
    required this.userType,
    required this.accessToken,
    required this.refreshToken,

  });
}
