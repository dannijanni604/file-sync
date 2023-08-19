import 'package:file_sync/home.dart';
import 'package:file_sync/providers/more_provider.dart';
import 'package:file_sync/screen/pin_to_unlock.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      final mp = Provider.of<MoreProvider>(context, listen: false);
      mp.getPrefrances();
      onPin();
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Image.asset(
          "assets/logo.png",
          fit: BoxFit.fill,
          scale: 4,
        ),
      ),
    );
  }

  void onPin() async {
    final _pref = await SharedPreferences.getInstance();

    final ispinEnable = _pref.getBool("isAccessPinEnabled");
    final pin = _pref.getString("pinToUnlock");
    if (pin!.isNotEmpty && ispinEnable == true) {
      Get.offAll(() => PinToUnlockScreen(
            pin: pin,
          ));
    } else {
      Get.offAll(() => Home());
    }
  }
}
