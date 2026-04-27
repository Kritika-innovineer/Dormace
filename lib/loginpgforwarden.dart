import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:hostel_app/homepage.dart';

import 'package:hostel_app/notificationserviceclass.dart';
import 'package:hostel_app/wardenhomepg.dart';
import 'loginpgofstudent.dart';

class loginpgofwarden extends StatefulWidget {
  @override
  State<loginpgofwarden> createState() => _loginpgofwardenState();
}

class _loginpgofwardenState extends State<loginpgofwarden> {
  TextEditingController mailcontroller = TextEditingController();

  TextEditingController passcontroller = TextEditingController();

  bool ishidden = true;

  @override
  /* Future<void> signinwithgoogle() async {
      try {
        final GoogleSignInAccount? googleuser = await GoogleSignIn().signIn();

        if (googleuser == null) return;

        final GoogleSignInAuthentication googleauth =
            await googleuser.authentication;

        final credential = GoogleAuthProvider.credential(
          accessToken: googleauth.accessToken,
          idToken: googleauth.idToken,
        );

        await FirebaseAuth.instance.signInWithCredential(credential);

        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("Google Login Successful ✅")),
        );

        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => wardenhomepg()),
        );
      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("Google Login Failed: $e")),
        );
      }
    }*/
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Warden Login",
              style: TextStyle(fontSize: 17, fontWeight: FontWeight.w500)),
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
                height: 300,
                width: 360,
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      SizedBox(
                        height: 60,
                        width: 300,
                        child: TextField(
                          controller: mailcontroller,
                          keyboardType: TextInputType.text,
                          decoration: InputDecoration(
                            hintText: "Enter email",
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(20),
                            ),
                          ),
                        ),
                      ),

                      SizedBox(height: 20),

                      // Password
                      SizedBox(
                        height: 60,
                        width: 300,
                        child: TextField(
                          controller: passcontroller,
                          keyboardType: TextInputType.text,
                          obscureText: ishidden,
                          decoration: InputDecoration(
                            suffixIcon: IconButton(
                                onPressed: () {
                                  setState(() {
                                    if (ishidden == true)
                                      ishidden = false;
                                    else {
                                      ishidden = true;

                                    }
                                  });
                                },
                                icon: Icon(ishidden
                                    ? Icons.visibility
                                    : Icons.visibility_off)),
                            hintText: "Enter your password",
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(20),
                            ),
                          ),
                        ),
                      ),

                      SizedBox(height: 30),

                      // Email Login Button
                      SizedBox(
                        height: 50,
                        width: 300,
                        child: ElevatedButton(
                          onPressed: () async {
                            String mail = mailcontroller.text.trim();
                            String pass = passcontroller.text.trim();

                            if (mail.isEmpty || pass.isEmpty) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                    content: Text("Please enter all fields")),
                              );
                              return;
                            }

                            try {
                              await FirebaseAuth.instance
                                  .signInWithEmailAndPassword(
                                email: mail,
                                password: pass,
                              );

                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(content: Text("Login successful ✅")),
                              );

                              notificationserviceclass obj =
                                  notificationserviceclass();
                              String? devicetoken = await obj.getfcmToken();
                              await FirebaseFirestore.instance
                                  .collection("wardenprofiledata")
                                  .doc(FirebaseAuth.instance.currentUser!.uid)
                                  .set({
                                "email": mail,
                                "deviceToken": devicetoken.toString(),
                              }, SetOptions(merge: true));
                              String curruseruid =
                                  FirebaseAuth.instance.currentUser!.uid;

                              DocumentSnapshot snapshot =
                                  await FirebaseFirestore.instance
                                      .collection("wardenprofiledata")
                                      .doc(curruseruid)
                                      .get();

                              var data =
                                  snapshot.data() as Map<String, dynamic>;
                              
                                Navigator.pushReplacement(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => wardenhomepg()));
                              
                            } catch (e) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(content: Text("Error: $e")),
                              );
                            }
                          },
                          style: ElevatedButton.styleFrom(
                            elevation: 4,
                            backgroundColor: Colors.blueAccent,
                            foregroundColor: Colors.white,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(14),
                            ),
                          ),
                          child: Text("Log in", style: TextStyle(fontSize: 17)),
                        ),
                      ),

                      SizedBox(height: 15),
                    ],
                  ),
                ),
              ),
            )));
  }
}
