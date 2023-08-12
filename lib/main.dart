import 'package:file_sync/controller/google_drive_controller/google_drive_controller.dart';
import 'package:file_sync/controller/navigator.dart';
import 'package:file_sync/home.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:workmanager/workmanager.dart';

sendData() {
  print("HHHHHHHHHHHHHHHHHHHHHHHHHHH");
}

const task = "firstTask";
void callbackDispatcher() {
  Workmanager().executeTask((taskName, inputData) {
    switch (taskName) {
      case "firstTask":
        sendData();
        break;
      default:
    }

    print("Native called background task: ---");
    return Future.value(true);
  });
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Workmanager().initialize(callbackDispatcher, isInDebugMode: true);

  await Firebase.initializeApp();
  runApp(ChangeNotifierProvider(
    create: (_) => DriveController(),
    child: MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: ChangeNotifierProvider(
        create: (context) => BottomNavigator(),
        child: Home(),
      ),
    );
  }
}
