import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hostel_app/generalprofileofStudent.dart';

import 'complainhomepg.dart';
import 'fingerprintRequired.dart';
import 'locationfetch.dart';
import 'main.dart';
import 'marketplace.dart';
import 'request.dart';
import 'sellitempg.dart';
import 'splashScreenofhostelmart.dart';
import 'splashscreenofattendance.dart';
import 'splashscreenofcomplaintpg.dart';

class homepage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Home Page",style: TextStyle(fontSize: 17, fontWeight: FontWeight.w500)),
        actions: [ IconButton(
        

      icon: Icon(Icons.person, color: Colors.black,size: 26,),
      onPressed: () {
         Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => generalprofilepgofStudent()));
      },
    ),],
      ),
      body:
      Center(

        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
     

           
             Container(
              width: 300,
                height: 140,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                    elevation: 4,
                    backgroundColor: Colors.blueAccent,
                    foregroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(14),
                    )),
                onPressed: () {
                  
                  
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => splashScreenfohostelmart()));
                  
                },
                child:Stack(

                  children: [
                     Positioned(
                       left: 18,
                      top: 20,
                       child: Container(
                            height: 28,
                          
                            child:Image.asset("assets/images/cart.png")),
                     ),

                     
                    Positioned(
                      top: 55,
                         left: 18,
                      child: Text("Hostel Mart",
                          style:
                              TextStyle(fontSize: 19, fontWeight: FontWeight.bold)),
                    ),
                    Positioned(
                      top: 85,
                         left: 18,
                      child: Text("Buy Sell Request Items",
                          style:
                              TextStyle(fontSize: 13, fontWeight: FontWeight.w400)),
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(height: 20,),
             Container(
              width: 300,
                height: 140,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                    elevation: 4,
                    backgroundColor: Colors.blueAccent,
                    foregroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(14),
                    )),
                onPressed: () {
                  
                  
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => splashScreenfoattendance()));
                  
                },
                child:Stack(

                  children: [
                     Positioned(
                      left: 18,
                      top: 30,
                       child: Container(
                            height: 28,
                          
                            child: Icon(Icons.location_on,size: 30,),),
                     ),

                     
                    Positioned(
                      top: 70,
                         left: 18,
                      child: Text("Attendance",
                          style:
                              TextStyle(fontSize: 19, fontWeight: FontWeight.bold)),
                    ),
                  ],
                ),
              ),
            ),
           SizedBox(height: 20,),
              Container(
              width: 300,
                height: 140,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                    elevation: 4,
                    backgroundColor: Colors.blueAccent,
                    foregroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(14),
                    )),
                onPressed: () {
                  
                  
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => splashScreenofcomplaint()));
                  
                },
                child:Stack(

                  children: [
                     Positioned(
                      left: 18,
                      top: 20,
                       child: Container(
                            height: 28,
                          
                            child:Container(
                            height: 28,
                          
                            child:Image.asset("assets/images/complain.png")),),
                     ),

                     
                    Positioned(
                      top: 50,
                         left: 18,
                      child: Text("Complaint",
                          style:
                              TextStyle(fontSize: 19, fontWeight: FontWeight.bold)),
                    ),
                    Positioned(
                      top: 80,
                         left: 18,
                      child: Container(
                        width: 240,
                        child: Text("Any problem you are facing in your hostel stay",
                            style:
                                TextStyle(fontSize: 13, fontWeight: FontWeight.w400)),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      )
    );
  }
}