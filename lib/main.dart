import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:giphyapp/SearchGiphy/view/SearchGiphyScreen.dart';
import 'package:google_fonts/google_fonts.dart';

import 'Authentication/Login/view/LoginScreen.dart';
import 'package:firebase_core/firebase_core.dart';

import 'firebase_options.dart';
Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp( MyApp());
}
void configLoading() {
  EasyLoading.instance
    ..indicatorType = EasyLoadingIndicatorType.fadingCircle
    ..animationStyle = EasyLoadingAnimationStyle.scale
    ..loadingStyle = EasyLoadingStyle.light
    ..indicatorSize = 45.0
    ..indicatorColor = Colors.white
    ..radius = 10.0
    ..progressColor = Colors.black
    ..backgroundColor = Colors.black // Set background color to black
    ..textColor = Colors.black
    ..fontSize = 18
    ..userInteractions = true
    ..dismissOnTap = true
    ..textStyle = GoogleFonts.poppins(
      fontSize: 18.0,
      color: Colors.black,
    )
    ..maskType = EasyLoadingMaskType.custom // Use custom mask type
    ..maskColor = Colors.black.withOpacity(0.2)
    ..contentPadding = const EdgeInsets.all(16.0) // Add padding
    ..successWidget =
    const Icon(Icons.check_circle, color: Colors.green, size: 40.0)
    ..errorWidget = const Icon(Icons.error, color: Colors.red, size: 40.0)
    ..infoWidget = const Icon(Icons.info, color: Colors.blue, size: 40.0);
}
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Flutter Demo',
      builder: EasyLoading.init(),
debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: SearchGiphyScreen(),
    );
  }}

