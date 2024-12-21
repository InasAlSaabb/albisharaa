import 'dart:convert';

import 'package:albisharaa/app/app_config.dart';
import 'package:albisharaa/core/data/models/apis/token_info.dart';
import 'package:albisharaa/core/data/models/cart_model.dart';
import 'package:albisharaa/core/enums/data_type.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SharedPrefrenceRepostory {
  SharedPreferences globalSharedPreference = Get.find();
  //!Keys------
  String PREF_FIRST_LUNCH = 'first_lunch';
  String PREF_FIRST_LOGIN = 'first_login';
  String PREF_TOKEN = 'token';
  String PREF_APP_LANG = 'app_lang';
  String PREF_CART_LIST = 'cart_list';
  String PREF_SUB_STATUS = 'sub_status';
  //list
  String PREF_ASFAR_MODEL = 'asfar_list_model';
  String PREF_AYAT_MODEL = 'ayat_list_model';
  String PREF_NUM = 'num';

  // Future<void> setNum(List<String> list) async {
  //   setPreference(
  //     dataType: DataType.STRING,
  //     key: PREF_NUM,
  //     value: jsonEncode(list),
  //   );
  // }

  // Future<List<String>> getNum() async {
  //   if (globalSharedPreference.containsKey(PREF_NUM)) {
  //     // Ensure getPreferenc returns a List<String>
  //     List<String> storedList =
  //         globalSharedPreference.getStringList(PREF_NUM) ?? [];
  //     return storedList;
  //   } else {
  //     return [];
  //   }
  // }

  Future<List<String>> getNum() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    if (prefs.containsKey(PREF_NUM)) {
      // استرجاع القائمة المخزنة
      return prefs.getStringList(PREF_NUM) ?? [];
    } else {
      return [];
    }
  }

// دالة غير متزامنة لإضافة عنصر جديد إلى القائمة المخزنة
  Future<void> setNum(String value) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    // استرجاع القائمة الحالية
    List<String> currentList = await getNum();

    // إضافة القيمة الجديدة إلى القائمة
    currentList.add(value);

    // إزالة التكرار من القائمة
    List<String> uniqueList = currentList.toSet().toList();

    // تخزين القائمة المحدثة
    await prefs.setStringList(PREF_NUM, uniqueList);
  }

  // Future<void> saveAsfar(RxList<asfarListModel> models) async {
  //   final prefs = await SharedPreferences.getInstance();
  //   List<String> jsonStringList =
  //       models.map((model) => jsonEncode(model.toJson())).toList();
  //   await prefs.setStringList(PREF_ASFAR_MODEL, jsonStringList);
  // }

  // Future<RxList<asfarListModel>> getAsfar() async {
  //   final prefs = await SharedPreferences.getInstance();
  //   List<String>? jsonStringList = prefs.getStringList(PREF_ASFAR_MODEL);

  //   RxList<asfarListModel> modelList = <asfarListModel>[].obs;

  //   if (jsonStringList != null && jsonStringList.isNotEmpty) {
  //     for (String jsonString in jsonStringList) {
  //       try {
  //         modelList.add(asfarListModel.fromJson(jsonDecode(jsonString)));
  //       } catch (e) {
  //         print('Error decoding JSON: $jsonString\nError: $e');
  //       }
  //     }
  //   } else {
  //     print('No cached models found or cached data is empty.');
  //   }

  //   return modelList;
  // }

  // Future<void> saveAyat(RxList<AyatModel> models) async {
  //   final prefs = await SharedPreferences.getInstance();
  //   List<String> jsonStringList =
  //       models.map((model) => jsonEncode(model.toJson())).toList();
  //   await prefs.setStringList(PREF_AYAT_MODEL, jsonStringList);
  // }

  // Future<RxList<AyatModel>> getAyat() async {
  //   final prefs = await SharedPreferences.getInstance();
  //   List<String>? jsonStringList = prefs.getStringList(PREF_AYAT_MODEL);

  //   RxList<AyatModel> modelList = <AyatModel>[].obs;

  //   if (jsonStringList != null && jsonStringList.isNotEmpty) {
  //     for (String jsonString in jsonStringList) {
  //       try {
  //         modelList.add(AyatModel.fromJson(jsonDecode(jsonString)));
  //       } catch (e) {
  //         print('Error decoding JSON: $jsonString\nError: $e');
  //       }
  //     }
  //   } else {
  //     print('No cached models found or cached data is empty.');
  //   }

  //   return modelList;
  // }

  // Future<void> clearAyat() async {
  //   final prefs = await SharedPreferences.getInstance();
  //   await prefs.remove(PREF_AYAT_MODEL); // Use the correct key for Ayat data
  // }

  void setTokenInfo(TokenInfo value) {
    setPreference(
      dataType: DataType.STRING,
      key: PREF_TOKEN,
      value: jsonEncode(value.toJson()), //string
      // json encode
      // بتاخد اوبجيكت
      // بترجع سترنغ
    );
  }

  TokenInfo? getTokenInfo() {
    if (globalSharedPreference.containsKey(PREF_TOKEN)) {
      return TokenInfo.fromJson(
        //formatted json
        jsonDecode(getPreferenc(key: PREF_TOKEN)),
      );
    } else {
      return null; //key not found
    }
  }

  void clearTokenInfo() {
    // globalSharedPreferences.remove(PREF_TOKEN);
    globalSharedPreference.clear();
    // globalSharedPreference.clear();
  }

  void setFirstLunch(bool value) {
    setPreference(
      dataType: DataType.BOOL,
      key: PREF_FIRST_LUNCH,
      value: value,
    );
  }

  bool getFirstLunch() {
    if (globalSharedPreference.containsKey(PREF_FIRST_LUNCH)) {
      return getPreferenc(key: PREF_FIRST_LUNCH);
    } else {
      return true;
    }
  }

  void setFirstLogin(bool value) {
    setPreference(
      dataType: DataType.BOOL,
      key: PREF_FIRST_LUNCH,
      value: value,
    );
  }

  bool getFirstLogin() {
    if (globalSharedPreference.containsKey(PREF_FIRST_LUNCH)) {
      return getPreferenc(key: PREF_FIRST_LOGIN);
    } else {
      return false;
    }
  }

//!Main Function
  setPreference(
      {required DataType dataType,
      required String key,
      required dynamic value}) async {
    switch (dataType) {
      case DataType.INT:
        await globalSharedPreference.setInt(key, value);
        break;
      case DataType.STRING:
        await globalSharedPreference.setString(key, value);
        break;
      case DataType.DOUBLE:
        await globalSharedPreference.setDouble(key, value);
        break;
      case DataType.BOOL:
        await globalSharedPreference.setBool(key, value);
        break;
      case DataType.STRINGLIST:
        await globalSharedPreference.setStringList(key, value);
        break;
    }
  }

  dynamic getPreferenc({required String key}) {
    return globalSharedPreference.get(key);
  }

  void setAppLanguage(String value) {
    setPreference(
      dataType: DataType.STRING,
      key: PREF_APP_LANG,
      value: value,
    );
  }

  String getAppLanguage() {
    if (globalSharedPreference.containsKey(PREF_APP_LANG)) {
      return getPreferenc(key: PREF_APP_LANG);
    } else {
      return AppConfig.defaultLanguage;
    }
  }

  void setCartList(List<CartModel> list) {
    setPreference(
        dataType: DataType.STRING,
        key: PREF_CART_LIST,
        value: CartModel.encode(list));
  }

  List<CartModel> getCartList() {
    if (globalSharedPreference.containsKey(PREF_CART_LIST)) {
      return CartModel.decode(getPreferenc(key: PREF_CART_LIST));
    } else
      return [];
  }

  void setSubStatus(bool value) {
    setPreference(
      dataType: DataType.BOOL,
      key: PREF_SUB_STATUS,
      value: value,
    );
  }

  bool getSubStatus() {
    if (Get.find<SharedPreferences>().containsKey(PREF_SUB_STATUS)) {
      return getPreferenc(key: PREF_SUB_STATUS);
    } else {
      return true;
    }
  }

  bool get isLoggedIn => getTokenInfo() != null ? true : false;
  // bool get isLoggedIn=>getTokenInfo()==null?false:true;
}
