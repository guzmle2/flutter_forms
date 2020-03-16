import 'package:flutterforms/src/pages/login_page.dart';
import 'package:shared_preferences/shared_preferences.dart';

//  shared_preferences:
class PreferenceUser {
  static final PreferenceUser _instance = new PreferenceUser._internal();

  factory PreferenceUser() {
    return _instance;
  }

  PreferenceUser._internal();

  SharedPreferences _prefs;

  initPrefs() async {
    _prefs = await SharedPreferences.getInstance();
  }


  String get token => _prefs.getString('token') ?? '';

  set token(String value) {
    _prefs.setString('token', value);
  }

  String get lastPage => _prefs.getString('lastPage') ?? LoginPage.routeName;

  set lastPage(String value) {
    _prefs.setString('lastPage', value);
  }
}
