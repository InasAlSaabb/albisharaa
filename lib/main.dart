import 'package:albisharaa/app/my_app.dart';
import 'package:albisharaa/app/my_app_controller.dart';
import 'package:albisharaa/core/data/reposotories/shared_prefernces.dart';
import 'package:albisharaa/core/services/connectivity_service.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Get.putAsync<SharedPreferences>(() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs;
  });
  Get.put(SharedPrefrenceRepostory());
  Get.put(ConnectivityService());
  Get.put(MyAppController());
  runApp(MyApp());
}

extension emptypadding on num {
  SizedBox get ph => SizedBox(
        height: toDouble(),
      );
  SizedBox get pw => SizedBox(
        height: toDouble(),
      );
}

extension ExtendedNavigator on BuildContext {
  Future<dynamic> push(Widget page) async {
    Navigator.push(this, MaterialPageRoute(builder: (_) => page));
  }

  // Future<dynamic> pushReplacement(Widget page)async{
  //   Navigator.pushReplacement(this, MaterialPageRoute(builder: (_)=>page));
  // }
  void pop(Widget page, [result]) async {
    return Navigator.of(this).pop(result);
  }
}
