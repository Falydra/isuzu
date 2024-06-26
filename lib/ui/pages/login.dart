import 'package:flutter/material.dart';
import 'package:isuzu/services/auth.dart';

import 'package:isuzu/ui/pages/register.dart';

class LoginPage extends StatefulWidget {
  final TextEditingController? controller;
  const LoginPage({super.key, required this.controller});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  bool showPassword = false;
  double width(BuildContext context) => MediaQuery.of(context).size.width;
  double height(BuildContext context) => MediaQuery.of(context).size.height;

  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  void initState() {
    super.initState();
    showPassword = false;
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
            child: Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Container(
          margin: EdgeInsets.only(
            top: width(context) * 0.15,
          ),
          width: width(context) * 0.35,
          child: const Image(
            image: AssetImage('assets/images/Isuzu-logo-1991-3840x2160.png'),
            fit: BoxFit.cover,
          ),
        ),
        Row(
          children: [
            Container(
                margin: EdgeInsets.only(left: width(context) * 0.1),
                child: const Text("Email")),
          ],
        ),
        Container(
          margin: EdgeInsets.only(
              left: width(context) * 0.1,
              right: width(context) * 0.1,
              bottom: height(context) * 0.02,
              top: height(context) * 0.01),
          child: TextField(
            controller: _emailController,
            decoration: InputDecoration(
                enabledBorder:
                    OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
                focusedBorder:
                    OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
                hintText: "Masukkan Email"),
          ),
        ),
        Row(
          children: [
            Container(
                margin: EdgeInsets.only(left: width(context) * 0.1),
                child: const Text("Password")),
          ],
        ),
        Container(
          margin: EdgeInsets.only(
              left: width(context) * 0.1,
              right: width(context) * 0.1,
              top: height(context) * 0.01),
          child: TextField(
            controller: _passwordController,
            obscureText: !showPassword,
            decoration: InputDecoration(
                enabledBorder:
                    OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
                focusedBorder:
                    OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
                hintText: "Masukkan Password",
                suffixIcon: IconButton(
                    onPressed: () {
                      setState(() {
                        showPassword = !showPassword;
                      });
                    },
                    icon: Icon(showPassword
                        ? Icons.visibility
                        : Icons.visibility_off))),
            keyboardType: TextInputType.visiblePassword,
            textInputAction: TextInputAction.done,
          ),
        ),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: height(context) * 0.05, vertical: height(context) * 0.04),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                Container(
                  child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                          backgroundColor: const Color(0xFFff0404),
                          fixedSize: Size(
                              width(context) * 0.8, height(context) * 0.07)),
                      onPressed: () {
                        userAuth(context, _emailController.text.trim(),
                            _passwordController.text.trim());
                      },
                      child: const Text(
                        "Login",
                        style: TextStyle(
                            color: Colors.white, fontWeight: FontWeight.w600),
                      )),
                )
              ]),
              const SizedBox(height: 8),
              const Text("Belum Punya Akun?"),
              const SizedBox(height: 8),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                Center(
                  child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                          backgroundColor: const Color(0xFFff0404),
                          fixedSize: Size(
                              width(context) * 0.8, height(context) * 0.07)),
                      onPressed: () => Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const RegisterPage())),
                      child: const Text(
                        "Daftar",
                        style: TextStyle(
                            color: Colors.white, fontWeight: FontWeight.w600),
                      )),
                )
              ]),
            ],
          ),
        ),
      ],
    )));
  }
}
