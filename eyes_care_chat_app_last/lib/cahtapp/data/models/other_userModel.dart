class OtherUserModel {
  final int id;
  final String name;
  final String? profile_picture;

  OtherUserModel({
    required this.id,
    required this.name,
    required this.profile_picture
  });

  factory OtherUserModel.fromJson(Map<String, dynamic> json) {
    return OtherUserModel(
      id: json['id'],
      name: json['first_name'] + ' ' + json['last_name'],
      profile_picture : json['profile_picture']
    );
  }

  Map<String, dynamic> toJson() {
    return {'id': id, 'name': name,'profile_picture':profile_picture};
  }

  // تحويل Model إلى Entity
  OtherUserModel toEntity() {
    return OtherUserModel(
      id: id,
      name: name,
      profile_picture : profile_picture
    );
  }

  static fromJson2(Map<String, dynamic> json) {
    return OtherUserModel(id: json['id'], name: json['name'],profile_picture: json['profile_picture']);
  }
}
