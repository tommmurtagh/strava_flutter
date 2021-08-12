import 'dart:async';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:strava_flutter/models/token.dart';

class LocalStorageManager{

  static String _kTokenKey = "strava_token";

  static Future<bool> saveToken(Token token) async{
    var sharedPrefs = await SharedPreferences.getInstance();
    return sharedPrefs.setString(_kTokenKey, token.toRawJson());
  }

  static Future<bool> deleteToken(Token token) async{
    var sharedPrefs = await SharedPreferences.getInstance();
    return sharedPrefs.remove(_kTokenKey);
  }

  static Future<Token?> getToken() async{
    var sharedPrefs = await SharedPreferences.getInstance();
    var completer = Completer<Token?>();
    var tokenJson = sharedPrefs.getString(_kTokenKey);
    if (tokenJson == null) {
      completer.complete(null);
    }else{
      completer.complete(Token.fromRawJson(tokenJson));
    }
    return completer.future;
  }
}