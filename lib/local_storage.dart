import 'dart:core';

import 'package:shared_preferences/shared_preferences.dart';

class LocalStorage {
  String value = "default";
  late SharedPreferences sharedPrefs;
  Future createSharedPrefObject() async {
    sharedPrefs = await SharedPreferences.getInstance();
  }

  Future saveGirlNameAndDescToSharedPref(
      String girlName, String girlDescription) async {
    await createSharedPrefObject();
    await sharedPrefs.setStringList("girlNames", [girlName, girlDescription]);
  }

  Future deleteGirlNameAndDescFromSharedPref(String girlName) async {
    await createSharedPrefObject();
    await sharedPrefs.remove(girlName);
  }

  Future<List<String>?> viewGirlNameAndDescFromSharedPref() async {
    await createSharedPrefObject();
    var value = sharedPrefs.getStringList("girlNames");

    return value;
  }
}
