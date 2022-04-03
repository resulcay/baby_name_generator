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
    await sharedPrefs.setString(girlName, girlDescription);
  }

  Future deleteGirlNameAndDescFromSharedPref(String girlName) async {
    await createSharedPrefObject();
    await sharedPrefs.remove(girlName);
  }

  Future<String?> viewGirlNameAndDescFromSharedPref() async {
    await createSharedPrefObject();
    final String? value = sharedPrefs.getString("chen");
    return value ?? "nullll";
  }
}
