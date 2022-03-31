import 'package:shared_preferences/shared_preferences.dart';

class LocalStorage {
  late SharedPreferences _sharedPrefs;

  Future<void> createSharedPrefObject() async {
    _sharedPrefs = await SharedPreferences.getInstance();
  }

  void saveBoyNameAndDescToSharedPref(String boyName, String boyDescription) {
    _sharedPrefs.setString(boyName, boyDescription);
  }

  void saveGirlNameAndDescToSharedPref(
      String girlName, String girlDescription) {
    _sharedPrefs.setString(girlName, girlDescription);
  }
}
