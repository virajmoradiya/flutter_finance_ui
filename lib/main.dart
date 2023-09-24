import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_finance_ui/screens/home_screen.dart';
import 'package:flutter_finance_ui/services/storage_helper.dart';
import 'package:flutter_finance_ui/utils/app_theme.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:get_storage/get_storage.dart';

Future<void> main() async {
  await GetStorage.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
        themeMode: StorageHelper().isDarkMode ? ThemeMode.dark : ThemeMode.light,
        darkTheme: AppTheme.darkTheme,
        theme: AppTheme.lightTheme,
        debugShowCheckedModeBanner: false,
        home: const HomeScreenUI());
  }
}
