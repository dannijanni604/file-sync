import 'package:file_sync/providers/google_drive_provider/google_drive_provider.dart';
import 'package:file_sync/providers/more_provider.dart';
import 'package:file_sync/providers/navigator.dart';
import 'package:file_sync/firebase_api/firebase_api.dart';
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
  await Firebase.initializeApp();
  // await FirebaseApi().initNotification();
  await Workmanager().initialize(callbackDispatcher, isInDebugMode: true);

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
      ],
      child: MaterialApp(
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
      ),
    );
  }
}
