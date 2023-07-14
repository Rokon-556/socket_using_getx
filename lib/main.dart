import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:socket_io_messaging/bindings/login_binding.dart';
import 'package:socket_io_messaging/routes/app_pages.dart';
import 'routes/app_routes.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Main Product',
      initialRoute: AppRoutes.LOGIN_SCREEN,
      initialBinding: LoginBinding(),
      getPages: AppPages.list,
    );
  }
}

