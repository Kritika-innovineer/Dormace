import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:hostel_app/chathistory.dart';
import 'package:hostel_app/chatpg.dart';
import 'package:hostel_app/notificationserviceclass.dart';
import 'package:hostel_app/profilepgOfWarden.dart';
import 'package:hostel_app/splashscreenofapplogo.dart';


import 'allrequestsclass.dart';
import 'complainhomepg.dart';
import 'complainpage.dart';
import 'loginOptions.dart';
import 'fingerprintRequired.dart';
import 'forgotpassword.dart';
import 'homepage.dart';
import 'locationfetch.dart';
import 'loginpgofstudent.dart';
import 'marketplace.dart';
import 'moreinfopg.dart';
import 'myrequest.dart';

import 'proiflepgofHostelMart.dart';
import 'request.dart';
import 'sellitempg.dart';
import 'generalprofileofStudent.dart';
import 'signinOptions.dart';
import 'signuppgofstudentforemailpassauthentication.dart';
import 'signupforphoneotp.dart';

import 'startoptions.dart';
import 'verification.dart';
import 'viewprofilepg.dart';
import 'wardencomplaintdashboard.dart';
import 'wardenhomepg.dart';
import 'package:intl/intl.dart';

import 'package:shared_preferences/shared_preferences.dart';

// top level function, should not be insie any class, app is in terminated state means app is not opened
Future<void> backgroundmessageHandler(RemoteMessage message) async {
  await Firebase.initializeApp();
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  FirebaseMessaging.onBackgroundMessage(backgroundmessageHandler);

// for foreground app, like notification comes also when app is opened
  FirebaseMessaging messaging = FirebaseMessaging.instance;
  messaging.requestPermission();

  AndroidInitializationSettings androidsett =
      AndroidInitializationSettings("@drawable/app_icon");

  InitializationSettings initsett =
      InitializationSettings(android: androidsett);
  FlutterLocalNotificationsPlugin plugin = FlutterLocalNotificationsPlugin();

  plugin.initialize(initsett);

  //app open notification pop up
  FirebaseMessaging.onMessage.listen((RemoteMessage mssge) async {
    // 2 tarah ke notification hote h, NOTIFICATION MESSAGE (title and body hoti h) and CUSTOM DATA MESSAGE

    if (mssge.notification != null) {
      //ye android ke notif parameters set krta h
      AndroidNotificationDetails andDetails = AndroidNotificationDetails(
        "1234", // channel id = android me notif channel ke through show hoti hain
        "complaints",
        priority: Priority.high,
        importance: Importance.max,
      ); // channel name = category of noti (eg complaint notificaition)
      NotificationDetails notificationDetails =
          NotificationDetails(android: andDetails);
      await plugin.show(
        0, // notificaiion id h : every noti has a unique id
        mssge.notification!.title, // eg : new complaint
        mssge.notification!.body, // eg : 203 electrical issue
        notificationDetails, // jo uper define ki h, channel vgrh
      );
    }
  });

  runApp(
    kIsWeb ? const FlutterApp() : const FlutterApp(), // no DevicePreview on web
  );
}

class FlutterApp extends StatefulWidget {
  const FlutterApp({super.key});
  @override
  State<FlutterApp> createState() => _FlutterAppState();
}

class _FlutterAppState extends State<FlutterApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "flutterApp",
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
          primarySwatch: Colors.blue,
          scaffoldBackgroundColor: Colors.grey.shade50,
          appBarTheme: AppBarTheme(
            backgroundColor: Colors.grey.shade50,
          ),
          bottomNavigationBarTheme: BottomNavigationBarThemeData()),
      home: startoptions(),
    );
  }
}

class HomepgofStudentSection extends StatefulWidget {
  @override
  State<HomepgofStudentSection> createState() => _HomepgState();
}

class _HomepgState extends State<HomepgofStudentSection> {
  List screenList = [
    Homecontent(),
    marketplace(),
    myrequest(),
  chathistory(),


    profilepgofhostelmart(),
  ];
  int selectedItem = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: screenList[selectedItem],
        bottomNavigationBar: BottomNavigationBar(
          backgroundColor: Colors.white, // ← CHANGE TO WHITE
          selectedItemColor: Colors.blue,
          unselectedItemColor: Colors.grey, // ← CHANGE TO GREY
          type: BottomNavigationBarType.fixed, // ← ADD THIS
          items: <BottomNavigationBarItem>[
            BottomNavigationBarItem(icon: Icon(Icons.home), label: "Home"),
            BottomNavigationBarItem(
                icon: Icon(Icons.shopping_bag), label: "Marketplace"),
            BottomNavigationBarItem(
                icon: Icon(Icons.help), label: "My Requests"),
            BottomNavigationBarItem(icon: Icon(Icons.chat), label: "Chats"),
            BottomNavigationBarItem(icon: Icon(Icons.person), label: "Profile"),
          ],
          currentIndex: selectedItem,
          onTap: (setValue) {
            setState(() {
              selectedItem = setValue;
            });
          },
        ));
  }
}

class Homecontent extends StatefulWidget {
  @override
  State<Homecontent> createState() => _HomecontentState();
}

class _HomecontentState extends State<Homecontent> {
  List<StudentRequests> allrequests = [];

  var timingcontroller = TextEditingController();
  var additionaldetailscontroller = TextEditingController();
  String timeago(DateTime date) {
    final Duration diff = DateTime.now().difference(date);
    if (diff.inMinutes < 1) return "just now";
    if (diff.inHours < 1) {
      return "${diff.inMinutes} min ago";
    }
    if (diff.inDays < 1) return "${diff.inHours} hours ago";
    if (diff.inDays < 7) return "${diff.inDays} day ago";
    return "long time ago";
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text("HostelMart",
            style: TextStyle(fontSize: 17, fontWeight: FontWeight.w500)),
      ),
      body: SingleChildScrollView(
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          // LOGOUT BUTTON

        SizedBox(height: 17),

        // SELL & REQUEST
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              width: 175,
              child: ElevatedButton(
                onPressed: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => selllpg()));
                },
                style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blueAccent.shade700,
                    foregroundColor: Colors.white,
                    fixedSize: Size(180, 50),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(11))),
                child: Text("+ Sell Item", style: TextStyle(fontSize: 18)),
              ),
            ),
            SizedBox(width: 10),
            SizedBox(
              width: 190,
              child: ElevatedButton(
                onPressed: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => requestPg()));
                },
                style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.green,
                    fixedSize: Size(180, 50),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(11))),
                child: Row(
                  children: [
                    Icon(Icons.search, color: Colors.white),
                    SizedBox(width: 5),
                    Text("Request Item",
                        style: TextStyle(fontSize: 18, color: Colors.white)),
                  ],
                ),
              ),
            ),
          ],
        ),

        SizedBox(height: 30),

        Padding(
          padding: const EdgeInsets.only(left: 20),
          child: Text("All requests",
              style: TextStyle(fontSize: 19, fontWeight: FontWeight.w600)),
        ),

        SizedBox(height: 10),

        StreamBuilder<QuerySnapshot>(
          stream: FirebaseFirestore.instance
              .collection("studentsrequest").where("uid", isNotEqualTo:FirebaseAuth.instance.currentUser!.uid ).orderBy("createdat", descending: true)
              .where("status",
                  whereIn: ["notfulfilled", "statuspending"]).snapshots(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Container(
                height: 280,
                child: Center(child: CircularProgressIndicator()),
              );
            }

            if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
              return Container(
                height: 280,
                child: Center(child: Text("No requests yet")),
              );
            }

            var requests = snapshot.data!.docs;

            return ListView.builder(
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              itemCount: requests.length,
              itemBuilder: (context, index) {
                var doc = requests[index];
                var data = doc.data() as Map<String, dynamic>;
              
                String docID = doc.id;
               
                  return Container(
                    height: 190,
                    padding: EdgeInsets.only(left: 13, right: 13),
                    child: Card(
                      color: Colors.grey.shade50,
                      elevation: 2,
                      child: Stack(
                        children: [
                          Positioned(
                            left: 15,
                            top: 15,
                            child: Text(data["title"],
                                style: TextStyle(fontWeight: FontWeight.w600)),
                          ),
                          Positioned(
                              left: 15, top: 40, child: Text(data["desc"])),
                          Positioned(
                            left: 15,
                            bottom: 15,
                            child: Row(children: [
                              InkWell(
                                onTap: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => viewprofilepg(
                                            requestorid: data["uid"]),
                                      ));
                                },
                                child: CircleAvatar(
                                  radius: 20,
                                  child: Icon(
                                    Icons.person,
                                    size: 20,
                                    color: Colors.black54,
                                  ),
                                ),
                              ),
                              SizedBox(
                                width: 13,
                              ),
                              Text(data["name"],
                                  style:
                                      TextStyle(fontWeight: FontWeight.w500)),
                            ]),
                          ),
                          Positioned(
                            right: 15,
                            top: 15,
                            child: Container(
                              height: 33,
                              width: 100,
                              padding: EdgeInsets.all(6),
                              decoration: BoxDecoration(
                                color: data["need"] == "urgent"
                                    ? Colors.redAccent.shade100
                                    : Colors.green,
                                borderRadius: BorderRadius.circular(15),
                              ),
                              child: Center(
                                  child: Text(data["need"],
                                      style: TextStyle(
                                          color: data["need"] == "urgent"
                                              ? Colors.black
                                              : Colors.white))),
                            ),
                          ),
                          Positioned(
                              right: 15,
                              top: 65,
                              child: Container(
                                width: 190,
                                child: ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                      backgroundColor: Colors.grey.shade100,
                                      foregroundColor: Colors.black,
                                      shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(10))),
                                  onPressed: () {
                                     Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => chatpg(
                                  receiverId: data["uid"],
                                  receiverName:data["name"]?? "Requester",
                                )
                              ),
                            );
                                  },
                                  child: Text("Chat with requestor"),
                                ),
                              )),

                          /* Positioned(
                            right: 15,
                            bottom: 15,
                            child: Text(data["createdat"])),*/
                          Positioned(
                            right: 15,
                            top: 124,
                            child: ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                    backgroundColor: Colors.blueAccent.shade700,
                                    foregroundColor: Colors.white,
                                    shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(10))),
                                onPressed: () {
                                  showDialog(
                                      context: context,
                                      builder: (context) {
                                        return AlertDialog(
                                          title: Text("Help Out"),
                                          content: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            mainAxisSize: MainAxisSize.min,
                                            children: [
                                              Text(
                                                  "When can they come to your room? *"),
                                              SizedBox(height: 10),
                                              TextField(
                                                controller: timingcontroller,
                                                decoration: InputDecoration(
                                                    hintText: "eg : after 6 pm",
                                                    border:
                                                        OutlineInputBorder()),
                                              ),
                                              SizedBox(height: 20),
                                              Text("Any instruction"),
                                              SizedBox(height: 10),
                                              TextField(
                                                controller:
                                                    additionaldetailscontroller,
                                                decoration: InputDecoration(
                                                    hintText:
                                                        "Any specific instructions",
                                                    border:
                                                        OutlineInputBorder()),
                                              ),
                                            ],
                                          ),
                                          actions: [
                                            TextButton(
                                                onPressed: () {
                                                  Navigator.pop(context);
                                                },
                                                child: Text("Cancel")),
                                            ElevatedButton(
                                                onPressed: () async {
                                                  if (timingcontroller.text ==
                                                      ""|| additionaldetailscontroller.text == "") {
                                                    ScaffoldMessenger.of(
                                                            context)
                                                        .showSnackBar(SnackBar(
                                                            content: Text(
                                                                "Please first enter the fields")));
                                                    return;
                                                  }

                                                  String uid = FirebaseAuth
                                                      .instance
                                                      .currentUser!
                                                      .uid;
                                                  var userDoc =
                                                      await FirebaseFirestore
                                                          .instance
                                                          .collection(
                                                              "userprofiledata")
                                                          .doc(uid)
                                                          .get();
                                                  notificationserviceclass obj =
                                                      notificationserviceclass();
                                                  String? devicetokenofhelper =
                                                      await obj.getfcmToken();

                                                  await FirebaseFirestore
                                                      .instance
                                                      .collection(
                                                          "studentsrequest")
                                                      .doc(docID)
                                                      .collection("offers")
                                                      .doc(uid)
                                                      .set({
                                                    "availability":
                                                        additionaldetailscontroller
                                                            .text,
                                                    "instruction":
                                                        timingcontroller.text,
                                                    "offereruid":
                                                        userDoc["uid"],
                                                    "offerername":
                                                        userDoc["name"],
                                                    "helpofferedat": FieldValue
                                                        .serverTimestamp(),
                                                    "devicetokenofhelper":
                                                        devicetokenofhelper,
                                                  });

                                                  await FirebaseFirestore
                                                      .instance
                                                      .collection(
                                                          "studentsrequest")
                                                      .doc(docID)
                                                      .update({
                                                    "status": "statuspending",
                                                  });

                                                  String requestertoken = data[
                                                          "devicetokenofrequester"] ??
                                                      "";

                                                  if (requestertoken
                                                      .isNotEmpty) {
                                                    notificationserviceclass
                                                        objj =
                                                        notificationserviceclass();
                                                    await objj.sendnotification(
                                                        requestertoken,
                                                        "Help offer received !",
                                                        "${userDoc['name']} sent you an offer!");
                                                  }

                                                  Navigator.pop(context);
                                                  showDialog(
                                                      context: context,
                                                      builder: (context) {
                                                        return SizedBox.square(
                                                          dimension: 50,
                                                          child: Dialog(
                                                            child: Column(
                                                              mainAxisSize:
                                                                  MainAxisSize
                                                                      .min,
                                                              children: [
                                                                SizedBox.square(
                                                                    dimension:
                                                                        50,
                                                                    child: Image
                                                                        .asset(
                                                                            "assets/images/correct.png")),
                                                                Text(
                                                                  "Help offer Sent!",
                                                                  style: TextStyle(
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .bold),
                                                                ),
                                                                Text(
                                                                    " The requester will be notified about your offer."),
                                                                ElevatedButton(
                                                                    style: ElevatedButton.styleFrom(
                                                                        backgroundColor:
                                                                            Colors
                                                                                .green,
                                                                        foregroundColor:
                                                                            Colors
                                                                                .white,
                                                                        shape: RoundedRectangleBorder(
                                                                            borderRadius: BorderRadius.circular(
                                                                                10))),
                                                                    onPressed:
                                                                        () async {
                                                                      /*
                                                                    String
                                                                        helperuid =
                                                                        FirebaseAuth
                                                                            .instance
                                                                            .currentUser!
                                                                            .uid;
                                                                    String?
                                                                        helpername =
                                                                        FirebaseAuth
                                                                            .instance
                                                                            .currentUser!
                                                                            .displayName;

                                                                    await FirebaseFirestore
                                                                        .instance
                                                                        .collection(
                                                                            "studentsrequest")
                                                                        .doc(requests
                                                                            .docid)
                                                                        .collection(
                                                                            "offers")
                                                                        .add({
                                                                      "helperuid":
                                                                          helperuid,
                                                                      "helpername": FirebaseAuth
                                                                          .instance
                                                                          .currentUser!
                                                                          .displayName
                                                                          .toString(),
                                                                      "instruction":
                                                                          additionaldetailscontroller
                                                                              .text,
                                                                      "availability":
                                                                          timingcontroller
                                                                              .text,
                                                                      "title":requests
                                                                          .title
                                                                          .toString(),
                                                                      "desc": request1
                                                                          .desc
                                                                          .toString(),
                                                                      "createdat":
                                                                          FieldValue
                                                                              .serverTimestamp(),
                                                                      "requesteruid":
                                                                          request1
                                                                              .uid,
                                                                      "need": request1
                                                                          .need,
                                                                      "helpofferedname": request1
                                                                          .name
                                                                          .toString(),
                                                                    });

                                                                    await FirebaseFirestore
                                                                        .instance
                                                                        .collection(
                                                                            "studentsrequest")
                                                                        .doc(request1
                                                                            .docid)
                                                                        .collection(
                                                                            "fullfilledrequest")
                                                                        .add({
                                                                      "title":
                                                                          request1
                                                                              .title,
                                                                      "desc": request1
                                                                          .desc,
                                                                      "need": request1
                                                                          .need,
                                                                      "helpername":
                                                                          helpername,
                                                                      "helperuid":
                                                                          helperuid,
                                                                      "availability":
                                                                          timingcontroller
                                                                              .text,
                                                                      "instruction":
                                                                          additionaldetailscontroller
                                                                              .text,
                                                                      "requestdocid":
                                                                          request1
                                                                              .docid,
                                                                      "requesteruid":
                                                                          request1
                                                                              .uid,
                                                                    });
*/

                                                                      timingcontroller
                                                                          .clear();
                                                                      additionaldetailscontroller
                                                                          .clear();

                                                                      Navigator.pop(
                                                                          context);
                                                                    },
                                                                    child: Text(
                                                                        "OK"))
                                                              ],
                                                            ),
                                                          ),
                                                        );
                                                      });
                                                },
                                                child: Text("Send offer")),
                                          ],
                                        );
                                      });
                                },
                                child: Text("Help Out")),
                          ),
                        ],
                      ),
                    ),
                  );
                
              },
            );
          },
        )
      ]),
      ),
    );
  }

  /* Future<void> getrequest() async {
    allrequests.clear();
    String myuid = FirebaseAuth.instance.currentUser!.uid;

    QuerySnapshot snapshot =
        await FirebaseFirestore.instance.collection("studentsrequest").get();

    for (var doc in snapshot.docs) {
      var data = doc.data() as Map<String, dynamic>;
      if (data["uid"] == myuid) continue;

      // FIX: Convert Timestamp → String
      String formattedTime;
      if (data["createdat"] != null) {
        Timestamp ts = data["createdat"];
        DateTime dt = ts.toDate();
        formattedTime = DateFormat('dd MMM, hh:mm a').format(dt);
      } else {
        formattedTime = "Just now";
      }

      allrequests.add(StudentRequests(
        title: data["title"] ?? "No Title",
        desc: data["desc"] ?? "No Description",
        need: data["need"] ?? "Normal",
        requestat: formattedTime, // FIXED
        name: data["name"] ?? "Anonymous",
        roomno: data["roomno"] ?? "N/A",
        createdat: data["createdat"],
        docid: doc.id,
        uid: data["uid"],
      ));
    }

    setState(() {});
  } */
}
