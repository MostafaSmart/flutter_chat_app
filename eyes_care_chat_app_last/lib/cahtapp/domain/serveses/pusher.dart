import 'package:eyes_care_chat_app_last/core/constants/pusher_conest.dart';
import 'package:get/get.dart';
import 'package:pusher_channels_flutter/pusher_channels_flutter.dart';

class PusherService extends GetxService {
  PusherChannelsFlutter pusher = PusherChannelsFlutter.getInstance();

  @override
  @override
  Future<void> onInit() async {
    super.onInit();
    await initializePusher();
  }

  Future<void> initializePusher() async {
   
    try {
      await pusher
          .init(
        apiKey: PusherConest().PUSHER_KEY,
        cluster: PusherConest().PUSHER_CLUSTER,
        onConnectionStateChange: onConnectionStateChange,
        onError: onError,
      )
          .catchError((e) {
        print("ERROR in init: $e");
      });

      await pusher.connect().catchError((e) {
        print("ERROR in connect: $e");
      });
    } catch (e) {
      print("ERROR: $e");
    } finally {
      print("finished with exceptions");
    }
  }

  dynamic onConnectionStateChange(String previousState, String cc) {
    print("Connection: $previousState");
  }

  dynamic onError(String message, int? code, dynamic e) {
    print("onError: $message code: $code exception: $e");
  }

  // Future<void> subscribeToChannel(
  //     int channelName, Function(dynamic) onEvent) async {
  //   try {
  //     await pusher.subscribe(
  //         channelName: 'conversation-$channelName', onEvent: onEvent);
  //   } catch (e) {
  //     print("Error subscribing to $channelName: $e");
  //   }
  // }
}
