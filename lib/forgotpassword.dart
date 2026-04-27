import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'loginpgofstudent.dart';

class forgotPasspg extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    var forgotpassHostelIdcontroller = TextEditingController();
    var forgotpassStudentIdcontroller = TextEditingController();
    var forgotpassEmailcontroller = TextEditingController();
   return Scaffold(
     appBar: AppBar(
       title: Text("Forgot pass page"),
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
                 height: 700,
                 width: 372,
                 child: Column(

                   children: [
                   SizedBox.square(dimension: 25,),
                 Text("HostelMart", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 30, fontFamily: "Myfont")),
                 Text("Buy & Sell In Your Hostel", style: TextStyle(fontSize: 18, color: Colors.grey.shade700),),
                 SizedBox.square(dimension: 34),
                     Text("Reset Password", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),),
                     SizedBox.square(dimension: 13),
                     Text("Enter your details to reset password", style: TextStyle(fontSize:17, color: Colors.grey.shade700),),
                     SizedBox.square(dimension: 23),
                     Column(
                       crossAxisAlignment: CrossAxisAlignment.start,
                       children: [
                         Text("Hostel Id", style: TextStyle(fontSize: 17, fontWeight: FontWeight.w500)),

                         SizedBox.square(dimension: 9),
                         SizedBox(
                           height: 60,
                           width: 300,
                           child: TextField(

                             controller:forgotpassHostelIdcontroller,
                             keyboardType: TextInputType.number,

                             decoration: InputDecoration(
                               hintText: "Enter your hostel ID",
                               border: OutlineInputBorder(
                                   borderRadius: BorderRadius.circular(20),
                                   borderSide: BorderSide(
                                     color: Colors.white,
                                   )
                               ),

                             ),

                           ),
                         ),
                         SizedBox.square(dimension: 20),
                         Text("Student Id", style: TextStyle(fontSize: 17, fontWeight: FontWeight.w500)),
                         SizedBox.square(dimension: 9),
                         SizedBox(
                           height: 60,
                           width: 300,
                           child: TextField(
                             controller: forgotpassStudentIdcontroller,
                             keyboardType: TextInputType.number,
                             decoration: InputDecoration(
                               hintText: "Enter your student ID",
                               border: OutlineInputBorder(
                                   borderRadius: BorderRadius.circular(20),
                                   borderSide: BorderSide(
                                     color: Colors.white,
                                   )
                               ),
                             ),
                           ),
                         ),
                         SizedBox.square(dimension: 20),
                         Text("Email", style: TextStyle(fontSize: 17, fontWeight: FontWeight.w500)),
                         SizedBox.square(dimension: 9),
                         SizedBox(
                           height: 60,
                           width: 300,
                           child: TextField(
                             controller: forgotpassEmailcontroller,
                             keyboardType: TextInputType.number,
                             decoration: InputDecoration(
                               hintText: "Enter your registered email",
                               border: OutlineInputBorder(
                                   borderRadius: BorderRadius.circular(20),
                                   borderSide: BorderSide(
                                     color: Colors.white,
                                   )
                               ),
                             ),
                           ),
                         ),




                       ],
                     ),
                     SizedBox.square(dimension: 20),
                     Container(
                       height: 50,
                       width: 300,
                       child: ElevatedButton(
                         onPressed: (){

                         },
                         style: ElevatedButton.styleFrom(
                             elevation: 4,
                             backgroundColor: Colors.deepOrange,
                             foregroundColor: Colors.white,
                             shape: RoundedRectangleBorder(
                               borderRadius: BorderRadius.circular(14),
                             )
                         ),
                         child: Text("Send Reset instructions", style: TextStyle(fontSize: 18)),
                       ),
                     ),
                     SizedBox.square(dimension: 26),
                     Row(
                       mainAxisAlignment: MainAxisAlignment.center,
                       children: [
                         Text("Remember your password?", style: TextStyle(fontSize: 16),),
                         InkWell(
                           onTap:(){
                             Navigator.push(context, MaterialPageRoute(builder: (context){
                               return loginpg();
                             }),
                             );
                           },
                             child: Text(
                               " Back to Login", style: TextStyle(color: Colors.blueAccent.shade700,fontSize: 16),)),
                       ],
                     ),

                     

],
                 ),
             ),
         ),

     ),

   );
  }
}