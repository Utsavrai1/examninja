import 'package:shared_preferences/shared_preferences.dart';

class LocalStorageService {
  Future<String?> getDataFromStorage(String key) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();

    final String? data = preferences.getString(key);

    return data;
  }

  Future<void> setDataToStorage(String key, String value) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();

    await preferences.setString(key, value);
  }

  Future<void> deleteDataFromStorage(String key) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();

    await preferences.remove(key);
  }
}
