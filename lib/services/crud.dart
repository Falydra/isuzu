import 'package:isuzu/main.dart';
import 'dart:core';

Future<List<dynamic>> readUser() async {
  return supabase.from('user').select().execute().then((response) {
    print('RESPONSE $response');
    final List<dynamic> data = response.data;
    return data;
  });
}

Future<List<dynamic>> readUser2() async {
  final response = await supabase.from('user').select().execute();
  print('RESPONSE ${response.data}');
  return response.data;
}


