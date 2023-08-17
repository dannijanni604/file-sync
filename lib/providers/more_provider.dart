import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class MoreProvider extends ChangeNotifier {
  bool isLoggingEnabled = false;
  bool isNotiEnable = false;
  bool isSyncEnabled = true;
  bool isAccessPinEnabled = false;

  FlutterSecureStorage? _storage;
  FlutterSecureStorage get storage => _storage!;

  void toggleLoggingEnabled({bool? loggingEnabled}) {
    isLoggingEnabled = loggingEnabled!;
    if (loggingEnabled) {
      _storage!.write(key: "loggingEnabled", value: "true");
    } else {
      _storage!.write(key: "loggingEnabled", value: "false");
    }
    notifyListeners();
  }

  void toggleNotification({bool? isNotiEnable}) {
    this.isNotiEnable = isNotiEnable!;

    if (isNotiEnable) {
      _storage!.write(key: "isNotiEnable", value: "true");
    } else {
      _storage!.write(key: "isNotiEnable", value: "false");
    }
    notifyListeners();
  }

  void toggleAccessPin({bool? accessPinEnabled}) {
    isAccessPinEnabled = accessPinEnabled!;
    if (accessPinEnabled) {
      _storage!.write(key: "accessPinEnabled", value: "true");
    } else {
      _storage!.write(key: "accessPinEnabled", value: "false");
    }
    notifyListeners();
  }

  void toggleSyncEnabled({bool? syncEnabled}) {
    isSyncEnabled = syncEnabled!;

    if (syncEnabled) {
      _storage!.write(key: "syncEnabled", value: "true");
    } else {
      _storage!.write(key: "syncEnabled", value: "false");
    }
    notifyListeners();
  }
}
