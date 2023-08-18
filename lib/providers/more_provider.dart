import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:workmanager/workmanager.dart';

class MoreProvider extends ChangeNotifier {
  final _auth = FirebaseAuth.instance;
  bool isLoggingEnabled = false;
  bool isNotiEnable = false;
  bool isSyncEnabled = true;
  bool isAccessPinEnabled = false;
  String? pinToUnlock = '';
  bool isfpEnable = false;

  FlutterSecureStorage? _storage;
  FlutterSecureStorage get storage => _storage!;

  ///
  final pincontroller = TextEditingController();
  final pinCcontroller = TextEditingController();
  final pinExTimecontroller = TextEditingController(text: 10.toString());

  static Future<SharedPreferences> preferences() async {
    return SharedPreferences.getInstance();
  }

  void toggleLoggingEnabled({bool? loggingEnabled}) async {
    final prefs = await preferences();
    prefs.setBool('isLoggingEnabled', loggingEnabled!);
    isLoggingEnabled = loggingEnabled;
    notifyListeners();
  }

  void toggleSyncEnabled({bool? syncEnabled}) async {
    final prefs = await preferences();
    prefs.setBool('isSyncEnabled', syncEnabled!);
    isSyncEnabled = syncEnabled;
    notifyListeners();
  }

  void toggleNotification({bool? isNotiEnable}) async {
    final prefs = await preferences();
    prefs.setBool('isNotiEnable', isNotiEnable!);
    this.isNotiEnable = isNotiEnable;

    notifyListeners();
  }

  void toggleAccessPin({bool? accessPinEnabled}) async {
    final prefs = await preferences();
    prefs.setBool('isAccessPinEnabled', accessPinEnabled!);
    isAccessPinEnabled = accessPinEnabled;
    print(isAccessPinEnabled);
    notifyListeners();
  }

  // void toggleUFPEnabled({bool? fpEnable}) async {
  //   final prefs = await preferences();
  //   prefs.setBool('isfpEnable', fpEnable!);
  //   isfpEnable = fpEnable;
  //   notifyListeners();
  // }

  // Future<bool> onNotifcationEnable() async {
  //   SharedPreferences sf = await SharedPreferences.getInstance();
  //   bool? notifEnable = sf.getBool("isNotiEnable");

  //   if (_auth.currentUser != null && notifEnable!) {
  //     return true;
  //   } else {
  //     return false;
  //   }
  // }

  Future<void> onSavePinSetting() async {
    final SharedPreferences _pref = await SharedPreferences.getInstance();
    _pref.setString("pinToUnlock", pinCcontroller.text);
    _pref.setString("pinExTime", pinExTimecontroller.text);
    pincontroller.clear();
    pinCcontroller.clear();
  }

  Future<void> getPreferances() async {
    final prefs = await preferences();
    isLoggingEnabled = prefs.getBool("isLoggingEnabled")!;
    isSyncEnabled = prefs.getBool("isSyncEnabled")!;
    isNotiEnable = prefs.getBool("isNotiEnable")!;
    isAccessPinEnabled = prefs.getBool("isAccessPinEnabled")!;
    pinToUnlock = prefs.getString("pinToUnlock")!;
    // isfpEnable = prefs.getBool("isfpEnable")!;

    print("isLoggingEnabled  :  $isLoggingEnabled");
    print("isSyncEnabled  :  $isSyncEnabled");
    print("isNotiEnable  :  $isNotiEnable");
    print("isAccessPinEnabled  :  $isAccessPinEnabled");
    print("pinToUnlock  :  $pinToUnlock");
    // print("isLoggingEnabled  :  $isLoggingEnabled");
  }
}
