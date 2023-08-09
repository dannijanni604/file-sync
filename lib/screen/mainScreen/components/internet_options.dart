import 'dart:async';
import 'package:file_sync/screen/mainScreen/tile_option.dart';
import 'package:flutter/material.dart';
import 'package:connectivity_plus/connectivity_plus.dart';

class InternetOptions extends StatefulWidget {
  const InternetOptions({super.key});

  @override
  State<InternetOptions> createState() => _InternetOptionsState();
}

class _InternetOptionsState extends State<InternetOptions> {
  @override
  void initState() {
    checkInternet();

    super.initState();
  }

  IconData icon = Icons.wifi;
  String title = 'wifi';
  late StreamSubscription<ConnectivityResult> stream;

  Future checkInternet() async {
    stream = Connectivity()
        .onConnectivityChanged
        .listen((ConnectivityResult result) {
      if (result == ConnectivityResult.mobile) {
        // I am connected to a mobile network.
        icon = Icons.signal_cellular_alt_rounded;
        title = 'Mobile Data';
      } else if (result == ConnectivityResult.wifi) {
        icon = Icons.wifi;
        title = 'Wifi';
        ConnectivityResult.wifi.name;
      } else if (result == ConnectivityResult.ethernet) {
        // I am connected to a ethernet network.
      } else if (result == ConnectivityResult.none) {
        // I am not connected to any network.
        icon = Icons.not_interested;
        title = "Not connected";
      }
      if (mounted) {
        setState(() {});
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return tileOptions(context, icon, title);
  }

  @override
  void dispose() {
    stream.cancel();
    super.dispose();
  }
}
