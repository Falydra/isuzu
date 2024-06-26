import 'package:isuzu/ui/pages/home.dart';
import 'package:isuzu/ui/pages/login.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:flutter/material.dart';
import 'package:isuzu/ui/pages/splash.dart';
import 'dart:async';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:isuzu/ui/widgets/navigation.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await dotenv.load(fileName: ".env");

  await Supabase.initialize(
    url: "https://dcvbcptpncktkldscxmf.supabase.co",
    anonKey: "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6ImRjdmJjcHRwbmNrdGtsZHNjeG1mIiwicm9sZSI6ImFub24iLCJpYXQiOjE3MDk5NjIwMTIsImV4cCI6MjAyNTUzODAxMn0.IdrVMHLGNSCJF4MEuQOGI7TmWShcA31K_H5y9hXG2PU",
    authFlowType: AuthFlowType.pkce,
  );

  runApp(const MyApp());
}

final supabase = Supabase.instance.client;

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        color: const Color(0xFF202525),
        debugShowCheckedModeBanner: false,
        routes: {
          '/': (context) => const SplashWrapper(),
          '/login-page': (context) => LoginPage(
                controller: TextEditingController(),
              ),
          '/home-page': (context) => const HomePage(),
          '/navigation-menu': (context) => const NavigationMenu(),
        });
  }
}
