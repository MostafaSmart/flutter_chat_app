class PersonChat {
  final int id;
  final String name;
  final String imgUrl;
  final String type;
  final String? personUid;
  final String? token;
  final DateTime lastSeen;

  PersonChat({
    required this.id,
    required this.name,
    required this.imgUrl,

    required this.type,
    this.personUid,
    this.token,
    required this.lastSeen,
  });
}
