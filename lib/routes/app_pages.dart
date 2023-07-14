import 'package:get/get.dart';
import 'package:socket_io_messaging/bindings/chat_binding.dart';
import 'package:socket_io_messaging/bindings/login_binding.dart';
import 'package:socket_io_messaging/views/chat_screen.dart';
import 'package:socket_io_messaging/views/login_screen.dart';

import 'app_routes.dart';

class AppPages{
  static var list = [
    GetPage(
      name: AppRoutes.LOGIN_SCREEN,
      page: () => const LoginScreen(),
      binding: LoginBinding(),
    ),
    GetPage(
      name: AppRoutes.CHAT_SCREEN,
      page: () => ChatScreen(),
      binding: HomeBinding(),
    ),
  ];
}