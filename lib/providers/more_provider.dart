import 'package:file_sync/home.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get/get.dart';
import 'package:local_auth/local_auth.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:local_auth/error_codes.dart' as auth_error;

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
          _pref.setBool("isAccessPinEnabled", v);
        }
        break;
      case 4:
        {
          isfpEnable = v;
          _pref.setBool("isfpEnable", v);
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
    isfpEnable = prefs.getBool("isfpEnable") ?? false;
    notifyListeners();
  }

  LocalAuthentication localAuthentication = LocalAuthentication();

  void onFingerPrintToUnlock() async {
    final bool canAuthenticateWithBiometrics =
        await localAuthentication.canCheckBiometrics;
    final bool canAuthenticate = canAuthenticateWithBiometrics ||
        await localAuthentication.isDeviceSupported();
    print("canAuthenticate :: $canAuthenticate");

    final List<BiometricType> availableBiometrics =
        await localAuthentication.getAvailableBiometrics();
    if (availableBiometrics.isNotEmpty) {
      availableBiometrics.contains(BiometricType.fingerprint);
      print("availableBiometrics :: $availableBiometrics");

      try {
        final bool didAuthenticate = await localAuthentication.authenticate(
          localizedReason: 'Please authenticate to show account balance',
        );

        Get.offAll(() => Home());
      } on PlatformException catch (e) {
        Get.snackbar(
          "Error",
          "error to authenticate try again",
          colorText: Colors.white,
          backgroundColor: Colors.red[200],
        );
        if (e.code == auth_error.notEnrolled) {
        } else if (e.code == auth_error.lockedOut ||
            e.code == auth_error.permanentlyLockedOut) {
        } else {
          // ...
        }
      }
    }
  }

  Future<void> onSavePinSetting() async {
    final SharedPreferences _pref = await SharedPreferences.getInstance();
    _pref.setString("pinToUnlock", pinCcontroller.text);
    _pref.setString("pinExTime", pinExTimecontroller.text);
    pincontroller.clear();
    pinCcontroller.clear();
  }
}
