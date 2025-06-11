import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

class LocalStorage {
  LocalStorage();

  Future<void> setData(String key, dynamic value) async {
    final sharedPreferences = await SharedPreferences.getInstance();
    String jsonString = jsonEncode(value);
    await sharedPreferences.setString(key, jsonString);
  }

  Future<dynamic> getData(String key) async {
    final sharedPreferences = await SharedPreferences.getInstance();
    String? jsonString = sharedPreferences.getString(key);
    if (jsonString == null) return null;
    return jsonDecode(jsonString);
  }

  Future<void> removeData(String key) async {
    final sharedPreferences = await SharedPreferences.getInstance();
    await sharedPreferences.remove(key);
  }

  Future<void> clearAllData() async {
    final sharedPreferences = await SharedPreferences.getInstance();
    await sharedPreferences.clear();
  }
}
