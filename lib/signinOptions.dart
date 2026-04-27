import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'fingerprintRequired.dart';
import 'homepage.dart';
import 'loginOptions.dart';
import 'main.dart';
import 'moreinfopg.dart';
import 'profileclass.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'signuppgofstudentforemailpassauthentication.dart';
import 'signupforphoneotp.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'startoptions.dart';
import 'package:hostel_app/deviceidService.dart';

class signInoptions extends StatefulWidget {
  @override
  State<signInoptions> createState() => _loginoptionsState();
}

class _loginoptionsState extends State<signInoptions> {
  Future<void> signinwithgoogle() async {
    try {
      String deviceId = await DeviceIdService.getDeviceId();
      var query = await FirebaseFirestore.instance
          .collection("userprofiledata")
          .where("deviceId", isEqualTo: deviceId)
          .get();
      if (query.docs.isNotEmpty) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            content:
                Text("An account has already been created on this device!")));
        return;
      }

      await GoogleSignIn().signOut();
      GoogleSignInAccount? googleuser = await GoogleSignIn().signIn();
      if (googleuser == null) {
        return;
      }
      GoogleSignInAuthentication googleauth = await googleuser.authentication;
      final cred = GoogleAuthProvider.credential(
        accessToken: googleauth.accessToken,
        idToken: googleauth.idToken,
      );
      UserCredential usercred =
          await FirebaseAuth.instance.signInWithCredential(cred);
      Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(builder: (context) => moreinfopg()),
        (route) => false,
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Google Sign-In Failed, Error : ${e}")),
      );
    }
  }

  TextEditingController emailcontroller = TextEditingController();

  TextEditingController passwordcontroller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Create account",
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
              height: 550,
              width: 360,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(
                    height: 20,
                  ),
                  Container(
                    height: 50,
                    width: 300,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          elevation: 4,
                          backgroundColor: Colors.blueAccent,
                          foregroundColor: Colors.white,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(14),
                          )),
                      onPressed: () async {
                        await signinwithgoogle();
                      },
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                              height: 30,
                              padding: EdgeInsets.all(5),
                              decoration: BoxDecoration(
                                color: Colors.white, // white background
                                borderRadius:
                                    BorderRadius.circular(4), // rounded corners
                              ),
                              child:
                                  Image.asset("assets/images/googlelogo.png")),
                          SizedBox(
                            width: 10,
                          ),
                          Text("Continue With google",
                              style: TextStyle(
                                  fontSize: 17, fontWeight: FontWeight.bold)),
                        ],
                      ),
                    ),
                  ),

                  SizedBox(
                    height: 20,
                  ),
                  Text("or"),
                  SizedBox(height: 20),
                  Container(
                    width: 340,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          elevation: 2,
                          backgroundColor: Colors.white,
                          foregroundColor: Colors.black,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(14),
                          )),
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => signupforphoneotp()));
                      },
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.phone,
                            color: Colors.green,
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          Text("Continue With Phone",
                              style: TextStyle(
                                  fontSize: 17, fontWeight: FontWeight.bold)),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(height: 20),
                  Text("or"),
                  SizedBox(height: 20),

                  SizedBox(
                    height: 60,
                    width: 300,
                    child: TextField(
                      controller: emailcontroller,
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
                      controller: passwordcontroller,
                      keyboardType: TextInputType.text,
                      obscureText: true,
                      decoration: InputDecoration(
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
                        String mail = emailcontroller.text.trim();
                        String pass = passwordcontroller.text.trim();

                        if (mail.isEmpty || pass.isEmpty) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(content: Text("Please enter all fields")),
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
                        

                          UserCredential userCredential = await FirebaseAuth
                              .instance
                              .createUserWithEmailAndPassword(
                            email: mail,
                            password: pass,
                          );
                          await userCredential.user!.sendEmailVerification();

                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(content: Text("Sign up successful ✅")),
                          );

                          Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                                builder: (context) => moreinfopg()),
                          );
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
                      child: Text("Sign up", style: TextStyle(fontSize: 17)),
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
                            Navigator.pushAndRemoveUntil(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => loginoptions()),
                              (route) => false,
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
          ),
        ));
  }
}
