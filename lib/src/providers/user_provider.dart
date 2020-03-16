import 'dart:convert';

import 'package:flutterforms/src/utils/preferences_user.dart';
import 'package:http/http.dart' as http;

class UserProvider {
  final String _firebaseToken = 'AIzaSyAU6_nNSnKdtdL87n-pcIgbP9naJEJ63Qs';
  final _prefs = new PreferenceUser();

  Future<Map<String, dynamic>> newUser(String email, String password) async {
    final autData = {
      'email': email,
      'password': password,
      'returnSecureToken': true
    };
    final url =
        'https://identitytoolkit.googleapis.com/v1/accounts:signUp?key=$_firebaseToken';
    final resp = await http.post(url, body: json.encode(autData));

    Map<String, dynamic> decodeResp = json.decode(resp.body);
    if (decodeResp.containsKey('idToken')) {
      _prefs.token = decodeResp['idToken'];
      return {'ok': true, 'token': decodeResp['idToken']};
    } else {
      return {'ok': false, 'msj': decodeResp['error']['message']};
    }
  }

  Future<Map<String, dynamic>> loginUser(String email, String password) async {
    final autData = {
      'email': email,
      'password': password,
      'returnSecureToken': true
    };
    final url =
        'https://identitytoolkit.googleapis.com/v1/accounts:signInWithPassword?key=$_firebaseToken';
    final resp = await http.post(url, body: json.encode(autData));

    Map<String, dynamic> decodeResp = json.decode(resp.body);
    if (decodeResp.containsKey('idToken')) {
      _prefs.token = decodeResp['idToken'];
      return {'ok': true, 'token': decodeResp['idToken']};
    } else {
      return {'ok': false, 'msj': decodeResp['error']['message']};
    }
  }
}
