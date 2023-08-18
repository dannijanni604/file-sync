import 'package:file_sync/home.dart';
import 'package:file_sync/providers/more_provider.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

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
        body: Padding(
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
              Consumer<MoreProvider>(builder: (context, value, child) {
                return TextFormField(
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
                      Get.to(() => Home());
                    } else {
                      "Wrong Pin";
                    }
                  },
                );
              }),
            ],
          ),
        ),
      ),
    );
  }
}
