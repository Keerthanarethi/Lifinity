import 'package:shared_preferences/shared_preferences.dart';

class ProfileManager {

  static String userName = "User";
  static String wakeTime = "6:00 AM";
  static String sleepTime = "11:00 PM";

  static Future<void> saveProfile() async {

    final prefs =
        await SharedPreferences.getInstance();

    await prefs.setString(
      'userName',
      userName,
    );

    await prefs.setString(
      'wakeTime',
      wakeTime,
    );

    await prefs.setString(
      'sleepTime',
      sleepTime,
    );
  }

  static Future<void> loadProfile() async {

    final prefs =
        await SharedPreferences.getInstance();

    userName =
        prefs.getString('userName') ??
            "User";

    wakeTime =
        prefs.getString('wakeTime') ??
            "6:00 AM";

    sleepTime =
        prefs.getString('sleepTime') ??
            "11:00 PM";
  }
}