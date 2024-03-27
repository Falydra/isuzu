import 'package:flutter/material.dart';
import 'package:whatsapp_unilink/whatsapp_unilink.dart';
import 'package:url_launcher/url_launcher.dart';

class CategoryPage extends StatelessWidget {
  const CategoryPage({super.key});

  double width(BuildContext context) => MediaQuery.of(context).size.width;
  double height(BuildContext context) => MediaQuery.of(context).size.height;

  @override
  Widget build(BuildContext context) {
    String defaultMessage = "Hai, mau tanya tentang layanan Anda.";

    Future<void> launchWhatsApp(String phoneNumber, String message) async {
      final link = WhatsAppUnilink(
        phoneNumber: phoneNumber,
        text: message,
      );
      await launchUrl(link.asUri());
    }

    return Scaffold(
      body: SafeArea(
          child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
              margin: EdgeInsets.only(top: height(context) * 0.02),
              child: const Text("Pilih Layanan / Jenis Perawatan")),
          Container(
            alignment: Alignment.center,
            margin: EdgeInsets.only(
                top: height(context) * 0.05, bottom: height(context) * 0.02),
            child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    backgroundColor: const Color(0xFFff0404),
                    fixedSize:
                        Size(width(context) * 0.8, height(context) * 0.07)),
                onPressed: () {
                  launchWhatsApp("6285900363157", defaultMessage);
                },
                child: const Text(
                  "Penggantian Oli",
                  style: TextStyle(
                      color: Colors.white, fontWeight: FontWeight.w600),
                )),
          ),
        ],
      )),
    );
  }
}
