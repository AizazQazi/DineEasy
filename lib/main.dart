import 'package:dine_easy/payment/Wallet.dart';
// import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import './client/./client_signin/loginpg.dart';
import './restaurant/./profile/profile.dart';
import './restaurant/./signin/./loginpg.dart';
import 'package:dine_easy/client/Home/HomePage.dart';
import './restaurant/token_manager.dart';
import 'Splash_Screen.dart';
import 'client/client_reservations/client_reservations.dart';

import 'package:another_flutter_splash_screen/another_flutter_splash_screen.dart';


void main() {
  runApp(const MyApp());
}

String? token;
String? name;

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return  MaterialApp(
      // debugShowCheckedModeBanner: false,
      home:
      // SplashScreen(), // Start with the SplashScreen
      FlutterSplashScreen.gif(
        gifPath: 'assets/images/example.gif',
        gifWidth: 269,
        gifHeight: 474,
        nextScreen: const MyHomePage(),
        duration: const Duration(milliseconds: 5515),
        onInit: () async {
          debugPrint("onInit");
        },
        onEnd: () async {
          debugPrint("onEnd 1");
        },
      ),
    );
  }
}

class MyHomePage extends StatelessWidget {
  const MyHomePage({Key? key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: const Color(0xFF020403),
          bottom: const TabBar(
            tabs: [
              Tab(text: "Restaurant"),
              Tab(text: "Customer"),
            ],
          ),
          title: const Text("Dine Easy"),
        ),
        body: const TabBarView(
          children: [
            Home_2(),
            Home_1(),
          ],
        ),
      ),
    );
  }
}