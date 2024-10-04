// import 'dart:io';

// import 'package:eyes_care_chat_app_last/cahtapp/data/models/message_model.dart';
// import 'package:eyes_care_chat_app_last/cahtapp/domain/repositories/massegs_repository.dart';
// import 'package:http/http.dart' as http;

// class MassegesUseCaseRequest {
//   final MassegRepository massegsRepository;
//   final http.Client client;
//   final int conversationId;

//   MassegesUseCaseRequest(
//       this.massegsRepository, this.conversationId, this.client);

//   Future<List<MessageModel>?> call(String accessToken) async {
//     final allConver = await massegsRepository.requestGetMassegsByConv(
//         accessToken, conversationId, client);

//     return allConver;
//   }
// }

// class SaveAllMassegsUseCase {
//   final MassegRepository massegsRepository;

//   SaveAllMassegsUseCase(this.massegsRepository);

//   Future<void> call(List<MessageModel> massegs) async {
//     await massegsRepository.saveAllNew(massegs);
//   }
// }

// class GetMassegsByConvFromLocalUseCase {
//   final MassegRepository massegsRepository;
//   final int conversationId;

//   GetMassegsByConvFromLocalUseCase(this.massegsRepository, this.conversationId);

//   Future<List<MessageModel>?> call() async {
//     final allConver =
//         await massegsRepository.GetMassegsByConvFromLocal(conversationId);

//     return allConver;
//   }
// }

// class AddMassegsUseCase {
//   final MassegRepository massegsRepository;
//   final MessageModel messageModel;
//   final int sender;
//   final int resever;
//   final String acssesToken;


//   AddMassegsUseCase(this.massegsRepository, this.messageModel, this.sender,
//       this.resever, this.acssesToken);

//   Future<MessageModel?> call() async {
//     return await massegsRepository.sendNewMasseg(
//         messageModel, sender, resever, acssesToken);
//   }
// }

// class SaveRecevMassege {
//   final MassegRepository massegsRepository;
//   final MessageModel messageModel;

//   SaveRecevMassege(this.massegsRepository, this.messageModel);

//   Future<void> call() async {
//     await massegsRepository.saveNewMasseg(messageModel);
//   }
// }
