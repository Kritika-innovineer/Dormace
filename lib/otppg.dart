import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'deviceidService.dart';
import 'moreinfopg.dart';

class otppg extends StatefulWidget {
  final String id;
  otppg({required this.id});
  @override
  State<otppg> createState() => _signuppgState();
}

class _signuppgState extends State<otppg> {
  late String otpno;
  @override
  void initState() {
    super.initState();
    otpno = widget.id;

  }
  TextEditingController otpcontroller = TextEditingController();
  bool otpsent = false;

  bool otpverified = false;
  @override


  Future<void> verifyotp() async {
    String otp = otpcontroller.text;
    if (otp.isEmpty || otp.length < 6) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Enter valid otp")),
      );
      return;
    }
    try {
      PhoneAuthCredential credential =
          PhoneAuthProvider.credential(verificationId: otpno, smsCode: otp);
      await FirebaseAuth.instance.signInWithCredential(credential);
 setState(() {
  otpverified = true;
});

    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Invalid OTP")),
      );
      return;
    }
  }

  Future<void> createaccount() async {
    User? user = FirebaseAuth.instance.currentUser;
    if (user == null) return;

    String uid = user.uid;

 
    DocumentSnapshot doc = await FirebaseFirestore.instance
        .collection("userprofiledata")
        .doc(uid)
        .get();

    if (doc.exists) {
      print("Account already exists");
      return;
    }
    String deviceId = await DeviceIdService.getDeviceId();
    await FirebaseFirestore.instance
        .collection("userprofiledata")
        .doc(uid)
        .set({
      "uid": uid,
      "phoneno": user.phoneNumber,
      "acccreatedat": FieldValue.serverTimestamp(),
      "deviceid": deviceId,
    });
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text("Account created successfully")),
    );
  }

  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("OTP Verification Page"),
        ),
        body: Container(
          height: double.infinity,
          width: double.infinity,
          color: Colors.lightBlue.shade100,
          child: Center(
              child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(29),
                    color: Colors.white,
                  ),
                  height: 560,
                  width: 370,
                  child: Column(children: [
                    SizedBox(height: 25),
                    Text("OTP Verification",
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 30)),

                    // Email
                    Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text("OTP",
                              style: TextStyle(
                                  fontSize: 17, fontWeight: FontWeight.w500)),
                          SizedBox(height: 9),
                          SizedBox(
                            height: 60,
                            width: 300,
                            child: TextField(
                              controller: otpcontroller,
                              keyboardType: TextInputType.number,
                              decoration: InputDecoration(
                                hintText: "Enter otp",
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(20),
                                ),
                              ),
                            ),
                          ),
                          SizedBox(height: 20),
                          SizedBox(
                            height: 50,
                            width: 300,
                            child: ElevatedButton(
                              onPressed: () async {
                                String otp = otpcontroller.text.trim();

                                if (otp.isEmpty) {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(content: Text("Please enter otp")),
                                  );
                                  return;
                                }

                             await   verifyotp();
                                if (otpverified == true) {
                                 await  createaccount();
                                }
                                 Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) =>moreinfopg(),
              ),
            );
                              },
                              style: ElevatedButton.styleFrom(
                                elevation: 4,
                                backgroundColor: Colors.lightBlueAccent,
                                foregroundColor: Colors.white,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(14),
                                ),
                              ),
                              child: Text("Verify",
                                  style: TextStyle(fontSize: 17)),
                            ),
                          ),
                        ])
                  ]))),
        ));
  }
}
