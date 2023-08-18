import 'package:file_sync/home.dart';
import 'package:file_sync/providers/more_provider.dart';
import 'package:file_sync/screen/pin_to_unlock.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  String? pin;
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
      final moreProvider = Provider.of<MoreProvider>(context, listen: false);
      await moreProvider.getPreferances();
      onPin(moreProvider);
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Text(
          "Splash Screen",
          style: TextStyle(
            fontSize: 30,
            color: Colors.green,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }

  void onPin(MoreProvider moreProvider) async {
    bool isAccessPinEnabled = moreProvider.isAccessPinEnabled;
    pin = moreProvider.pinToUnlock;
    if (pin!.isNotEmpty && isAccessPinEnabled == true) {
      Get.to(() => PinToUnlockScreen(
            pin: pin!,
          ));
    } else {
      Get.to(() => Home());
    }
  }
}
