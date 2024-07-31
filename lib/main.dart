// import 'dart:developer';
// import 'dart:io';

// import 'package:firebase_core/firebase_core.dart';
// import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'core/di/injection_container.dart';
import 'app.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initializeDependencies();
  // await Firebase.initializeApp();
  // await FirebaseMessaging.instance.requestPermission(
  //   alert: true,
  //   announcement: false,
  //   badge: true,
  //   carPlay: false,
  //   criticalAlert: false,
  //   provisional: false,
  //   sound: true,
  // );
  // await _subscribeToAllTopic();
  await ScreenUtil.ensureScreenSize();
  runApp(const App());
}

// Future<void> _subscribeToAllTopic() async {
//   bool subscribed = false;

//   for (int i = 0; i < 3; i++) {
//     if (Platform.isIOS) {
//       String? apnsToken = await FirebaseMessaging.instance.getAPNSToken();
//       if (apnsToken != null) {
//         await FirebaseMessaging.instance.subscribeToTopic('all');
//         subscribed = true;
//         break;
//       } else {
//         await Future<void>.delayed(const Duration(seconds: 2));
//       }
//     } else {
//       await FirebaseMessaging.instance.subscribeToTopic('all');
//       subscribed = true;
//       break;
//     }
//   }

//   if (!subscribed) {
//     log('Failed to subscribe to general topic');
//   }
// }
