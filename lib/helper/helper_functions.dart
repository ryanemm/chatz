import 'package:shared_preferences/shared_preferences.dart';

class HelperFunctions {
  static String sharedPrefenceUserLoggedInKey = "ISLOGGEDIN";
  static String sharedPrefenceUsernameKey = "USERNAMEKEY";
  static String sharedPrefenceUserEmailKey = "USEREMAILKEY";

  //saving data to shared prefence
  static Future<bool> saveUserLoggedInSharedPreference(
      bool isUserLoggedIn) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return await prefs.setBool(sharedPrefenceUserLoggedInKey, isUserLoggedIn);
  }

  static Future<bool> saveUsernameSharedPreference(String username) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return await prefs.setString(sharedPrefenceUserLoggedInKey, username);
  }

  static Future<bool> saveUserEmailSharedPreference(String userEmail) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return await prefs.setString(sharedPrefenceUserLoggedInKey, userEmail);
  }

  static Future<bool?> getUserLoggedInSharedPreference() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return await prefs.getBool(sharedPrefenceUserLoggedInKey);
  }

  static Future<String?> getUsernameSharedPreference() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return await prefs.getString(sharedPrefenceUsernameKey);
  }

  static Future<String?> getUserEmailSharedPreference() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return await prefs.getString(sharedPrefenceUserEmailKey);
  }
}

//retrieving data from sharedPreferences

