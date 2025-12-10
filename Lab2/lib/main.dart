import 'package:flutter/material.dart';
import 'package:untitled3/screens/home_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'firebase_options.dart';

Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  print("Background message received: ${message.notification?.title}");
}

void main() async{
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);

  final RemoteMessage? initialMessage =
  await FirebaseMessaging.instance.getInitialMessage();

  String? token = await FirebaseMessaging.instance.getToken();
  print("FCM Token: $token");

  runApp( MyApp(initialMessage: initialMessage));
}

class MyApp extends StatelessWidget {
  final RemoteMessage? initialMessage;
  const MyApp({super.key, this.initialMessage});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Meal Recipes',
      theme: ThemeData(primarySwatch: Colors.teal),
      home: HomeScreen(initialMessage: initialMessage,),
      debugShowCheckedModeBanner: false,
    );
  }
}
