import 'package:get/get.dart';
import 'package:socket_io_messaging/controllers/chat_controller.dart';

class HomeBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ChatController>(() => ChatController());
  }
}