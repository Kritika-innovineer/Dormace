import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Wardenattendancedashboard extends StatefulWidget {
  @override
  State<Wardenattendancedashboard> createState() => _WardenattendancedashboardState();
}

class _WardenattendancedashboardState extends State<Wardenattendancedashboard> {
  TextEditingController searchbarcontroller = TextEditingController();
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        title: Text("Attendance DashBoard",style: TextStyle(fontSize: 17, fontWeight: FontWeight.w500)),
      ),
      body: 
      Container(
        padding: EdgeInsets.all(15),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            
            SizedBox(
              height: 10,
            ),
 Row(
 
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                 Container(
                  padding: EdgeInsets.all(15),
                    height: 115,
                    
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(9),
                      color: Colors.grey.shade100,
                    ),
                    width: 160,
                    child: Column(
                     mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        StreamBuilder<QuerySnapshot>(
                            stream: FirebaseFirestore.instance
                                .collection("studentsattendance")
                               
                                .where("attendancestatus", isEqualTo: "present")
                                .snapshots(),
                            builder: (context, snapshot) {
                              if (!snapshot.hasData) {
                                return Text("Null",
                                    style: TextStyle(
                                        color: Colors.blueAccent,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 25));
                              }
                              return Center(
                                child: Text(snapshot.data!.docs.length.toString(),
                                    style: TextStyle(
                                        color: Colors.blueAccent,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 25)),
                              );
                            }),
                        Text("Total Students"),
                      ],
                    ),
                  ),
               
                SizedBox(width: 12),
                Container(
                  
                     padding: EdgeInsets.all(15),
                    height: 115,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(9),
                      color: Colors.grey.shade100,
                    ),
                    width: 160,
                    child: Column(
                       
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        StreamBuilder<QuerySnapshot>(
                            stream: FirebaseFirestore.instance
                                .collection("studentsattendance")
                               
                                .where("attendancestatus", isEqualTo: "present")
                                .snapshots(),
                            builder: (context, snapshot) {
                              if (!snapshot.hasData) {
                                return Text("Null",
                                    style: TextStyle(
                                        color: Colors.blueAccent,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 25));
                              }
                              return Text(snapshot.data!.docs.length.toString(),
                                  style: TextStyle(
                                      color: Colors.yellow.shade700,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 25));
                            }),
                        Text( "Total students attending Hostel"),
                      ],
                    ),
                  ),
              
               
                     SizedBox(width: 12),
                     
               
                
              ],
            ),
            SizedBox(height: 10,),
Row(
  
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                 Container(
                  padding: EdgeInsets.all(15),
                    height: 115,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(9),
                      color: Colors.grey.shade100,
                    ),
                    width: 160,
                    child: Column(
                      
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        StreamBuilder<QuerySnapshot>(
                            stream: FirebaseFirestore.instance
                                .collection("studentsattendance")
                               
                                .where("attendancestatus", isEqualTo: "present")
                                .snapshots(),
                            builder: (context, snapshot) {
                              if (!snapshot.hasData) {
                                return Text("Null",
                                    style: TextStyle(
                                        color: Colors.blueAccent,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 25));
                              }
                              return Text(snapshot.data!.docs.length.toString(),
                                  style: TextStyle(
                                      color: Colors.red,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 25));
                            }),
                        Text("Total Leaves"),
                      ],
                    ),
                  ),
               
                SizedBox(width: 12),
                 Container(
                           padding: EdgeInsets.all(15),
                    height: 115,
                    
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(9),
                      color: Colors.grey.shade100,
                    ),
                    width: 160,
                    child: Column(
                   
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        StreamBuilder<QuerySnapshot>(
                            stream: FirebaseFirestore.instance
                                .collection("Allsellingitems")
                                .where("uid",
                                    isEqualTo:
                                        FirebaseAuth.instance.currentUser!.uid)
                                .where("status", isEqualTo: "sold")
                                .snapshots(),
                            builder: (context, snapshot) {
                              if (!snapshot.hasData) {
                                return Text("Null",
                                    style: TextStyle(
                                        color: Colors.blueAccent,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 25));
                              }
                              return Text(snapshot.data!.docs.length.toString(),
                                  style: TextStyle(
                                      color: Colors.green,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 25));
                            }),
                        Text( "Total present"),
                      ],
                    ),
                  ),
               
                     SizedBox(width: 12),
                     
               
                
              ],
            ),
            
         /*   Row(
              children: [
                (Text("Filter by Date : ",
                    style:
                        TextStyle(fontWeight: FontWeight.bold, fontSize: 15))),
              ],
            ),*/
             SizedBox(height: 20),
             Text(
              "Students Present Today",
              style: TextStyle( fontSize: 15),
            ),
          
            SizedBox(height: 15),
             Container(
              width: 370,
              height: 45,
              child: TextField(
                controller: searchbarcontroller,
                keyboardType: TextInputType.text,
                decoration: InputDecoration(
                  hintText: "Search by name...",
                  prefixIcon: Icon(Icons.search),
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: BorderSide(
                      color: Colors.grey.shade100,
                        width: 1,
                      )),
                ),
              ),
            ),
            SizedBox(height: 15,),
            Container(
              width: 370,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text("Name"),
                  SizedBox(
                    width: 40,
                  ),
                  Text("Room No"),
                  SizedBox(
                    width: 40,
                  ),
                  Text("Time"),
                  SizedBox(
                    width: 40,
                  ),
                  Text("Status"),
                ],
              ),
            ),
            SizedBox(height: 8,),
             Expanded(
               child: StreamBuilder(
                     stream: FirebaseFirestore.instance
                          .collectionGroup("records")
                          .where("date", isEqualTo: "${DateTime.now().day}-${DateTime.now().month}-${DateTime.now().year}")
                          .where("attendancestatus", isEqualTo: "present")
                          .snapshots(),
                      builder: (context, snapshot) {
                        if (snapshot.connectionState == ConnectionState.waiting) {
                          return Center(child: CircularProgressIndicator());
                        }
               
                        if (snapshot.hasError) {
                          return Center(
                              child: Text("Error: ${snapshot.error}"));
                        }

                        if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
                          return Center(
                              child: Text("No attendance records today"));
                        }
                        var docs = snapshot.data!.docs.toList();
                        docs.sort((a, b) {
                          var dataA = a.data() as Map<String, dynamic>;
                          var dataB = b.data() as Map<String, dynamic>;
                          return (dataB["time"]?.toString() ?? "").compareTo(dataA["time"]?.toString() ?? "");
                        });
               
                        return ListView.builder(
                          itemCount: docs.length,
                          itemBuilder: (context, index) {
                            var doc = docs[index];
                            var data = doc.data() as Map<String, dynamic>;
                           
                          
                            return Container(
                height: 70,
                 width: 370,
               
               
               
               
                child: Card(
                  color: Colors.grey.shade100,
                  elevation: 2,
                  
                  child: Container(
                    height: 110,
                    padding: EdgeInsets.only(top: 22),
                    child: Stack(
                      children: [
                        Positioned(
                          left: 5,
                          child: Row(
                            children: [
                              Icon(Icons.person, size: 20,),
                              SizedBox(
                                width: 9,
                              ),
                              Text(data["name"] ?? "Unknown",
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold, fontSize: 15)),
                            ],
                          ),
                        ),
                        Positioned(
                            left: 120,
                            child: Text(data["roomno"] ?? "--",
                                style: TextStyle(
                                    fontWeight: FontWeight.bold, fontSize: 15))),
                        Positioned(
                            right: 80,
                            child: Text(data["time"] ?? "--:--",
                                style: TextStyle(
                                    fontWeight: FontWeight.bold, fontSize: 15))),
                        Positioned(
                            right: 10,
                            child: Text(data["attendancestatus"] ?? data["status"] ?? "",
                                style: TextStyle(
                                    fontWeight: FontWeight.bold, fontSize: 15))),
                      ],
                    ),
                  ),
                ),
                           );
               
               
                   }
                         );
                   }
                         ),
             ),
            ],
        ),
      ),
    );
  }
}
