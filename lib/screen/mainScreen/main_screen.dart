import 'package:file_sync/main.dart';
import 'package:file_sync/screen/mainScreen/components/battery_options.dart';
import 'package:file_sync/screen/mainScreen/tile_option.dart';
import 'package:file_sync/screen/mainScreen/components/internet_options.dart';
import 'package:file_sync/screen/mainScreen/top_option.dart';
import 'package:flutter/material.dart';
import 'package:workmanager/workmanager.dart';

class MainScreen extends StatelessWidget {
  MainScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        children: [
          SizedBox(
            height: 20,
          ),
          topOptions(context),
          SizedBox(
            height: 15,
          ),
          Wrap(
            runSpacing: 12,
            spacing: 12,
            children: [
              InternetOptions(),
              BatteryOptions(),
              InkWell(
                  onTap: () async {
                    Workmanager().registerPeriodicTask(
                      DateTime.now().second.toString(),
                      task,
                    );
                  },
                  child: tileOptions(
                      context, Icons.info, "No sync have been run")),
              tileOptions(context, Icons.alarm_off_outlined, "No sync timed"),
            ],
          )
        ],
      ),
    ));
  }
}
