import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'controllers/auth_controller.dart';
import 'pages/login_page.dart';
import 'pages/signup_page.dart';
import 'pages/home_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await SharedPreferences.getInstance();

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Doctor App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      initialBinding: AuthBinding(),
      getPages: [
        GetPage(name: '/login', page: () => LoginPage()),
        GetPage(name: '/signup', page: () => SignUpPage()),
        GetPage(name: '/home', page: () => HomePage(title: "Doctuh",)),
      ],
      home: AuthWrapper(),
    );
  }
}

class AuthBinding implements Bindings {
  @override
  void dependencies() {
    Get.put<AuthController>(AuthController());
  }
}

class AuthWrapper extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    final AuthController authController = Get.find<AuthController>();

    return Obx(() {
      if (authController.isLoading.value) {
        return const Scaffold(
          body: Center(
            child: CircularProgressIndicator(),
          ),
        );
      } else {
        return authController.isLoggedIn.value ? HomePage(title: "Doctuh") : LoginPage();
      }
    });
  }
}