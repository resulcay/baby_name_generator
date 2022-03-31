import 'package:shared_preferences/shared_preferences.dart';

class LocalStorage {
  late SharedPreferences sharedPrefs;

  Future<void> createSharedPrefObject() async {
    sharedPrefs = await SharedPreferences.getInstance();
  }

  void saveBoyNameAndDescToSharedPref(
      String boyName, String boyDescription) async {
    await createSharedPrefObject();
    sharedPrefs.setString(boyName, boyDescription);
  }

  Future<void> saveGirlNameAndDescToSharedPref(
      String girlName, String girlDescription) async {
    await createSharedPrefObject();
    sharedPrefs.setString(girlName, girlDescription);
  }

  String? viewGirlNameAndDescFromSharedPref() {
    createSharedPrefObject();
    String? test = sharedPrefs.getString('elif');

    return test ?? "nullable worked";
    // if (test == null) {
    //       return 'a';
    //     } else {
    //       return test;
    //     }
  }

  void deleteGirlNameAndDescFromSharedPref(String girlName) async {
    await createSharedPrefObject();
    sharedPrefs.remove(girlName);
  }
}
