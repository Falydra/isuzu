import 'package:isuzu/main.dart';
import 'dart:core';
import 'package:url_launcher/url_launcher.dart';

Future<List<dynamic>> readUser() async {
  final response = await supabase.from('user').select().order('last_routine_check', ascending: true);
  return response;
}

Future<List<dynamic>> fetchOilData() async {
  final response = await supabase.from('oil_check').select();
  return response;
}

Future<List<dynamic>> fetchSparepartData() async {
  final response = await supabase.from('sparepart_check').select();
  return response;
}

Future<Map<String, dynamic>> findUser(String name) async {
  final response =
      await supabase.from('user').select().eq('name', name).single();
  return response;
}

Future<Map<String, dynamic>> findUserOilCheck(String name) async {
  final response =
      await supabase.from('oil_check').select().eq('name', name).single();
  return response;
}

Future<Map<String, dynamic>> findUserSparePartCheck(String name) async {
  final response =
      await supabase.from('sparepart_check').select().eq('name', name).single();
  return response;
}

Future<void> addUser(Map<String, dynamic> user) async {
  final response = await supabase.from('user').upsert(user);
  return response;
}

Future<void> addOilCheck(Map<String, dynamic> oilCheck) async {
  final response = await supabase.from('oil_check').upsert(oilCheck);
  return response;
}

Future<void> addSparepartCheck(Map<String, dynamic> sparePartCheck) async {
  final response =
      await supabase.from('sparepart_check').upsert(sparePartCheck);
  return response;
}

Future<void> updateLastRoutineCheck(String name) async {
  DateTime now = DateTime.now();

  String formattedDate = now.toIso8601String();

  final response = await supabase.from('user').update({
    'last_routine_check': formattedDate,
  }).eq('name', name);
  return response;
}

Future<void> updateLastOilCheck(String name) async {
  DateTime now = DateTime.now();

  String formattedDate = now.toIso8601String();

  final response = await supabase.from('oil_check').update({
    'last_service': formattedDate,
  }).eq('name', name);
  return response;
}

Future<void> updateLastSparepartCheck(String name) async {
  DateTime now = DateTime.now();

  String formattedDate = now.toIso8601String();

  final response = await supabase.from('sparepart_check').update({
    'last_service': formattedDate,
  }).eq('name', name);
  return response;
}

launchWhatsAppUri(String name, String phone, String date) async {
  final message =
      "Yth. Bapak/Ibu $name\nKami dari pihak Isuzu ingin ingin mengingatkan bahwa terakhir kali anda melakukan service adalah pada tanggal *$date*.\n\nJadi kami ingin mengingatkan anda untuk melakukan service rutin kembali.\n\nTerima kasih,\nIsuzu Bengkel";

  final Uri uri =
      Uri.parse("https://api.whatsapp.com/send?phone=$phone&text=$message");

  await launchUrl(uri);
}
