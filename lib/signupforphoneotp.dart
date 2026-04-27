import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:hostel_app/DeviceIdService.dart';
import 'deviceidService.dart' hide DeviceIdService;
import 'loginOptions.dart';
import 'loginpgofstudent.dart';
import 'moreinfopg.dart';
import 'otppg.dart';

class signupforphoneotp extends StatefulWidget {
  @override
  State<signupforphoneotp> createState() => _signupforphoneotp();
}

class _signupforphoneotp extends State<signupforphoneotp> {

  @override
  Widget build(BuildContext context) {
    bool otpsent = false;
    String otpno = "";

    TextEditingController phonecontroller = TextEditingController();

    Future<void> sendotp() async {
      String phone = phonecontroller.text;
      if (phone.isEmpty || phone.length < 10) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("Enter valid phone number")),
        );
        return;
      }

      try {
        String deviceId = await DeviceIdService.getDeviceId();
        var query = await FirebaseFirestore.instance.collection("userprofiledata").where("deviceId", isEqualTo: deviceId).get();
        if(query.docs.isNotEmpty) {
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("An account has already been created on this device!")));
          return;
        }
      } catch (e) {
        // Continue if device info check fails unexpectedly
      }

      await FirebaseAuth.instance.verifyPhoneNumber(
          phoneNumber: "+91$phone",
          verificationCompleted: (PhoneAuthCredential cred) async {
            await FirebaseAuth.instance.signInWithCredential(cred);
          },
          verificationFailed: (FirebaseAuthException e) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text("Error: ${e.message}")),
            );
          },
          codeSent: (String verid, int? resendToken) {
          setState(() {
  otpsent = true;
  otpno = verid;
});
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => otppg(id: verid),
              ),
            );
          },
          codeAutoRetrievalTimeout: (String verid) {
            otpno = verid;
          });
    }

    return Scaffold(
      appBar: AppBar(
        title: Text("Sign up Page",style: TextStyle(fontSize: 17, fontWeight: FontWeight.w500)),
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
            height: 400,
            width: 330,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox.square(dimension: 25),
                Text("Sign - up",
                    style:
                        TextStyle(fontWeight: FontWeight.bold, fontSize: 30)),
                Text(
                  "DormACe",
                  style: TextStyle(fontSize: 18),
                ),
                SizedBox.square(dimension: 34),
                Container(
                  padding: EdgeInsets.only(left: 15, right: 15),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("Phone no",
                          style: TextStyle(
                              fontSize: 17, fontWeight: FontWeight.w500)),
                      SizedBox.square(dimension: 9),
                      SizedBox(
                        height: 60,
                        width: 300,
                        child: TextField(
                          controller: phonecontroller,
                          keyboardType: TextInputType.number,
                          decoration: InputDecoration(
                            hintText: "Enter your phone no",
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(20),
                            ),
                          ),
                        ),
                      ),
                      SizedBox.square(dimension: 28),
                      SizedBox(
                        height: 50,
                        width: 300,
                        child: ElevatedButton(
                          onPressed: () async {
                         await  sendotp();

                          },
                          style: ElevatedButton.styleFrom(
                            elevation: 4,
                            backgroundColor: Colors.green,
                            foregroundColor: Colors.white,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(14),
                            ),
                          ),
                          child: Text("Get OTP",
                              style: TextStyle(fontSize: 18)),
                        ),
                      ),
                      SizedBox.square(dimension: 18),
                      Center(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              "Already have an account?",
                              style: TextStyle(fontSize: 14.5),
                            ),
                            TextButton(
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => loginoptions()),
                                );
                              },
                              child: Text(
                                "Login",
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 14.5,
                                    color: Colors.blue),
                              ),
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
