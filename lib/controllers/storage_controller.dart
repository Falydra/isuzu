import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class StorageControl extends GetxController {
  final storage = GetStorage();

  Future<void> data(String key, dynamic value) async {
    try {
      await storage.write(key, value);
    } catch (e) {
      // Handle storage write error
      print("Error writing to storage: $e");
    }
  }

  dynamic getData(String key) {
    return storage.read(key);
  }
}

StorageControl storageControl = Get.put(StorageControl());
