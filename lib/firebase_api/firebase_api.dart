import 'package:firebase_messaging/firebase_messaging.dart';

class FirebaseApi {
  final _firebaseMessaging = FirebaseMessaging.instance;

  Future<void> initNotification() async {
    _firebaseMessaging.requestPermission();
    final fCMtoken = await _firebaseMessaging.getToken();
    FirebaseMessaging.onBackgroundMessage(handleBackgroundMessage);
    print("Token : $fCMtoken");
  }

  Future<void> handleBackgroundMessage(RemoteMessage message) async {
    print('title : ${message.notification?.title}');
    print('title : ${message.notification?.body}');
    print('title : ${message.data}');
  }
}
