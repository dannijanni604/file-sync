import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MoreProvider extends ChangeNotifier {
  final _auth = FirebaseAuth.instance;
  bool isLoggingEnabled = false;
  bool isNotiEnable = false;
  bool isSyncEnabled = false;
  bool isAccessPinEnabled = false;
  String? pinToUnlock = '';
  bool isfpEnable = false;

  FlutterSecureStorage? _storage;
  FlutterSecureStorage get storage => _storage!;

  ///
  final pincontroller = TextEditingController();
  final pinCcontroller = TextEditingController();
  final pinExTimecontroller = TextEditingController(text: 10.toString());

  void toggleToMoreSetting(bool v, int index) async {
    final SharedPreferences _pref = await SharedPreferences.getInstance();
    switch (index) {
      case 0:
        {
          isLoggingEnabled = v;
          _pref.setBool("isLoggingEnabled", v);
        }
        break;
      case 1:
        {
          isSyncEnabled = v;
          _pref.setBool("isSyncEnabled", v);
        }
        break;
      case 2:
        {
          isNotiEnable = v;
          _pref.setBool("isNotiEnable", v);
        }
        break;
      case 3:
        {
          isAccessPinEnabled = v;
          _pref.setBool("isAccessPinEnabled", isAccessPinEnabled);
        }
        break;

      default:
    }
    notifyListeners();
  }

  void getPrefrances() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    isLoggingEnabled = prefs.getBool("isLoggingEnabled") ?? false;
    isSyncEnabled = prefs.getBool("isSyncEnabled") ?? true;
    isNotiEnable = prefs.getBool("isNotiEnable") ?? true;
    isAccessPinEnabled = prefs.getBool("isAccessPinEnabled") ?? false;
  }

  Future<void> onSavePinSetting() async {
    final SharedPreferences _pref = await SharedPreferences.getInstance();
    _pref.setString("pinToUnlock", pinCcontroller.text);
    _pref.setString("pinExTime", pinExTimecontroller.text);
    pincontroller.clear();
    pinCcontroller.clear();
  }
}
