import 'dart:core';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'homepage.dart';
import 'main.dart';
import 'package:local_auth/local_auth.dart';

class fingerprintrequired extends StatelessWidget {

  Future<void> enableBiometric(BuildContext context) async {
    LocalAuthentication auth = LocalAuthentication();

    bool canCheck = await auth.canCheckBiometrics;
    bool isDeviceSupported = await auth.isDeviceSupported();

    if (!canCheck || !isDeviceSupported) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Biometric not available on this device")),
      );
      return;
    }

    bool isAuthenticated = await auth.authenticate(
      localizedReason: "Enable fingerprint for attendance",
      options: const AuthenticationOptions(
        biometricOnly: true,
        stickyAuth: true,
      ),
    );

    if (isAuthenticated) {
      String uid = FirebaseAuth.instance.currentUser!.uid;

      await FirebaseFirestore.instance
          .collection("userprofiledata")
          .doc(uid)
          .set({"biometricEnabled": true}, SetOptions(merge: true));

      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => homepage()),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Fingerprint Required",style: TextStyle(fontSize: 17, fontWeight: FontWeight.w500))),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.fingerprint, size: 60),
            SizedBox(height: 25),
            SizedBox(
              height: 50,
              width: 300,
              child: ElevatedButton(
                onPressed: () async {
                  await enableBiometric(context);
                },
                child: Text("Give your authentication",
                    style: TextStyle(fontSize: 18)),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
