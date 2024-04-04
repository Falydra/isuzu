import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:isuzu/ui/shared/theme.dart';
import 'package:isuzu/services/crud.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late Future<List<dynamic>> userData;

  @override
  void initState() {
    super.initState();
    userData = readUser();
  }

  double width(BuildContext context) => MediaQuery.of(context).size.width;
  double height(BuildContext context) => MediaQuery.of(context).size.height;

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
                  FutureBuilder<List<dynamic>>(
                    future: userData,
                    builder: (context,
                        AsyncSnapshot<List<dynamic>> snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return const Center(
                          child: CircularProgressIndicator(
                            strokeWidth: 2.0,
                          ),
                        );
                      } else if (snapshot.hasError) {
                        return Text('Error: ${snapshot.error}');
                      } else {
                        final List<dynamic>? userList =
                            snapshot.data;
                        if (userList == null || userList.isEmpty) {
                          return const Text('No user data available.');
                        }

                        return ListView.builder(
                          shrinkWrap: true,
                          itemCount: userList.length,
                          itemBuilder: (context, index) {
                            final userData = userList[index];
                            final name = userData['name'] ?? '';
                            final dateFormatted = DateFormat('d MMM yyyy').format(DateTime.parse(userData['last_routine_check']));
                            final date = "Terakhir cek: ${dateFormatted.toString()}";
                            final phone = userData['phone'];
                            return ListTile(
                              title: Text(name.toString(), style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w500), overflow: TextOverflow.ellipsis, maxLines: 1, softWrap: false,),
                              subtitle: Text(date.toString(), style: const TextStyle(fontSize: 16)),
                              onTap: () {
                                Navigator.pushNamed(context, '/detail-user', arguments: userData);
                              },
                              trailing: ElevatedButton(
                                onPressed: () {
                                  launchWhatsAppUri(name, phone, dateFormatted);
                                },
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: isuzu500,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(4.0),
                                  ),
                                ),
                                child: const Text('Chat', style: TextStyle(color: Colors.white, fontSize: 16)),
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
