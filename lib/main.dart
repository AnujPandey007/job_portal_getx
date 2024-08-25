import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'controllers/auth_controller.dart';
import 'firebase_options.dart';
import 'views/login_screen.dart';
import 'views/company_listing_screen.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  Get.put(AuthController());

  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Job Portal',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(useMaterial3: false),
      home: Obx(() {
        return Get.find<AuthController>().isLoggedIn.value ?
        CompanyListingScreen() : LoginScreen();
      }),
    );
  }
}
