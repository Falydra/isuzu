import 'package:flutter/material.dart';
import 'dart:async';
import 'package:isuzu/ui/pages/login.dart';

class SplashWrapper extends StatefulWidget {
  const SplashWrapper({super.key});
  @override
  _SplashWrapperState createState() => _SplashWrapperState();
}

class _SplashWrapperState extends State<SplashWrapper> {
  @override
  void initState() {
    super.initState();

    Timer(const Duration(seconds: 2), () {
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(
            builder: (context) => LoginPage(
                  controller: TextEditingController(),
                )),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return const SplashScreen();
  }
}

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});
  double width(BuildContext context) => MediaQuery.of(context).size.width;
  double height(BuildContext context) => MediaQuery.of(context).size.height;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: Center(
        child: Container(
          height: width(context) * 0.25,
          width: width(context) * 0.25,
          child: const Image(
            image:
                AssetImage('assets/images/Isuzu-logo-1991-3840x2160.png'),
            fit: BoxFit.fill,
          ),
        ),
      )),
    );
  }
}
