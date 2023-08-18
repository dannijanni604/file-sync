import 'package:flutter/material.dart';

class BottomNavigator extends ChangeNotifier {
  int currentIndex = 0;
  onClick(int val) {
    currentIndex = val;
    notifyListeners();
  }
}
