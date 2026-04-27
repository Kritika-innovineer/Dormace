import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/services.dart' show rootBundle;
import 'package:googleapis_auth/auth_io.dart' as auth;

class notificationserviceclass {
  FirebaseMessaging messaging = FirebaseMessaging.instance;
  // this object will help app receive, send, handle push notifications
  void requestnotificationPermission() async {
    NotificationSettings settings = await messaging.requestPermission(
      // this stores the current state of user notification permission
      alert: true, // allows notificaiton to come as pop up
      badge: true, // notifiaciton is shown under app icon
      criticalAlert: true, //high alert notification , means emergency
      sound:
          true, // vo avaj jo sunayi dengi, jb notification ayegi, custom sound bhi lga skte h
    );
    if (settings.authorizationStatus == AuthorizationStatus.authorized) {
      print("");
    } else if (settings.authorizationStatus ==
        AuthorizationStatus.provisional) {
      print("");
      // this permission is for ios devices
    } else {
      print("");
    }
  }

  Future<String?> getfcmToken() async {
    String? tokenofPhone = await messaging.getToken();
    print("Device token : ${tokenofPhone}");

    return tokenofPhone;
    // firebase uses fcm token to uniquely identify a device to send notification
    //VERY VERY IMP for push notifications
  }

  Future<String> getAccessToken() async {
    final String jsonString =
        await rootBundle.loadString('assets/service_account.json');
    final accountCredentials =
        auth.ServiceAccountCredentials.fromJson(jsonString);

    final scopes = ['https://www.googleapis.com/auth/firebase.messaging'];

    final authClient =
        await auth.clientViaServiceAccount(accountCredentials, scopes);
    final accessToken = authClient.credentials.accessToken.data;
    authClient.close();
    return accessToken;
  }

  Future<void> sendnotification(
      String receivertoken, String title, String body) async {
    
    // Extract project ID from the JSON
    final String jsonString =
        await rootBundle.loadString('assets/service_account.json');
    final decodedJson = jsonDecode(jsonString);
    final String projectId = decodedJson['project_id'];

    // Get the dynamically generated access token
    String serverToken = await getAccessToken();

    await http.post(
      Uri.parse(
          "https://fcm.googleapis.com/v1/projects/$projectId/messages:send"),
      headers: {
        "Content-Type": "application/json",
        "Authorization": "Bearer $serverToken"
      },
      body: jsonEncode({
        "message": {
          "token": receivertoken,
          "notification": {
            "title": title,
            "body": body
          }
        }
      }),
    );
  }
}
