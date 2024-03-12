import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:isuzu/ui/widgets/alerts.dart';
import '../controllers/storage_controller.dart';
import '../main.dart';

void userAuth(BuildContext context, email, String password) async {
  try {
    AuthResponse response = await supabase.auth
        .signInWithPassword(email: email, password: password);
    if (response.user != null) {
      Navigator.pushReplacementNamed(context, '/home-page');
      List<String> parts = email.split('@');
      String username = parts[0];
      storageControl.data('uid', username);
    }
  } catch (e) {
    showAlerts(context, e.toString());
  }
}
