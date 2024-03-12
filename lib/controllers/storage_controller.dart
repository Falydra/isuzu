import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class StorageControl extends GetxController {
  final storage = GetStorage();

  void data(String key, dynamic value) {
    storage.write(key, value);
  }

  dynamic getData(String key) {
    return storage.read(key);
  }
}

StorageControl storageControl = Get.put(StorageControl());
