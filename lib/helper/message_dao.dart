import 'package:elegant_notification/elegant_notification.dart';
import 'package:elegant_notification/resources/arrays.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:women_safety/util/theme/app_colors.dart';

class MessageDao {
  static final DatabaseReference messagesRef = FirebaseDatabase.instance.ref();
}

void showMessage({required String message, required BuildContext context}) {
  WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
    ElegantNotification.error(
      width: 360,
      height: 100,
      toastDuration: Duration(seconds: 20),
      notificationPosition: NotificationPosition.center,
      animation: AnimationType.fromLeft,
      title: Text('Warning',style: TextStyle(color: Colors.white,fontSize: 30)),
      description: Text(message),
      onDismiss: () {},
      background: colorPrimary,

    ).show(context);
  });
}
//
// void showMessage({required String message, required BuildContext context}) {
//   WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
//     ScaffoldMessenger.of(context).showSnackBar(
//       SnackBar(content: Text(message, style: const TextStyle(color: Colors.white)), backgroundColor: Colors.red),
//     );
//   });
// }
