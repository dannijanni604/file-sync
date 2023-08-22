import 'package:file_sync/home.dart';
import 'package:file_sync/providers/more_provider.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:provider/provider.dart';

class PinToUnlockScreen extends StatelessWidget {
  final String pin;
  const PinToUnlockScreen({
    super.key,
    required this.pin,
  });

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Consumer<MoreProvider>(builder: (context, ctrl, child) {
          return Padding(
            padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 30),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  "FolderSync",
                  style: TextStyle(
                      fontSize: 20,
                      color: Colors.black,
                      fontWeight: FontWeight.w300),
                ),
                SizedBox(height: 30),
                Text("You have been logged out."),
                SizedBox(height: 40),
                TextFormField(
                  autofocus: true,
                  keyboardType: TextInputType.number,
                  obscureText: true,
                  decoration: InputDecoration(
                    isDense: true,
                    label: Text("PIN"),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  onChanged: (v) {
                    if (v == pin) {
                      Get.offAll(() => Home());
                    } else {
                      "Wrong Pin";
                    }
                  },
                ),
                ctrl.isfpEnable
                    ? Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          TextButton(
                            onPressed: () {
                              ctrl.onFingerPrintToUnlock();
                            },
                            child: Text("Use fingerprint"),
                          ),
                        ],
                      )
                    : SizedBox(),
              ],
            ),
          );
        }),
      ),
    );
  }
}
