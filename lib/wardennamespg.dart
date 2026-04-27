import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'loginpgforwarden.dart';

class wardennamespg extends StatelessWidget{
  var namecontroller  = TextEditingController();
  var hostelnamecontroller = TextEditingController();
  var roomnocontroller = TextEditingController();
  var studentidcontroller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Warden",
            style: TextStyle(fontSize: 17, fontWeight: FontWeight.w500)) ,

      ),
      body:
        Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              width: 340,
              child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      elevation: 4,
                      backgroundColor: Colors.blueAccent,
                      foregroundColor: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(14),
                      )

                  ),
                  onPressed: (){Navigator.push(context, MaterialPageRoute(builder: (context)=>loginpgofwarden() ));
                  }, child:
                  Text("Login As Krishna", style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold)),
                 ),
            ),
            SizedBox(height: 20,),
            Container(
              width: 340,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                    elevation: 4,
                    backgroundColor: Colors.blueAccent,
                    foregroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(14),
                    )

                ),
                onPressed: (){Navigator.push(context, MaterialPageRoute(builder: (context)=>loginpgofwarden() ));
                }, child:
              Text("Login As Manoj", style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold)),
              ),
            ),
               SizedBox(height: 20,),
            Container(
              width: 340,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                    elevation: 4,
                    backgroundColor: Colors.blueAccent,
                    foregroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(14),
                    )

                ),
                onPressed: (){Navigator.push(context, MaterialPageRoute(builder: (context)=>loginpgofwarden() ));
                }, child:
              Text("Login As Bijendra", style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold)),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

    