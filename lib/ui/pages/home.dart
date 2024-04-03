import 'package:flutter/material.dart';
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
    userData = readUser2();
    print("userdata ${userData}");
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
                        print("userdata ${snapshot.data}");
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
                            print("snapshot ${snapshot.data}");
                        if (userList == null || userList.isEmpty) {
                          return const Text('No user data available.');
                        }

                        return ListView.builder(
                          shrinkWrap: true,
                          itemCount: userList.length,
                          itemBuilder: (context, index) {
                            final userData = userList[index];
                            final name = userData['name'] ?? '';
                            final phone = userData['phone'] ?? '';
                            return ListTile(
                              title: Text(name.toString()),
                              subtitle: Text(phone.toString()),
                              trailing: ElevatedButton(
                                onPressed: () {
                                  // _launchWhatsApp(phone, _defaultMessage);
                                },
                                child: const Text('Chat'),
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
