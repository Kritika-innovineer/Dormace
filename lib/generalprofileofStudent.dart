import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'loginOptions.dart';
import 'loginpgofstudent.dart';
import 'signinOptions.dart';
import 'startoptions.dart';
import 'package:url_launcher/url_launcher.dart';
class generalprofilepgofStudent extends StatefulWidget {
  @override
  State<generalprofilepgofStudent> createState() => _settingspgState();
}

class _settingspgState extends State<generalprofilepgofStudent> {
  var currPassController = TextEditingController();

  var newPassController = TextEditingController();

  var confirmPassController = TextEditingController();
  bool ischangedpass = false;
  var feedbackcontroller = TextEditingController();

  bool currState = false;
  var feedbackController = TextEditingController();
  @override
  Widget build(BuildContext context) {
     String curruid = FirebaseAuth.instance.currentUser!.uid;
    return Scaffold(
      appBar: AppBar(
        title: Text("Profile",style: TextStyle(fontSize: 17, fontWeight: FontWeight.w500)),
      ),
      body: Container(
        height: double.infinity,
        width: double.infinity,
        color: Colors.grey.shade200,
        child: SingleChildScrollView(
          child: Column(
            children: [
            SizedBox(height: 2,),
            StreamBuilder<DocumentSnapshot>(
              stream: FirebaseFirestore.instance
                  .collection("userprofiledata").doc(curruid).snapshots(),


                
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(child: CircularProgressIndicator());
                }

                if (!snapshot.hasData || !snapshot.data!.exists) {
                  return Center(child: Text("Profile not found"));
                }

                var data = snapshot.data!.data() as Map<String, dynamic>;

                return Container(
                 
                
               
                height: 150,
                width: 370,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(10),
                      topRight: Radius.circular(10)),
                ),
                  margin: EdgeInsets.symmetric(vertical: 10),
                  child: Container(
                    padding: EdgeInsets.all(20),
                    child: Row(
                      children: [
                        // Profile Image
                        CircleAvatar(
                          radius: 45,
                          

                          child: Icon(
                            Icons.person,
                            color: Colors.black,
                            size: 40,
                          ),
                        ),
                        SizedBox(width: 20),
                        // Profile Details
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              data["name"] ?? "Your Name",
                              style: TextStyle(
                                  fontSize: 15,
                                  fontWeight: FontWeight.w500,
                                  color:  Colors.grey.shade600),
                            ),
                           
                            Text(
                              data["hostelname"] ?? "Hostel: Not set",
                              style: TextStyle(
                                  fontSize: 15,
                                  fontWeight: FontWeight.w500, color: Colors.grey.shade600),
                            ),
                            Text(
                              data["roomno"] ?? "Room No: Not set",
                              style: TextStyle(
                                  fontSize: 15,
                                  fontWeight: FontWeight.w500, color: Colors.grey.shade600),
                            ),
                            Text(
                              data["studentId"] ?? "Student ID: Not set",
                              style: TextStyle(
                                  fontSize: 15,
                                  fontWeight: FontWeight.w500, color: Colors.grey.shade600),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
       
              SizedBox(
             height: 2,
              ),
           /*   Container(
                padding: EdgeInsets.all(20),
                height: 70,
                width: 370,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(10),
                      topRight: Radius.circular(10)),
                ),
                child: Text(
                  "Account Settings",
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
              ), */
             /* SizedBox.square(dimension: 1),
              InkWell(
                onTap: () {
                  showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return AlertDialog(
                          title: Text("Change password"),
                          actions: [
                            Row(
                              children: [
                                ElevatedButton(
                                  onPressed: () {
                                    changepassword();
                                    if (ischangedpass == true) {
                                      Navigator.pop(context);
                                      currPassController.clear();
                                      confirmPassController.clear();
                                      newPassController.clear();
                                    }

                                    ischangedpass = false;
                                  },
                                  child: Text("Update password"),
                                ),
                                SizedBox(width: 10),
                                TextButton(
                                    onPressed: () {
                                      Navigator.pop(context);
                                    },
                                    child: Text("Cancel")),
                              ],
                            )
                          ],
                          content: Container(
                            height: 400,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text("Current password"),
                                SizedBox.square(dimension: 30),
                                Container(
                                  width: 330,
                                  height: 50,
                                  child: TextField(
                                    obscureText: true,
                                    controller: currPassController,
                                    keyboardType: TextInputType.text,
                                    decoration: InputDecoration(
                                      hintText: "Enter current password",
                                      border: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(10),
                                          borderSide: BorderSide(
                                            color: Colors.grey,
                                            width: 1,
                                          )),
                                    ),
                                  ),
                                ),
                                SizedBox.square(dimension: 30),
                                Text("New password"),
                                SizedBox.square(dimension: 30),
                                Container(
                                  width: 330,
                                  height: 50,
                                  child: TextField(
                                    obscureText: true,
                                    controller: newPassController,
                                    keyboardType: TextInputType.text,
                                    decoration: InputDecoration(
                                      hintText: "Enter new password",
                                      border: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(10),
                                          borderSide: BorderSide(
                                            color: Colors.grey,
                                            width: 1,
                                          )),
                                    ),
                                  ),
                                ),
                                SizedBox.square(dimension: 30),
                                Text("Confirm password"),
                                SizedBox.square(dimension: 30),
                                Container(
                                  width: 330,
                                  height: 50,
                                  child: TextField(
                                    controller: confirmPassController,
                                    keyboardType: TextInputType.text,
                                    decoration: InputDecoration(
                                      hintText: "Confirm password",
                                      border: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(10),
                                          borderSide: BorderSide(
                                            color: Colors.grey,
                                            width: 1,
                                          )),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        );
                      });
                },
                child: Container(
                  padding: EdgeInsets.all(20),
                  height: 90,
                  width: 370,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(10),
                        bottomRight: Radius.circular(10)),
                  ),
                  child: Row(children: [
                    CircleAvatar(
                      radius: 25,
                      child: Icon(
                        Icons.lock,
                      size: 17,
                      ),
                    ),
                    SizedBox.square(
                      dimension: 14,
                    ),
                    Text("Change Password", style: TextStyle(fontSize: 15)),
                    SizedBox.square(dimension: 80),
                    Icon(Icons.arrow_drop_down),
                  ]),
                ),
              ),*/
             
              Container(
                padding: EdgeInsets.all(20),
                height: 70,
                width: 370,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(10),
                      topRight: Radius.circular(10)),
                ),
                child: Text(
                  "App Settings",
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
              ),
            SizedBox(
             height: 2,
              ),
              Container(
                padding: EdgeInsets.all(20),
                height: 90,
                width: 370,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(10),
                      bottomRight: Radius.circular(10)),
                ),
                child: Row(children: [
                  CircleAvatar(
                    radius: 25,
                    child: Icon(
                      Icons.notifications,
                      size: 17,
                    ),
                  ),
                  SizedBox.square(
                    dimension: 14,
                  ),
                  Text("Notifications", style: TextStyle(fontSize: 15)),
                  SizedBox(
                    width: 100,
                  ),
                  Switch(
                      value: currState,
                      onChanged: (value) {
                        setState(() {
                          currState = value;
                        });
                      })
                ]),
              ),
                SizedBox(height: 12,),
              InkWell(
                onTap: () {
                  showDialog(
                      context: context,
                      builder: (context) {
                        return AlertDialog(
                            title: Text("Give Feedback"),
                            actions: [
                              ElevatedButton(
                                  onPressed: () {}, child: Text("Send")),
                              TextButton(
                                  onPressed: () {}, child: Text("Cancel")),
                            ],
                            content: Container(
                              child: Column(
                                children: [
                                  Text("Would like to share anything?"),
                                  TextField(
                                    controller: feedbackController,
                                    keyboardType: TextInputType.text,
                                    decoration: InputDecoration(
                                      border: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(10),
                                          borderSide: BorderSide(
                                            color: Colors.grey,
                                            width: 1,
                                          )),
                                    ),
                                  ),
                                ],
                              ),
                            ));
                      });
                },
                child: Container(
                  padding: EdgeInsets.all(20),
                  height: 70,
                  width: 370,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(10),
                        topRight: Radius.circular(10)),
                  ),
                  child: Text(
                    "Support",
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                ),
              ),
              SizedBox.square(dimension: 2),
              InkWell(
                onTap: () async{
                 final Uri url = Uri.parse("https://forms.gle/ybx1coz3izSpP8yf6");
              if(!await launchUrl(url, 
              mode: LaunchMode.externalApplication,

              )
              ){
                 ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Could not open feedback form")),
      );
              }
                },
                child: Container(
                  padding: EdgeInsets.all(20),
                  height: 90,
                  width: 370,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(10),
                        bottomRight: Radius.circular(10)),
                  ),
                  child: Row(children: [
                    CircleAvatar(
                      radius: 25,
                      child: Icon(
                        Icons.message,
                        size: 14,
                      ),
                    ),
                    SizedBox.square(
                      dimension: 14,
                    ),
                    Text("Give Feedback", style: TextStyle(fontSize: 15)),
                  ]),
                ),
              ),
               SizedBox(height: 12,),
              InkWell(
                onTap: () {
                  showDialog(
                      context: context,
                      builder: (context) {
                        return AlertDialog(
                          title: Text("Want to log out?"),
                          actions: [
                            TextButton(
                                onPressed: () {
                                  Navigator.pop(context);
                                },
                                child: Text("Cancel")),
                            ElevatedButton(
                                onPressed: () async {
                               

                                  await FirebaseAuth.instance.signOut();

                               Navigator.pushAndRemoveUntil(
  context,
  MaterialPageRoute(builder: (context) =>loginoptions()),
  (route) => false,
);

                                },
                                child: Text("Logout")),
                          ],
                        );
                      });
                },
                child: Container(
                  padding: EdgeInsets.all(20),
               
                  height: 90,
                  width: 370,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(10),
                        bottomRight: Radius.circular(10)),
                  ),
                  child: Row(children: [
                    CircleAvatar(
                      radius: 25,
                      child: Icon(
                        Icons.logout,
                    size: 17,
                        color: Colors.black,
                      ),
                    ),
                    SizedBox.square(
                      dimension: 14,
                    ),
                    Text("Logout",
                        style: TextStyle(fontSize: 15, color: Colors.black)),
                  ]),
                ),
              ),
                SizedBox(height: 12,),
               InkWell(
                onTap: () {
                  showDialog(
                      context: context,
                      builder: (context) {
                        return AlertDialog(
                          title: Text("Want to delete account?"),
                          actions: [
                            TextButton(
                                onPressed: () {
                                  Navigator.pop(context);
                                },
                                child: Text("Cancel")),
                            ElevatedButton(
                                onPressed: () async {
                               

                                  await FirebaseAuth.instance.currentUser?.delete();
ScaffoldMessenger.of(context).showSnackBar(SnackBar(content:Text("Account deleted successfully !")));

                              Navigator.pushAndRemoveUntil(
  context,
  MaterialPageRoute(builder: (context) => startoptions()),
  (route) => false,
);

    
                                },
                                child: Text("Delete")),
                          ],
                        );
                      });
                },
                child: Container(
                  padding: EdgeInsets.all(20),
                  margin: EdgeInsets.only(bottom: 50),
                  height: 90,
                  width: 370,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(10),
                        bottomRight: Radius.circular(10)),
                  ),
                  child: Row(children: [
                    CircleAvatar(
                      radius: 25,
                      child: Icon(
                        Icons.delete,
                        size: 17,
                        color: Colors.red,
                      ),
                    ),
                    SizedBox.square(
                      dimension: 14,
                    ),
                    Text("Delete my account",
                        style: TextStyle(fontSize: 15, color: Colors.red)),
                  ]),
                ),
              ),
                 SizedBox(height: 12,),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> changepassword() async {
    try {
      String currpass = currPassController.text;
      String confirmpass = confirmPassController.text;
      String newpass = newPassController.text;

      if (newpass != confirmpass) {
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text("Passwords dont match")));

        return;
      } else {
        User? user = FirebaseAuth.instance.currentUser;
        if (user == null) {
          return;
        }
        AuthCredential credential = EmailAuthProvider.credential(
            email: user.email!, password: currpass);
        await user.reauthenticateWithCredential(credential);
        await user.updatePassword(newpass);
        ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text("Password changed successfully")));
        ischangedpass = true;
      }
    } catch (e) {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text("Error updating: ${e}")));
    }
  }
}
