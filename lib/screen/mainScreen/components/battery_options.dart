import 'dart:async';
import 'package:battery_info/battery_info_plugin.dart';
import 'package:battery_info/enums/charging_status.dart';
import 'package:battery_info/model/android_battery_info.dart';
import 'package:flutter/material.dart';
import '../tile_option.dart';

class BatteryOptions extends StatefulWidget {
  const BatteryOptions({super.key});

  @override
  State<BatteryOptions> createState() => _BatteryOptionsState();
}

class _BatteryOptionsState extends State<BatteryOptions> {
  @override
  void initState() {
    checkBattery();
    super.initState();
  }

  IconData icon = Icons.battery_0_bar;
  String title = "battery";
  late StreamSubscription<AndroidBatteryInfo?> stream;
  Future checkBattery() async {
    stream = BatteryInfoPlugin().androidBatteryInfoStream.listen((event) {
      if (event!.chargingStatus == ChargingStatus.Charging) {
        title = "Charging";
        icon = Icons.battery_charging_full_outlined;
      } else if (event.chargingStatus == ChargingStatus.Full) {
        title = "Battery Full";
        icon = Icons.battery_std_outlined;
      } else {
        title = "Not Connected";
        icon = Icons.battery_5_bar_outlined;
      }

      setState(() {});
    });
  }

  Widget build(BuildContext context) {
    return tileOptions(context, icon, title);
  }

  @override
  void dispose() {
    stream.cancel();
    super.dispose();
  }
}
