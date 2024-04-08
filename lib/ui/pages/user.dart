import 'package:flutter/material.dart';
import 'package:isuzu/services/crud.dart';
import 'package:isuzu/ui/shared/theme.dart';
import 'package:flutter_datetime_picker_plus/flutter_datetime_picker_plus.dart'
    as date_picker;

class UserPage extends StatefulWidget {
  const UserPage({super.key});

  @override
  State<UserPage> createState() => _UserPageState();
}

class _UserPageState extends State<UserPage> {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  String? selectedUnit;
  DateTime? lastRoutineCheck;
  DateTime? lastOilService;
  DateTime? lastSparepartService;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    nameController.dispose();
    phoneController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Input Pengguna'),
          bottom: TabBar(
            indicatorColor: isuzu500,
            labelColor: isuzu500,
            labelStyle:
                const TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
            tabs: const [
              Tab(text: 'Upload Single'),
              Tab(text: 'Upload Bulk'),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            _buildUploadSingleTab(),
            _buildUploadBulkTab(),
          ],
        ),
      ),
    );
  }

  Widget _buildUploadSingleTab() {
    return SingleChildScrollView(
      child: Container(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              TextFormField(
                controller: nameController,
                decoration: const InputDecoration(labelText: 'Nama Pelanggan'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Nama tidak boleh kosong';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: phoneController,
                decoration: const InputDecoration(labelText: 'Nomor Whatsapp'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Nomor Whatsapp tidak boleh kosong';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),
              DropdownButtonFormField<String>(
                value: selectedUnit,
                decoration: const InputDecoration(labelText: 'Nama Unit'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Unit tidak boleh kosong';
                  }
                  return null;
                },
                onChanged: (value) {
                  setState(() {
                    selectedUnit = value;
                  });
                },
                items: ['Elf', 'Traga', 'Giga'].map((unit) {
                  return DropdownMenuItem<String>(
                    value: unit,
                    child: Text(unit),
                  );
                }).toList(),
              ),
              const SizedBox(height: 16),
              Row(
                children: [
                  Expanded(
                    child: ElevatedButton.icon(
                      icon: Icon(Icons.calendar_month_outlined,
                          color: isuzu500),
                      style: ElevatedButton.styleFrom(
                        shape: RoundedRectangleBorder(
                          side: BorderSide(color: isuzu500),
                          borderRadius: BorderRadius.circular(4.0),
                        ),
                      ),
                      onPressed: () {
                        date_picker.DatePicker.showDatePicker(
                          context,
                          showTitleActions: true,
                          onChanged: (date) {
                            setState(() {
                              lastRoutineCheck = date;
                            });
                          },
                          currentTime: DateTime.now(),
                        );
                      },
                      label: Text('Tanggal Terakhir Cek Rutin',
                          style: TextStyle(color: isuzu500)),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              Row(
                children: [
                  Expanded(
                    child: ElevatedButton.icon(
                      icon: Icon(Icons.calendar_month_outlined,
                          color: isuzu500),
                      style: ElevatedButton.styleFrom(
                        shape: RoundedRectangleBorder(
                          side: BorderSide(color: isuzu500),
                          borderRadius: BorderRadius.circular(4.0),
                        ),
                      ),
                      onPressed: () {
                        date_picker.DatePicker.showDatePicker(
                          context,
                          showTitleActions: true,
                          onChanged: (date) {
                            setState(() {
                              lastOilService = date;
                            });
                          },
                          currentTime: DateTime.now(),
                        );
                      },
                      label: Text('Tanggal Terakhir Cek Oli',
                          style: TextStyle(color: isuzu500)),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              Row(
                children: [
                  Expanded(
                    child: ElevatedButton.icon(
                      icon: Icon(Icons.calendar_month_outlined,
                          color: isuzu500),
                      style: ElevatedButton.styleFrom(
                        shape: RoundedRectangleBorder(
                          side: BorderSide(color: isuzu500),
                          borderRadius: BorderRadius.circular(4.0),
                        ),
                      ),
                      onPressed: () {
                        date_picker.DatePicker.showDatePicker(
                          context,
                          showTitleActions: true,
                          onChanged: (date) {
                            setState(() {
                              lastSparepartService = date;
                            });
                          },
                          currentTime: DateTime.now(),
                        );
                      },
                      label: Text('Tanggal Terakhir Service Sparepart',
                          style: TextStyle(color: isuzu500)),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              Row(
                children: [
                  Expanded(
                    child: ElevatedButton(
                      onPressed: () {
                        if (_formKey.currentState!.validate()) {
                          _submitForm();
                        }
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: isuzu500,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(4.0),
                        ),
                      ),
                      child: const Text('Submit',
                          style: TextStyle(color: Colors.white)),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildUploadBulkTab() {
    return SingleChildScrollView(
      child: Container(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const Text(
              'Upload file excel anda disini',
              style: TextStyle(fontSize: 16),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 16),
            Row(
              children: [
                Expanded(
                  child: ElevatedButton.icon(
                    icon: const Icon(Icons.file_upload_outlined,
                        color: Colors.white),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: isuzu500,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(4.0),
                      ),
                    ),
                    onPressed: () {},
                    label: const Text('Pilih file',
                        style: TextStyle(color: Colors.white)),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  void _submitForm() async {
    if (lastRoutineCheck == null) {
      showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: const Text('Error'),
            content: const Text('Tanggal terakhir cek rutin harus diisi.'),
            actions: <Widget>[
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: const Text('OK'),
              ),
            ],
          );
        },
      );
      return;
    }

    final user = {
      'name': nameController.text,
      'phone': phoneController.text,
      'unit': selectedUnit,
      'last_routine_check': lastRoutineCheck?.toIso8601String(),
    };
    final oilCheck = {
      'name': nameController.text,
      'last_service': lastOilService?.toIso8601String(),
    };
    final sparepartCheck = {
      'name': nameController.text,
      'last_service': lastSparepartService?.toIso8601String(),
    };

    await addUser(user);
    await addOilCheck(oilCheck);
    await addSparepartCheck(sparepartCheck);

    nameController.clear();
    phoneController.clear();
    setState(() {
      selectedUnit = null;
      lastRoutineCheck = null;
      lastOilService = null;
      lastSparepartService = null;
    });
  }
}
