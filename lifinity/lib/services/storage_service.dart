import 'package:shared_preferences/shared_preferences.dart';

class StorageService {

  // USER NAME

  static Future<void> saveUserName(
      String name) async {

    final prefs =
        await SharedPreferences.getInstance();

    await prefs.setString(
      'userName',
      name,
    );
  }

  static Future<String?> getUserName()
  async {

    final prefs =
        await SharedPreferences.getInstance();

    return prefs.getString(
      'userName',
    );
  }

  // LOGIN STATUS

  static Future<void> saveLoginStatus(
      bool status) async {

    final prefs =
        await SharedPreferences.getInstance();

    await prefs.setBool(
      'isLoggedIn',
      status,
    );
  }

  static Future<bool> getLoginStatus()
  async {

    final prefs =
        await SharedPreferences.getInstance();

    return prefs.getBool(
          'isLoggedIn',
        ) ??
        false;
  }

  // ACCOUNT DETAILS

  static Future<void> saveAccount({
    required String name,
    required String email,
    required String password,
  }) async {

    final prefs =
        await SharedPreferences.getInstance();

    await prefs.setString(
      'accountName',
      name,
    );

    await prefs.setString(
      'accountEmail',
      email,
    );

    await prefs.setString(
      'accountPassword',
      password,
    );
  }

  static Future<String?> getAccountName()
  async {

    final prefs =
        await SharedPreferences.getInstance();

    return prefs.getString(
      'accountName',
    );
  }

  static Future<String?> getAccountEmail()
  async {

    final prefs =
        await SharedPreferences.getInstance();

    return prefs.getString(
      'accountEmail',
    );
  }

  static Future<String?> getAccountPassword()
  async {

    final prefs =
        await SharedPreferences.getInstance();

    return prefs.getString(
      'accountPassword',
    );
  }

  // WAKE TIME

  static Future<void> saveWakeTime(
      String wakeTime) async {

    final prefs =
        await SharedPreferences.getInstance();

    await prefs.setString(
      'wakeTime',
      wakeTime,
    );
  }

  static Future<String> getWakeTime()
  async {

    final prefs =
        await SharedPreferences.getInstance();

    return prefs.getString(
          'wakeTime',
        ) ??
        "06:00 AM";
  }

  // SLEEP TIME

  static Future<void> saveSleepTime(
      String sleepTime) async {

    final prefs =
        await SharedPreferences.getInstance();

    await prefs.setString(
      'sleepTime',
      sleepTime,
    );
  }

  static Future<String> getSleepTime()
  async {

    final prefs =
        await SharedPreferences.getInstance();

    return prefs.getString(
          'sleepTime',
        ) ??
        "11:00 PM";
  }

  // LOGOUT

  static Future<void> logout() async {

    final prefs =
        await SharedPreferences.getInstance();

    await prefs.setBool(
      'isLoggedIn',
      false,
    );
  }

  // CLEAR ALL DATA

  static Future<void> clearAllData()
  async {

    final prefs =
        await SharedPreferences.getInstance();

    await prefs.clear();
  }
}