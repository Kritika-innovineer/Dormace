import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'fingerprintRequired.dart';
import 'homepage.dart';
import 'main.dart';
import 'profileclass.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';

class loginofstudentforemailpassauthentication extends StatefulWidget {
  @override
  State<loginofstudentforemailpassauthentication> createState() => _loginofstudentforemailpassauthenticationState();
}

class _loginofstudentforemailpassauthenticationState extends State<loginofstudentforemailpassauthentication> {
  TextEditingController emailcontroller = TextEditingController();

  TextEditingController passwordcontroller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Email Password Sign-In",style: TextStyle(fontSize: 17, fontWeight: FontWeight.w500)),
        ),
        body: 
Container(
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
                    Text("Email",
                        style: TextStyle(
                            fontSize: 17, fontWeight: FontWeight.w500)),
                    SizedBox(height: 9),
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
                   Text("Password",
                        style: TextStyle(
                            fontSize: 17, fontWeight: FontWeight.w500)),
                    SizedBox(height: 9),
                    SizedBox(
                      height: 60,
                      width: 300,
                      child: TextField(
                        controller: emailcontroller,
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
                  
                  ],
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
                      }
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
                SizedBox(
                  height: 50,
                  width: 300,
                  child: ElevatedButton(
                    onPressed: () async {
                     
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

                SizedBox(height: 20),

                InkWell(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) =>homepage()),
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