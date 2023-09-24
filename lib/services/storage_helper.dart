import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class StorageHelper {
  final box = GetStorage();

  updateTheme(bool isDarkMode) {
    box.write("isDarkMode", isDarkMode);
  }

  bool get isDarkMode {
    return box.read("isDarkMode") ?? Get.isDarkMode;
  }
}
