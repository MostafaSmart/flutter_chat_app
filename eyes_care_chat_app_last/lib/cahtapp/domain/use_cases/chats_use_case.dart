// import 'package:eyes_care_chat_app_last/cahtapp/data/models/conversation_model.dart';
// import 'package:eyes_care_chat_app_last/cahtapp/data/repositories/chat_repository_impl.dart';
// import 'package:eyes_care_chat_app_last/cahtapp/domain/repositories/chat_repository.dart';
// import 'package:http/http.dart' as http;

// // class ChatsUseCaseRequest {
// //   final ChatRepository chatRepository = ChatRepositoryImpl();
// //   final http.Client client = http.Client();

// //   ChatsUseCaseRequest();

// //   Future<List<ConversationModel>?> call(String accessToken) async {
// //     final allConver =
// //         await chatRepository.requestGetAllConversation(accessToken, client);

// //     return allConver;
// //   }
// // }

// class SaveAllChats {
//    final ChatRepository chatRepository;

//   SaveAllChats(this.chatRepository);

//   Future<void> call(List<ConversationModel> conversations) async {
//     await chatRepository.saveAllChats(conversations);
//   }
// }

// // class GetAllChatsUseCase {
// //   final ChatRepository chatRepository;
// //   GetAllChatsUseCase(this.chatRepository);
// //   Future<List<ConversationModel>> call() async {
// //     final allConver =
// //         await chatRepository.GetAllConversation();

// //     return allConver;
// //   }
// // }
