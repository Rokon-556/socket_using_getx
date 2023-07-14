import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;
import 'package:socket_io_messaging/controllers/chat_controller.dart';

import '../models/message.dart';


class ChatScreen extends StatefulWidget {
  String? username;
  ChatScreen({Key? key, this.username}) : super(key: key);

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  ChatController controller = ChatController();
  late IO.Socket _socket;
  final TextEditingController _messageInputController = TextEditingController();

  _sendMessage() {
    _socket.emit('message', {
      'message': _messageInputController.text.trim(),
      'sender': widget.username
    });
    _messageInputController.clear();
  }

  _connectSocket() {
    _socket.onConnect((data) => print('Connection established'));
    _socket.onConnectError((data) => print('Connect Error: $data'));
    _socket.onDisconnect((data) => print('Socket.IO server disconnected'));
    _socket.on(
      'message',
          (data) => controller.addNewMessage(Message.fromJson(data),),);
  }

  @override
  void initState() {
    super.initState();
    //Important: If your server is running on localhost and you are testing your app on Android then replace http://localhost:3000 with http://10.0.2.2:3000
    _socket = IO.io(
      'http://localhost:3000',
      IO.OptionBuilder().setTransports(['websocket']).setQuery(
          {'username': widget.username}).build(),
    );
    _connectSocket();
  }

  @override
  void dispose() {
    _messageInputController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Flutter Socket.IO'),
      ),
      body: Column(
        children: [
          Expanded(
            child: Obx(()=>ListView.separated(
              padding: const EdgeInsets.all(16),
              itemBuilder: (context, index) {
                final message = controller.messages[index];
                return Wrap(
                  alignment: message.senderUsername == widget.username
                      ? WrapAlignment.end
                      : WrapAlignment.start,
                  children: [
                    Card(
                      color: message.senderUsername == widget.username
                          ? Theme.of(context).primaryColorLight
                          : Colors.white,
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          crossAxisAlignment:
                          message.senderUsername == widget.username
                              ? CrossAxisAlignment.end
                              : CrossAxisAlignment.start,
                          children: [
                            Text(message.message),
                            Text(
                              DateFormat('hh:mm a').format(message.sentAt),
                              style: Theme.of(context).textTheme.caption,
                            ),
                          ],
                        ),
                      ),
                    )
                  ],
                );
              },
              separatorBuilder: (_, index) => const SizedBox(
                height: 5,
              ),
              itemCount: controller.messages.length,
            ),),

          ),
          Container(
            decoration: BoxDecoration(
              color: Colors.grey.shade200,
            ),
            padding: const EdgeInsets.symmetric(
              horizontal: 16,
            ),
            child: SafeArea(
              child: Row(
                children: [
                  Expanded(
                    child: TextField(
                      controller: _messageInputController,
                      decoration: const InputDecoration(
                        hintText: 'Type your message here...',
                        border: InputBorder.none,
                      ),
                    ),
                  ),
                  IconButton(
                    onPressed: () {
                      if (_messageInputController.text.trim().isNotEmpty) {
                        _sendMessage();
                      }
                    },
                    icon: const Icon(Icons.send),
                  )
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}