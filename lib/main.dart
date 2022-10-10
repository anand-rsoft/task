import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:task/screens/upload_screen.dart';
import 'package:url_strategy/url_strategy.dart';

import 'screens/home_page.dart';
import 'package:firebase_core/firebase_core.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  Firebase.initializeApp();

  setPathUrlStrategy();
  runApp(GetMaterialApp(
    debugShowCheckedModeBanner: false,
    initialRoute: '/',
    getPages: [
      GetPage(name: '/', page: () => HomePage()),
      GetPage(name: '/upload', page: () => UploadScreen()),
      /* GetPage(
          name: '/dashboard',
          page: () => DashboardScreen(),
          transition: Transition.zoom),*/
    ],
  ));
}
