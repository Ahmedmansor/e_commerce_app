import 'package:shared_preferences/shared_preferences.dart';

class CachMemory {
  static late SharedPreferences sharedPref;

  static Future cachMemoryInit() async {
    sharedPref = await SharedPreferences.getInstance();
  }

// set value
  static Future<bool> insertToCachMemory(
      {required String key, required String value}) async {
    return await sharedPref.setString(key, value);
  }

// get value
  static String getFromCachMemory({required String key}) {
    return sharedPref.getString(key) ?? '';
  }

//delete value
  static Future<bool> deleteFromCachMemory({required key}) async {
    return await sharedPref.remove(key);
  }
}
