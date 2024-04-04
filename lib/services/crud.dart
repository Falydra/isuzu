import 'package:isuzu/main.dart';
import 'dart:core';
import 'package:url_launcher/url_launcher.dart';

Future<List<dynamic>> readUser() async {
  final response = await supabase.from('user').select();
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

launchWhatsAppUri(String name, String phone, String date) async {
  final message =
      "Yth. Bapak/Ibu $name\nKami dari pihak Isuzu ingin ingin mengingatkan bahwa terakhir kali anda melakukan service adalah pada tanggal *$date*.\n\nJadi kami ingin mengingatkan anda untuk melakukan service rutin kembali.\n\nTerima kasih,\nIsuzu Bengkel";

  final Uri uri =
      Uri.parse("https://api.whatsapp.com/send?phone=$phone&text=$message");

  await launchUrl(uri);
}
