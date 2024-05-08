import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import '../controllers/storage_controller.dart';
import '../main.dart';

void userAuth( context, email, String password) async {
  try {
    AuthResponse response = await supabase.auth
        .signInWithPassword(email: email, password: password);
    if (response.user != null) {
      Navigator.pushReplacementNamed(context, '/navigation-menu');
      List<String> parts = email.split('@');
      String username = parts[0];
      storageControl.data('uid', username);
    }
  } catch (e) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text("Error"),
        content: const Text("Excpecteed Error, Try Again"),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text("Ingfo diterima"),
          ),
        ],
      ),
    );
  }
}

void registerAuth(
   context,
  String email,
  String password,
) async {
  try {
    List<String> parts = email.split('@');
    String username = parts[0];
    AuthResponse res = await supabase.auth
        .signUp(email: email, password: password, data: {'username': username});
    if (res.user != null) {
      Navigator.pushReplacementNamed(context, '/login-page');
    }
  } catch (e) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text("Error"),
        content: const Text("Excpecteed Error, Try Again"),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text("Ingfo diterima"),
          ),
        ],
      ),
    );
  }
}
