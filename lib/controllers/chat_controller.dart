import 'package:get/get.dart';

import '../models/message.dart';

class ChatController extends GetxController{
   final RxList<Message> _messages = <Message>[].obs;

  List<Message> get messages => _messages;

  addNewMessage(Message message) {
    _messages.add(message);
  }
}