import 'package:flutter/material.dart';

import '../splash_controller.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    SplashController.checkLogin(context);
    return Scaffold(
        body: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: const [
        //Image.asset(Images.hallmedLogo),
        CircularProgressIndicator(color: Colors.green)
      ],
    ));
  }
}
