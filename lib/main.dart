import 'package:file_manager/file_manager.dart';
import 'package:file_sync/providers/google_drive_provider/google_drive_provider.dart';
import 'package:file_sync/providers/more_provider.dart';
import 'package:file_sync/providers/navigator.dart';
import 'package:file_sync/screen/splash.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:workmanager/workmanager.dart';

const task = "firstTask";
void callbackDispatcher() {
  // Workmanager().registerOneOffTask("First Task");
  Workmanager().executeTask((taskName, inputData) {
    taskName.characters;
    switch (taskName) {
      case "firstTask":
        break;
      default:
    }
    print("Native called background task: ---");
    return Future.value(true);
  });
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  // await FirebaseApi().initNotification();
  await Workmanager().initialize(callbackDispatcher, isInDebugMode: false);
  runApp(
    const MyApp(),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<DriveController>(
          create: (_) => DriveController(),
        ),
        ChangeNotifierProvider<MoreProvider>(
          create: (_) => MoreProvider(),
        ),
        ChangeNotifierProvider(
          create: (_) => BottomNavigator(),
        ),
      ],
      child: GetMaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'Flutter Demo',
          theme: ThemeData(
            colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
            useMaterial3: true,
          ),
          home: SplashScreen()),
    );
  }
}
