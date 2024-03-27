import 'package:isuzu/main.dart';
import 'dart:core';

Future<List<Map<String, dynamic>>> readUser() async {
  return supabase.from('user').select().then((response) {
    print('RESPONSE $response');
    final List<Map<String,dynamic>> data = response;
    return data as List<Map<String, dynamic>>;
  });
}

Future<List<dynamic>> readUser2() async {
  final response = await supabase.from('user').select().execute();
  print('RESPONSE ${response.data}');
  return response.data;
}

