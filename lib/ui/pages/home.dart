import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  double width(BuildContext context) => MediaQuery.of(context).size.width;
  double height(BuildContext context) => MediaQuery.of(context).size.height;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: Column(
        children: [
          Container(
              margin: EdgeInsets.only(top: height(context) * 0.02),
              child: Text("Pilih Layanan / Jenis Perawatan")),
          Container(
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
                  return;
                },
                child: const Text(
                  "Penggantian Oli",
                  style: TextStyle(
                      color: Colors.white, fontWeight: FontWeight.w600),
                )),
          ),
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
                  return;
                },
                child: const Text(
                  "Pemeriksaan rem",
                  style: TextStyle(
                      color: Colors.white, fontWeight: FontWeight.w600),
                )),
          ),
          Container(
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
                  return;
                },
                child: const Text(
                  "Penggantian Filter Udara",
                  style: TextStyle(
                      color: Colors.white, fontWeight: FontWeight.w600),
                )),
          ),
        ],
      )),
    );
  }
}
