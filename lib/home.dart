// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, sort_child_properties_last

import 'package:file_sync/data/color_scheme.dart' as color_scheme;
import 'package:file_sync/providers/navigator.dart';
import 'package:file_sync/data/pages.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  DateTime? _currentBackPressTime;
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        DateTime now = DateTime.now();
        if (_currentBackPressTime == null ||
            now.difference(_currentBackPressTime!) > Duration(seconds: 2)) {
          _currentBackPressTime = now;

          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('repeat action to exit app'),
            ),
          );

          return false;
        }
        return true;
      },
      child: Consumer<BottomNavigator>(
          builder: (context, data, _) => Scaffold(
                bottomNavigationBar: BottomNavigationBar(
                    currentIndex: data.currentIndex,
                    iconSize: 25,
                    selectedFontSize: 0,
                    unselectedFontSize: 0,
                    selectedItemColor: Colors.black,
                    unselectedItemColor: color_scheme.secondaryColor,
                    useLegacyColorScheme: true,
                    onTap: (val) => data.onClick(val),
                    items: [
                      BottomNavigationBarItem(
                          icon: Icon(Icons.home), label: ''),
                      BottomNavigationBarItem(
                          icon: Icon(CupertinoIcons.person_2_fill), label: ' '),
                      BottomNavigationBarItem(
                          icon: Icon(Icons.sd_card), label: ' '),
                      BottomNavigationBarItem(
                          icon: Icon(Icons.more_horiz), label: ' '),
                    ]),
                body: pages[data.currentIndex],
              )),
    );
  }
}
