import 'package:shared_preferences/shared_preferences.dart';

class SHelper {
  SHelper._();
  static SHelper sHelper = SHelper._();

  SharedPreferences? sharedPreferences;

  Future<SharedPreferences> initSharedPrefrences() async {
    if (sharedPreferences == null) {
      sharedPreferences = await SharedPreferences.getInstance();
      return sharedPreferences!;
    } else {
      return sharedPreferences!;
    }
  }

  Future<void> setLanguge(String token) {
    return sharedPreferences!.setString("Lang", token);
  }

  String? getLanguge() {
    return sharedPreferences!.getString("Lang");
  }

  clearSp() async {
    sharedPreferences = await initSharedPrefrences();
    sharedPreferences!.clear();
  }
}
