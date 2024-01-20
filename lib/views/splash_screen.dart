import 'package:driving_school/views/choose_user.dart';
import 'package:flutter/material.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    gotoNext(context);
    return Scaffold(
      body: Center(
        child: Image.asset('assets/splash_logo.png'),
      ),
    );
  }

  void gotoNext(context) async {
    await Future.delayed(const Duration(seconds: 3));
    Navigator.of(context).push(MaterialPageRoute(
      builder: (context) => const ChooseUser(),
    ));
  }
}
