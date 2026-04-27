import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'homepage.dart';
import 'package:local_auth/local_auth.dart';

class verificationpg extends StatefulWidget {
  @override
  State<verificationpg> createState() => _verificationpgState();
}

class _verificationpgState extends State<verificationpg> {
  bool loading = false;

  Future<void> markAttendance() async {
    try {
      setState(() {
        loading = true;
      });

      String uid = FirebaseAuth.instance.currentUser!.uid;

      DocumentSnapshot doc = await FirebaseFirestore.instance
          .collection("userprofiledata")
          .doc(uid)
          .get();

      if (!doc.exists || doc.data() == null) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("User profile not found !!!")),
        );
        setState(() {
          loading = false;
        });
        return;
      }

      Map<String, dynamic> data = doc.data() as Map<String, dynamic>;

      bool enabled = data["biometricEnabled"] ?? false;

      if (enabled == false) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("Enable biometric first ❌")),
        );

        setState(() {
          loading = false;
        });
        return;
      }

      LocalAuthentication auth = LocalAuthentication();

      bool canCheck = await auth.canCheckBiometrics;
      if (!canCheck) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("Biometric not available on this device ❌")),
        );

        setState(() {
          loading = false;
        });
        return;
      }

      bool verified = await auth.authenticate(
        localizedReason: "Verify fingerprint to mark attendance",
        options: const AuthenticationOptions(
          biometricOnly: true,
          stickyAuth: true,
        ),
      );

      if (!verified) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("Verification Failed ❌")),
        );

        setState(() {
          loading = false;
        });
        return;
      }

 String curruid = FirebaseAuth.instance.currentUser!.uid;

 var existingLeaveQuery = await FirebaseFirestore.instance
                                  .collection("studentsleave")
                                  .doc(curruid)
                                  .collection("leaves")
                                  .where("hostelstatus", isEqualTo: "left")
                                  .get();

                              if (existingLeaveQuery.docs.isNotEmpty) {
                                ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(
                                        content: Text("You are on leave, please entry first to mark today's attendance")));
                                return;
                              }
      String today = DateTime.now().toString().substring(0, 10);

      DocumentReference attendanceDoc = FirebaseFirestore.instance
          .collection("studentsattendance")
          .doc(uid)
          .collection("records")
          .doc(today);

      DocumentSnapshot check = await attendanceDoc.get();

      if (check.exists) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("Attendance already marked today!!!")),
        );

        setState(() {
          loading = false;
        });
        return;
      }
      DateTime now = DateTime.now();
      String attendancedate = "${now.day}-${now.month}-${now.year}";
      String attendancemarktime = "${now.hour}:${now.minute}:${now.second}";


      await attendanceDoc.set({
        "date": attendancedate,
        "attendancestatus": "present",
        "name": data["name"],
        "roomno": data["roomno"],
        "time" : attendancemarktime,
        
      });

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Attendance Marked !")),
      );

      setState(() {
        loading = false;
      });
    } catch (e) {
      setState(() {
        loading = false;
      });

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Error: $e")),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Verification Page",style: TextStyle(fontSize: 17, fontWeight: FontWeight.w500)),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  height: 90,
                  width: 100,
                  child: Image.asset("assets/images/fingerprint.png"),
                ),
                SizedBox(width: 30),
                SizedBox(
                  height: 100,
                  width: 100,
                  child: Image.asset("assets/images/face.png"),
                ),
              ],
            ),
            SizedBox(height: 30),
            SizedBox(
              height: 50,
              width: 300,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  elevation: 5,
                  backgroundColor: Colors.blueAccent,
                  foregroundColor: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(14),
                  ),
                ),
                onPressed: loading
                    ? null
                    : () async {
                        await markAttendance();

                        Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                                builder: (context) => homepage()));
                      },
                child: loading
                    ? SizedBox(
                        height: 25,
                        width: 25,
                        child: CircularProgressIndicator(
                          color: Colors.white,
                          strokeWidth: 3,
                        ),
                      )
                    : Text("Verify", style: TextStyle(fontSize: 25)),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
