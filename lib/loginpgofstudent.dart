import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:hostel_app/notificationserviceclass.dart';
import 'forgotpassword.dart';
import 'homepage.dart';
import 'otppg.dart';

class loginpg extends StatefulWidget {
  @override
  State<loginpg> createState() => _loginpgState();
}

class _loginpgState extends State<loginpg> {
  @override
 
 /* void initState() {
    super.initState();
    FirebaseAuth.instance.authStateChanges().listen((User? user) {
      if (user != null) {
        Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (context) => homepage()));
      }
    });

  
  }*/
  Future<void> signinwithgoogle() async {
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
          MaterialPageRoute(builder: (context) => homepage()),
        );
      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("Google Login Failed: $e")),
        );
      }
    }


  @override
  Widget build(BuildContext context) {
    var passcontroller = TextEditingController();
    var phonecontroller = TextEditingController();

    return Scaffold(
      appBar: AppBar(
        title: Text("Login Page",style: TextStyle(fontSize: 17, fontWeight: FontWeight.w500)),
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
              children: [
                SizedBox(height: 25),
                Text("HostelMart",
                    style:
                        TextStyle(fontWeight: FontWeight.bold, fontSize: 30)),
                Text("Buy & Sell In Your Hostel",
                    style: TextStyle(fontSize: 18)),
                SizedBox(height: 30),

                // Email
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("Phone no",
                        style: TextStyle(
                            fontSize: 17, fontWeight: FontWeight.w500)),
                    SizedBox(height: 9),
                    SizedBox(
                      height: 60,
                      width: 300,
                      child: TextField(
                        controller: phonecontroller,
                        keyboardType: TextInputType.number,
                        decoration: InputDecoration(
                          hintText: "Enter registered phone no",
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20),
                          ),
                        ),
                      ),
                    ),

                    SizedBox(height: 20),

                    // Password
                  /*  Text("Password",
                        style: TextStyle(
                            fontSize: 17, fontWeight: FontWeight.w500)),
                    SizedBox(height: 9),
                    SizedBox(
                      height: 60,
                      width: 300,
                      child: TextField(
                        controller: passcontroller,
                        obscureText: true,
                        decoration: InputDecoration(
                          hintText: "Enter your password",
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20),
                          ),
                        ),
                      ),
                    ),
                    */
                  ],
                ),

                SizedBox(height: 30),

                // Email Login Button
                SizedBox(
                  height: 50,
                  width: 300,
                  child: ElevatedButton(
                    onPressed: () async {
 await FirebaseAuth.instance.verifyPhoneNumber(verificationCompleted: (PhoneAuthCredential credential)async {
                        await FirebaseAuth.instance.signInWithCredential(credential);
                      
                      }, 
                      verificationFailed:(FirebaseAuthException e){
                        
                      }, codeSent: (String verificationId, int? resendToken) {
                          Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) =>otppg(id: verificationId) ),
                    );
                      }, codeAutoRetrievalTimeout:(String id){});



  notificationserviceclass obj =
                                      notificationserviceclass();
                                  String? studentdeviceToken =
                                      await obj.getfcmToken();
                                  await FirebaseFirestore.instance
                                      .collection("userprofiledata")
                                      .doc(FirebaseAuth
                                          .instance.currentUser!.uid)
                                      .set({"token":studentdeviceToken},SetOptions(merge: true))  ;



                   /*   String mail = mailcontroller.text.trim();
                      String pass = passcontroller.text.trim();

                      if (mail.isEmpty || pass.isEmpty) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text("Please enter all fields")),
                        );
                        return;
                      }

                      try {
                        await FirebaseAuth.instance.signInWithEmailAndPassword(
                          email: mail,
                          password: pass,
                        );

                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text("Login successful ✅")),
                        );

                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(builder: (context) => homepage()),
                        );
                      } catch (e) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text("Error: $e")),
                        );
                      }*/
                    },
                    style: ElevatedButton.styleFrom(
                      elevation: 4,
                      backgroundColor: Colors.lightBlueAccent,
                      foregroundColor: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(14),
                      ),
                    ),
                    child: Text("Login to HostelMart",
                        style: TextStyle(fontSize: 17)),
                  ),
                ),

                SizedBox(height: 15),

                // Google Login Button
           /*     SizedBox(
                  height: 50,
                  width: 300,
                  child: ElevatedButton(
                    onPressed: () async {
                      await signinwithgoogle();
                    },
                    style: ElevatedButton.styleFrom(
                      elevation: 4,
                      backgroundColor: Colors.redAccent,
                      foregroundColor: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(14),
                      ),
                    ),
                    child: Text("Continue with Google",
                        style: TextStyle(fontSize: 17)),
                  ),
                ),
*/
                SizedBox(height: 20),

                InkWell(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => forgotPasspg()),
                    );
                  },
                  child: Text(
                    "Forgot Password?",
                    style: TextStyle(color: Colors.lightBlue),
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
