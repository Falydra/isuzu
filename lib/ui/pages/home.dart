import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:isuzu/ui/pages/detail_user.dart';
import 'package:isuzu/ui/shared/theme.dart';
import 'package:isuzu/services/crud.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late Future<List<dynamic>> userData;
  TextEditingController searchController = TextEditingController();
  String? selectedCategory = "Filter";

  @override
  void initState() {
    super.initState();
    userData = readUser();
  }

  void refreshData() {
    setState(() {
      userData = readUser();
    });
  }

  double width(BuildContext context) => MediaQuery.of(context).size.width;
  double height(BuildContext context) => MediaQuery.of(context).size.height;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Isuzu Bengkel'),
        surfaceTintColor: Colors.white,
      ),
      body: Column(
        children: [
          Padding(
            padding:
                const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
            child: Row(
              children: [
                Expanded(
                  flex: 3,
                  child: Container(
                    height: 40.0,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(8.0),
                      border:
                          Border.all(color: Colors.grey.shade300, width: 1.0),
                    ),
                    child: TextField(
                      controller: searchController,
                      decoration: const InputDecoration(
                        hintText: 'Search',
                        border: InputBorder.none,
                        prefixIcon: Icon(Icons.search),
                      ),
                      style: const TextStyle(fontSize: 16.0),
                      onChanged: (value) {
                        setState(() {});
                      },
                      onSubmitted: (value) {
                        setState(() {});
                      },
                    ),
                  ),
                ),
                const SizedBox(width: 16.0),
                Expanded(
                  flex: 1,
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 8.0),
                    height: 40.0,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(8.0),
                      border:
                          Border.all(color: Colors.grey.shade300, width: 1.0),
                    ),
                    child: DropdownButton<String>(
                      value: selectedCategory,
                      onChanged: (String? newValue) {
                        setState(() {
                          selectedCategory = newValue;
                        });
                      },
                      style: const TextStyle(
                        color: Colors.black,
                        fontSize: 16.0,
                      ),
                      icon: const Icon(Icons.arrow_drop_down),
                      iconEnabledColor: Colors.black,
                      elevation: 0,
                      dropdownColor: isuzu50,
                      underline: const SizedBox(),
                      items: <String>['Filter', 'Elf', 'Traga', 'Giga']
                          .map<DropdownMenuItem<String>>((String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Container(
                            alignment: Alignment.center,
                            height: 56.0,
                            child: Text(
                              value,
                              style: const TextStyle(fontSize: 16.0),
                            ),
                          ),
                        );
                      }).toList(),
                    ),
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: CustomScrollView(
              slivers: <Widget>[
                SliverPadding(
                  padding: const EdgeInsets.only(top: 8.0),
                  sliver: FutureBuilder<List<dynamic>>(
                    future: userData,
                    builder: (context, AsyncSnapshot<List<dynamic>> snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return const SliverToBoxAdapter(
                          child: Center(
                            child: CircularProgressIndicator(
                              strokeWidth: 2.0,
                            ),
                          ),
                        );
                      } else if (snapshot.hasError) {
                        return SliverToBoxAdapter(
                          child: Text('Error: ${snapshot.error}'),
                        );
                      } else {
                        final List<dynamic>? userList = snapshot.data;
                        if (userList == null || userList.isEmpty) {
                          return const SliverToBoxAdapter(
                            child: Text('No user data available.'),
                          );
                        }

                        List<dynamic> filteredUserList = userList.where((user) {
                          if (selectedCategory == null ||
                              selectedCategory == 'Filter') {
                            return true;
                          } else {
                            return user['unit'] == selectedCategory;
                          }
                        }).toList();

                        if (searchController.text.isNotEmpty) {
                          filteredUserList = filteredUserList.where((user) {
                            final name = user['name'].toString().toLowerCase();
                            final query = searchController.text.toLowerCase();
                            return name.contains(query);
                          }).toList();
                        }

                        return SliverList(
                          delegate: SliverChildBuilderDelegate(
                            (context, index) {
                              final userData = filteredUserList[index];
                              final name = userData['name'] ?? '';
                              final lastServiceDate = DateTime.parse(
                                  userData['last_routine_check']);
                              final dateFormatted = DateFormat('d MMM yyyy')
                                  .format(DateTime.parse(
                                      userData['last_routine_check']));
                              final daysSinceLastService = DateTime.now()
                                  .difference(lastServiceDate)
                                  .inDays;
                              final date =
                                  "Terakhir: ${dateFormatted.toString()} ($daysSinceLastService hari)";
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
                                    size: 28,
                                  ),
                                ),
                                title: Text(
                                  name.toString(),
                                  style: const TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w500),
                                  overflow: TextOverflow.ellipsis,
                                  maxLines: 1,
                                  softWrap: false,
                                ),
                                subtitle: Text(date.toString(),
                                    style: const TextStyle(fontSize: 16)),
                                onTap: () async {
                                  String refresh = await Navigator.push(context,
                                      MaterialPageRoute(builder: (context) {
                                    return DetailUser(
                                      userData: userData,
                                      onDataUpdated: () {},
                                    );
                                  }));
                                  if (refresh == 'refresh') {
                                    refreshData();
                                  }
                                },
                                trailing: ElevatedButton(
                                  onPressed: () {
                                    launchWhatsAppUri(
                                        name, phone, dateFormatted);
                                  },
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: isuzu500,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(4.0),
                                    ),
                                  ),
                                  child: const Text('Chat',
                                      style: TextStyle(
                                          color: Colors.white, fontSize: 16)),
                                ),
                              );
                            },
                            childCount: filteredUserList.length,
                          ),
                        );
                      }
                    },
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
