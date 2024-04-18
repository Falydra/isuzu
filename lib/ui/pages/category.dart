import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:isuzu/services/crud.dart';
import 'package:isuzu/ui/shared/theme.dart';

class CategoryPage extends StatefulWidget {
  final VoidCallback onDataUpdated;

  const CategoryPage({super.key, required this.onDataUpdated});

  @override
  State<CategoryPage> createState() => _CategoryPageState();
}

class _CategoryPageState extends State<CategoryPage> {
  late Future<List<dynamic>> userData;

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2, 
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Kategori Service'),
          bottom: TabBar(
            indicatorColor: isuzu500,
            labelColor: isuzu500,
            labelStyle:
                const TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
            tabs: const [
              Tab(text: 'Pengecekan Oli'),
              Tab(text: 'Pengecekan Sparepart'),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            buildCategoryList('Pengecekan Oli'),
            buildCategoryList('Pengecekan Sparepart'),
          ],
        ),
      ),
    );
  }

  Widget buildCategoryList(String categoryTitle) {
    Future<List<dynamic>> fetchData;
    if (categoryTitle == 'Pengecekan Oli') {
      fetchData = fetchOilData();
    } else {
      fetchData = fetchSparepartData();
    }

    return FutureBuilder<List<dynamic>>(
      future: fetchData,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return Center(child: Text('Error: ${snapshot.error}'));
        } else {
          final List<dynamic> data = snapshot.data!;
          return ListView.builder(
            itemCount: data.length,
            itemBuilder: (context, index) {
              final name = data[index]['name'];
              var lastService = data[index]['last_service'];
              String lastServiceText;

              if (lastService != null && lastService != '2000-01-01 00:00:00') {
                lastServiceText = "${DateFormat('d MMM yyyy').format(
                  DateTime.parse(lastService),
                )} (${DateTime.now().difference(DateTime.parse(lastService)).inDays} hari)";
              } else {
                lastServiceText = 'Belum pernah service';
              }

              return FutureBuilder(
                future: findUser(name),
                builder: (context, userSnapshot) {
                  if (userSnapshot.connectionState == ConnectionState.waiting) {
                    return const SizedBox.shrink();
                  } else if (userSnapshot.hasError) {
                    return Text('Error: ${userSnapshot.error}');
                  } else {
                    final userData = userSnapshot.data;
                    if (userData == null) {
                      return Text('User dengan nama $name tidak ditemukan.');
                    }

                    final phone = userData['phone'];
                    IconData iconData;
                    Color iconColor;
                    switch (userData['unit']) {
                      case 'Elf':
                        iconData = Icons.directions_bus;
                        iconColor = Colors.blue;
                        break;
                      case 'Traga':
                        iconData = Icons.local_shipping;
                        iconColor = Colors.green;
                        break;
                      case 'Giga':
                        iconData = Icons.fire_truck;
                        iconColor = Colors.orange;
                        break;
                      default:
                        iconData = Icons.error;
                        iconColor = Colors.grey;
                    }

                    return ListTile(
                      leading: CircleAvatar(
                        backgroundColor: iconColor,
                        child: Icon(
                          iconData,
                          color: Colors.white,
                        ),
                      ),
                      title: Text(
                        name.toString(),
                        style: const TextStyle(
                            fontSize: 18, fontWeight: FontWeight.w500),
                        overflow: TextOverflow.ellipsis,
                        maxLines: 1,
                        softWrap: false,
                      ),
                      subtitle: Text(lastServiceText,
                          style: const TextStyle(fontSize: 16)),
                      trailing: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          IconButton(
                              icon: const Icon(Icons.check),
                              iconSize: 24,
                              onPressed: () {
                                if (categoryTitle == "Pengecekan Oli") {
                                  updateLastOilCheck(userData['name'])
                                      .then((_) {
                                    setState(() {
                                      lastService = DateTime.now().toString();
                                    });

                                    widget.onDataUpdated();
                                  });
                                } else {
                                  updateLastSparepartCheck(userData['name'])
                                      .then((_) {
                                    setState(() {
                                      lastService = DateTime.now().toString();
                                    });

                                    widget.onDataUpdated();
                                  });
                                }
                              },
                              style: ButtonStyle(
                                  side: MaterialStateProperty.all(
                                      BorderSide(color: isuzu500, width: 1)),
                                  foregroundColor:
                                      MaterialStateProperty.all(isuzu500),
                                  shape: MaterialStateProperty.all(
                                      OutlinedBorder.lerp(
                                          RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(4),
                                          ),
                                          RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(4),
                                          ),
                                          1)))),
                          IconButton(
                              icon: const Icon(Icons.chat),
                              iconSize: 24,
                              onPressed: () {
                                if (categoryTitle == 'Pengecekan Oli') {
                                  launchWhatsAppUriOil(
                                      name, phone, lastServiceText);
                                } else {
                                  launchWhatsAppUriSparepart(
                                      name, phone, lastServiceText);
                                }
                              },
                              style: ButtonStyle(
                                  backgroundColor:
                                      MaterialStateProperty.all(isuzu500),
                                  foregroundColor:
                                      MaterialStateProperty.all(Colors.white),
                                  shape: MaterialStateProperty.all(
                                      OutlinedBorder.lerp(
                                          RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(4),
                                          ),
                                          RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(4),
                                          ),
                                          1)))),
                        ],
                      ),
                    );
                  }
                },
              );
            },
          );
        }
      },
    );
  }
}
