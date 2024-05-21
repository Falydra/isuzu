import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:isuzu/ui/shared/theme.dart';
import 'package:isuzu/services/crud.dart';

class DetailUser extends StatefulWidget {
  final Map<String, dynamic> userData;
  final VoidCallback onDataUpdated;

  const DetailUser({super.key, required this.userData, required this.onDataUpdated});
  


  @override
  State<DetailUser> createState() => _DetailUserState();
}

class _DetailUserState extends State<DetailUser> {
  late Future<List<dynamic>> userData;
  late Future<Map<String, dynamic>> oilCheckData;
  late Future<Map<String, dynamic>> sparepartCheckData;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final Map<String, dynamic> userData = widget.userData;
    oilCheckData = findUserOilCheck(userData['name']);
    sparepartCheckData = findUserSparePartCheck(userData['name']);
    double width(BuildContext context) => MediaQuery.of(context).size.width;
    double height(BuildContext context) => MediaQuery.of(context).size.height;


    return Scaffold(
      appBar: AppBar(
        title: const Text('Detail Pengguna'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context, "refresh");
          },
        ),
      ),
      body: SingleChildScrollView( //Need to be fixed
        child: Stack(
          children: [
            Container(
              width: MediaQuery.of(context).size.width,
              padding: EdgeInsets.all(width(context) * 0.05),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Nama',
                    style: TextStyle(fontSize: 16.0, color: Colors.grey),
                  ),
                  Text(
                    '${userData['name']}',
                    style: const TextStyle(
                      fontSize: 20.0,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                  const SizedBox(height: 16.0),
                  const Text(
                    'Nama Unit',
                    style: TextStyle(fontSize: 16.0, color: Colors.grey),
                  ),
                  Text(
                    '${userData['unit']}',
                    style: const TextStyle(
                      fontSize: 20.0,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                  const SizedBox(height: 16.0), //Need to be fixed
                  const Text(
                    'Nomor Telepon',
                    style: TextStyle(fontSize: 16.0, color: Colors.grey),
                  ),
                  Text(
                    '${userData['phone']}',
                    style: const TextStyle(
                      fontSize: 20.0,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                  const SizedBox(height: 16.0), //Need to be fixed
                  const Text(
                    'Terakhir Cek Rutin',
                    style: TextStyle(fontSize: 16.0, color: Colors.grey),
                  ),
                  Text(
                    ("${DateFormat('d MMM yyyy').format(
                      DateTime.parse(userData['last_routine_check']),
                    )} (${DateTime.now().difference(DateTime.parse(userData['last_routine_check'])).inDays} hari)"),
                    style: const TextStyle(
                      fontSize: 20.0,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                  SizedBox(height: height(context) * 0.05), //Need to be fixe
                  FutureBuilder<Map<String, dynamic>>(
                    future: oilCheckData,
                    builder: (BuildContext context,
                        AsyncSnapshot<Map<String, dynamic>> oilCheckSnapshot) {
                      if (oilCheckSnapshot.connectionState ==
                          ConnectionState.waiting) {
                        return const Center(child: CircularProgressIndicator());
                      } else if (oilCheckSnapshot.hasError) {
                        return Center(
                            child: Text('Error: ${oilCheckSnapshot.error}'));
                      } else {
                        final oilCheckData = oilCheckSnapshot.data!;
                        final lastService = oilCheckData['last_service'];
        
                        String lastServiceText;
        
                        if (lastService != null &&
                            lastService != '2000-01-01 00:00:00') {
                          lastServiceText = DateFormat('d MMM yyyy')
                              .format(DateTime.parse(lastService));
                        } else {
                          lastServiceText = 'Belum Tersedia';
                        }
                        return Card(
                          color: Colors.white,
                          surfaceTintColor: Colors.white,
                          child: Padding(
                            padding: const EdgeInsets.all(16.0), //Need to be fixed
                            child: Column(
                              children: [
                                ListTile(
                                    title: const Text(
                                      'Terakhir Cek Oli',
                                      style: TextStyle(fontSize: 16.0),
                                      textAlign: TextAlign.center,
                                    ),
                                    subtitle: Container(
                                      padding: const EdgeInsets.symmetric(
                                          vertical: 8.0), //Need to be fixed
                                      child: Text(
                                        lastServiceText,
                                        style: const TextStyle(
                                            fontSize: 20.0,
                                            fontWeight: FontWeight.w500),
                                        textAlign: TextAlign.center,
                                      ),
                                    )),
                                Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Container(
                                      child: ElevatedButton.icon(
                                        icon: const Icon(Icons.check,
                                            color: Colors.white),
                                        style: ElevatedButton.styleFrom(
                                          backgroundColor: isuzu500,
                                          shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(4.0),
                                          ),
                                        ),
                                        onPressed: () {
                                          updateLastOilCheck(userData['name'])
                                              .then((_) {
                                            setState(() {
                                              oilCheckData['last_service'] =
                                                  DateTime.now().toString();
                                            });
        
                                            widget.onDataUpdated();
                                          });
                                        },
                                        label: const Text(
                                          'Sudah Cek',
                                          style: TextStyle(color: Colors.white),
                                        ),
                                      ),
                                    ),
                                    const SizedBox(width: 16.0), //Need to be fixed
                                    Container(
                                      child: ElevatedButton.icon(
                                        icon: Icon(Icons.chat, color: isuzu500),
                                        onPressed: () {
                                          launchWhatsAppUri(
                                            userData['name'],
                                            userData['phone'],
                                            DateFormat('d MMM yyyy').format(
                                              DateTime.parse(
                                                  userData['last_routine_check']),
                                            ),
                                          );
                                        },
                                        style: ElevatedButton.styleFrom(
                                          shape: RoundedRectangleBorder(
                                            side: BorderSide(color: isuzu500),
                                            borderRadius:
                                                BorderRadius.circular(4.0),
                                          ),
                                        ),
                                        label: Text(
                                          'Chat',
                                          style: TextStyle(
                                              color: isuzu500, fontSize: 16),
                                        ),
                                      ),
                                    ),
                                  ],
                                )
                              ],
                            ),
                          ),
                        );
                      }
                    },
                  ),
                  const SizedBox(height: 16.0), //Need to be fixed
                  FutureBuilder<Map<String, dynamic>>(
                    future: sparepartCheckData,
                    builder: (BuildContext context,
                        AsyncSnapshot<Map<String, dynamic>>
                            sparepartCheckSnapshot) {
                      if (sparepartCheckSnapshot.connectionState ==
                          ConnectionState.waiting) {
                        return const Center(child: CircularProgressIndicator());
                      } else if (sparepartCheckSnapshot.hasError) {
                        return Center(
                          child: Text('Error: ${sparepartCheckSnapshot.error}'),
                        );
                      } else {
                        final sparepartCheckData = sparepartCheckSnapshot.data!;
                        final lastService = sparepartCheckData['last_service'];
        
                        String lastServiceText;
        
                        if (lastService != null &&
                            lastService != '2000-01-01 00:00:00') {
                          lastServiceText = DateFormat('d MMM yyyy')
                              .format(DateTime.parse(lastService));
                        } else {
                          lastServiceText = 'Belum Tersedia';
                        }
                        
                        return Card(
                          margin: EdgeInsets.only(bottom: width(context) * 0.15),
                          color: Colors.white,
                          surfaceTintColor: Colors.white,
                          child: Padding(
                            padding: EdgeInsets.all(width(context) * 0.035),
                            child: Column(
                              children: [
                                ListTile(
                                    title: const Text(
                                      'Terakhir Cek Suku Cadang',
                                      style: TextStyle(fontSize: 16.0),
                                      textAlign: TextAlign.center,
                                    ),
                                    subtitle: Container(
                                      padding: const EdgeInsets.symmetric(
                                          vertical: 8.0),
                                      child: Column(
                                        children: [
                                          Text(
                                            lastServiceText,
                                            style: const TextStyle(
                                                fontSize: 20.0,
                                                fontWeight: FontWeight.w500),
                                            textAlign: TextAlign.center,
                                          ),
                                          Text(
                                            'Keterangan: ${sparepartCheckData['type']}',
                                            style: const TextStyle(
                                                fontSize: 16.0,
                                                fontWeight: FontWeight.w400),
                                            textAlign: TextAlign.center,
                                          )
                                        ],
                                      ),
                                    )),
                                Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Container(
                                      child: ElevatedButton.icon(
                                        icon: const Icon(Icons.check,
                                            color: Colors.white),
                                        style: ElevatedButton.styleFrom(
                                          backgroundColor: isuzu500,
                                          shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(4.0),
                                          ),
                                        ),
                                        onPressed: () {
                                          updateLastSparepartCheck(
                                                  userData['name'])
                                              .then((_) {
                                            setState(() {
                                              sparepartCheckData['last_service'] =
                                                  DateTime.now().toString();
                                            });
        
                                            widget.onDataUpdated();
                                          });
                                        },
                                        label: const Text(
                                          'Sudah Cek',
                                          style: TextStyle(color: Colors.white),
                                        ),
                                      ),
                                    ),
                                    SizedBox(width: width(context) * 0.02), //Need to be fixed
                                    Container(
                                      child: ElevatedButton.icon(
                                        icon: Icon(Icons.chat, color: isuzu500),
                                        onPressed: () {
                                          launchWhatsAppUri(
                                            userData['name'],
                                            userData['phone'],
                                            DateFormat('d MMM yyyy').format(
                                              DateTime.parse(
                                                  userData['last_routine_check']),
                                            ),
                                          );
                                        },
                                        style: ElevatedButton.styleFrom(
                                          shape: RoundedRectangleBorder(
                                            side: BorderSide(color: isuzu500),
                                            borderRadius:
                                                BorderRadius.circular(4.0),
                                          ),
                                        ),
                                        label: Text(
                                          'Chat',
                                          style: TextStyle(
                                              color: isuzu500, fontSize: 16),
                                        ),
                                      ),
                                    ),
                                  ],
                                )
                              ],
                            ),
                          ),
                        );
                      }
                    },
                  ),
                ],
              ),
            ),
            Positioned(
              left: 0,
              right: 0,
              bottom: 0,
              child: Container(
                color: isuzu50,
                padding:
                    const EdgeInsets.symmetric(vertical: 12.0, horizontal: 16), //Need to be fixed
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Container(
                      child: ElevatedButton.icon(
                        icon: const Icon(Icons.check, color: Colors.white),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: isuzu500,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(4.0),
                          ),
                        ),
                        onPressed: () {
                          updateLastRoutineCheck(userData['name']).then((_) {
                            setState(() {
                              userData['last_routine_check'] =
                                  DateTime.now().toString();
                            });
        
                            widget.onDataUpdated();
                          });
                        },
                        label: const Text(
                          'Sudah Cek Rutin',
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                    ),
                    const SizedBox(width: 16.0), //Need to be fixed
                    Container(
                      child: ElevatedButton.icon(
                        icon: Icon(Icons.chat, color: isuzu500),
                        onPressed: () {
                          launchWhatsAppUri(
                            userData['name'],
                            userData['phone'],
                            DateFormat('d MMM yyyy').format(
                              DateTime.parse(userData['last_routine_check']),
                            ),
                          );
                        },
                        style: ElevatedButton.styleFrom(
                          shape: RoundedRectangleBorder(
                            side: BorderSide(color: isuzu500),
                            borderRadius: BorderRadius.circular(4.0),
                          ),
                        ),
                        label: Text(
                          'Chat',
                          style: TextStyle(color: isuzu500, fontSize: 16),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

//Fix build release by stop using Stack, Container, Positioned, TableCell, Listview, Flexible 
