import 'package:flutter/material.dart';
import 'package:whatsapp_unilink/whatsapp_unilink.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:isuzu/main.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final _future = supabase.from('user').select();
  
  double width(BuildContext context) => MediaQuery.of(context).size.width;
  double height(BuildContext context) => MediaQuery.of(context).size.height;

  // String _defaultMessage = "Hai, mau tanya tentang layanan Anda.";

  // Future<void> _launchWhatsApp(String phoneNumber, String message) async {
  //   final link = WhatsAppUnilink(
  //     phoneNumber: phoneNumber,
  //     text: message,
  //   );
  //   await launchUrl(link.asUri());
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Isuzu Bengkel'),
      ),
      body: CustomScrollView(
        slivers: <Widget>[
          SliverPadding(
            padding: const EdgeInsets.only(top: 8.0),
            sliver: SliverList(
              delegate: SliverChildListDelegate(
                [
                  FutureBuilder(
                    future: _future,
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return const Center(child: CircularProgressIndicator());
                      } else if (snapshot.hasError) {
                        print('Error: ${snapshot.error}');
                        return Center(child: Text('Error: ${snapshot.error}'));
                      } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                        return const Center(
                            child: Text('Tidak ada yang tersedia'));
                      } else {
                        final users = snapshot.data!;

                        return ListView.builder(
                          shrinkWrap: true,
                          itemCount: snapshot.data!.length,
                          itemBuilder: (context, index) {
                            final userData = users[index];
                            print(userData);
                            final name = userData['name'] ?? '';
                            final phone = userData['phone'] ?? '';
                            print(userData);
                            return ListTile(
                              title: Text(name),
                              subtitle: Text(phone),
                              trailing: ElevatedButton(
                                onPressed: () {
                                  // _launchWhatsApp(phone, _defaultMessage);
                                },
                                child: Text('Chat'),
                              ),
                            );
                          },
                        );
                      }
                    },
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
