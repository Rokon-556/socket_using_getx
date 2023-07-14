import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:socket_io_messaging/controllers/login_controller.dart';
import 'package:socket_io_messaging/views/chat_screen.dart';


class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _usernameController = TextEditingController();
  final LoginController controller = LoginController();

  @override
  void dispose() {
    _usernameController.dispose();
    super.dispose();
  }

  _login() {
    // final provider = Provider.of<LoginProvider>(context, listen: false);
    if (_usernameController.text.trim().isNotEmpty) {
      controller.setErrorMessage('');
      Get.to(()=>ChatScreen(username:_usernameController.text.trim()));
    } else {
      controller.setErrorMessage('Username is required!');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
               controller.errorMessage != ''
                      ? Padding(
                    padding: const EdgeInsets.only(bottom: 30.0),
                    child: Card(
                      color: Colors.red,
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          controller.errorMessage,
                          style: const TextStyle(color: Colors.white),
                        ),
                      ),
                    ),
                  ): Container(),
              const Icon(Icons.social_distance),
              // Image.asset('assets/socket_icon.png'),
              const SizedBox(
                height: 5,
              ),
              Text(
                'Flutter Socket.IO',
                style: Theme.of(context).textTheme.titleLarge,
              ),
              const SizedBox(
                height: 40,
              ),
              TextField(
                controller: _usernameController,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Who are you?',
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              ElevatedButton(
                onPressed: _login,
                child: const Text('Start Now'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}