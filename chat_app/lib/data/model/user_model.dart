
import 'package:cloud_firestore/cloud_firestore.dart';

import '../../domain/entities/person_chat.dart';

class PersonChatModel extends PersonChat {
  PersonChatModel({
    required super.id,
    required super.name,
    required super.imgUrl,
    required super.type,
    super.personUid,
    super.token,
    required super.lastSeen,
  });

    factory PersonChatModel.fromDocument(DocumentSnapshot doc) {
    return PersonChatModel(
      id: doc['id'],
      name: doc['name'],
      imgUrl: doc['imgUrl'],
      type: doc['type'],
      personUid: doc['personUid'],
      token: doc['token'],
      lastSeen: (doc['lastSeen'] as Timestamp).toDate(),
    );
  }
}
