import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:hostel_app/businessclass.dart';
import 'package:hostel_app/imageselecterclass.dart';
import 'package:hostel_app/notificationserviceclass.dart';
import 'sellingitemsclass.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';

class selllpg extends StatefulWidget {
  @override
  State<selllpg> createState() => _selllpgState();
}

class _selllpgState extends State<selllpg> {
  bool isindvSelcted = true;
  bool isSelected = false;

  int selectedItem = 0;
  List<File> selectedimages = [];

// INDIVIDUAL
  TextEditingController pricecontrollerofINDIVIDUAL = TextEditingController();
  TextEditingController timingcontrollerINDIVIDUAL = TextEditingController();
  TextEditingController itemTitleControllerofINDIVIDUAL =
      TextEditingController();
  TextEditingController decriptioncontrollerofINDIVIDUAL =
      TextEditingController();

//BUSINESS
  TextEditingController pricecontrollerofBUSINESS = TextEditingController();
  TextEditingController timingcontrollerofBUSINESS = TextEditingController();
  TextEditingController titlecontrollerofBUSINESS = TextEditingController();
  TextEditingController collectiondescriptionControllerCfBUSINESS =
      TextEditingController();

  String dropdownvalue = "Select category";
  var items = [
    "Select category",
    "Earrings",
    "Books",
    "Clothing",
    "Electronics",
    "Shoes",
    "Food Item",
    "Others"
  ];
  String condnvalue = "Select condition";
  var condn = ["Select condition", "New", "Like new", "Litlle old", "Old"];
  bool isTicked = false;

  String logourlofBusiness = "";
  String imageurlofIndividualItem = "";

  List<int> businessitems = [1];
  List<BusinessClass> businesscollection = [
    BusinessClass(
      priceController: TextEditingController(),
      quantityController: TextEditingController(),
      titleController: TextEditingController(),
      descController: TextEditingController(),
    ),
  ];

  @override
  Widget build(context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Sell Item",
            style: TextStyle(fontSize: 17, fontWeight: FontWeight.w500)),
      ),
      body: Container(
        color: Colors.grey.shade100,
        child: ListView(
          padding: EdgeInsets.all(10),
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Center(
                  child: Container(
                    width: 380,
                    height: 200,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox.square(dimension: 18),
                        Container(
                            margin: EdgeInsets.only(left: 24),
                            child: Text("What are you selling *?",
                                style: TextStyle(
                                    fontWeight: FontWeight.w600,
                                    fontSize: 14))),
                        SizedBox.square(dimension: 10),
                        Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Container(
                                width: 160,
                                height: 135,
                                child: ElevatedButton(
                                    onPressed: () {
                                      setState(() {
                                        isindvSelcted = true;
                                        isSelected = true;
                                      });
                                    },
                                    style: ElevatedButton.styleFrom(
                                      side: BorderSide(
                                        color: isindvSelcted
                                            ? Colors.blueAccent
                                            : Colors.black26,
                                      ),
                                      backgroundColor: isindvSelcted
                                          ? Colors.lightBlueAccent.shade100
                                          : Colors.white,
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(12),
                                      ),
                                    ),
                                    child: Center(
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Icon(
                                            FontAwesomeIcons.person,
                                            color: isindvSelcted
                                                ? Colors.blueAccent
                                                : Colors.grey,
                                          ),
                                          SizedBox.square(
                                            dimension: 12,
                                          ),
                                          Text("Personal Item",
                                              style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                                color: isindvSelcted
                                                    ? Colors.blueAccent
                                                    : Colors.grey,
                                              )),
                                          Text(
                                            "Old/Used/New Individual Item",
                                            style:
                                                TextStyle(color: Colors.grey),
                                          ),
                                        ],
                                      ),
                                    )),
                              ),
                              SizedBox.square(
                                dimension: 13,
                              ),
                              Container(
                                width: 160,
                                height: 135,
                                child: ElevatedButton(
                                  onPressed: () {
                                    setState(() {
                                      isindvSelcted = false;
                                      isSelected = true;
                                    });
                                  },
                                  style: ElevatedButton.styleFrom(
                                    side: BorderSide(
                                        color: isindvSelcted
                                            ? Colors.black26
                                            : Colors.blue),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(12),
                                    ),
                                    backgroundColor: isindvSelcted
                                        ? Colors.white
                                        : Colors.lightBlueAccent.shade100,
                                  ),
                                  child: Center(
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        Icon(FontAwesomeIcons.shop,
                                            color: isindvSelcted
                                                ? Colors.grey
                                                : Colors.blue),
                                        SizedBox.square(
                                          dimension: 12,
                                        ),
                                        Text("Business Items",
                                            style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              color: isindvSelcted
                                                  ? Colors.grey
                                                  : Colors.blueAccent,
                                            )),
                                        Text("New Items for selling",
                                            textAlign: TextAlign.center,
                                            style:
                                                TextStyle(color: Colors.grey)),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ]),
                      ],
                    ),
                  ),
                ),
                SizedBox.square(
                  dimension: 22,
                ),
                isindvSelcted
                    ? Column(
                        children: [
                          Center(
                            child: Container(
                              width: 380,
                              height: 130,
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  SizedBox.square(dimension: 18),
                                  Container(
                                    margin: EdgeInsets.only(left: 24),
                                    child: Text(
                                        "When can customers visit your room?",
                                        style: TextStyle(
                                            fontWeight: FontWeight.w600,
                                            fontSize: 14)),
                                  ),
                                  SizedBox.square(dimension: 15),
                                  Center(
                                    child: Container(
                                      width: 330,
                                      height: 50,
                                      child: TextField(
                                        keyboardType: TextInputType.text,
                                        controller: timingcontrollerINDIVIDUAL,
                                        decoration: InputDecoration(
                                            hintText: "eg : After 8 pm",
                                            border: OutlineInputBorder(
                                                borderRadius:
                                                    BorderRadius.circular(10),
                                                borderSide: BorderSide(
                                                  color: Colors.black26,
                                                  width: 1,
                                                )),
                                            focusedBorder: OutlineInputBorder(
                                              borderRadius:
                                                  BorderRadius.circular(10),
                                              borderSide: BorderSide(
                                                width: 2,
                                                color: Colors.blue,
                                              ),
                                            )),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          SizedBox.square(
                            dimension: 22,
                          ),
                          Center(
                            child: Container(
                              width: 380,
                              height: 170,
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  SizedBox.square(dimension: 18),
                                  Container(
                                    margin: EdgeInsets.only(left: 24),
                                    child: Text("Add Photo *",
                                        style: TextStyle(
                                            fontWeight: FontWeight.w600,
                                            fontSize: 14)),
                                  ),
                                  Center(
                                    child: InkWell(
                                      onTap: () async {
                                        try {
                                          imageselecterclass obj =
                                              imageselecterclass();
                                          XFile? imageselected =
                                              await obj.selectimage();
                                          if (imageselected != null) {
                                            File file =
                                                File(imageselected.path);
                                            // File() this func converts xfile into file obj for flutter
                                            // .path() this gives path of the img in the phone storage
                                            var ref = FirebaseStorage.instance
                                                .ref()
                                                .child(
                                                    "selectedimages/${DateTime.now()}.jpg");
                                            // .child() creates a folder names images
                                            // eg images/2026-03-08 18:45:12.345.jpg
                                            await ref.putFile(file);
                                            // putfile() upload the file to firebasestorage
                                            String downloadUrl =
                                                await ref.getDownloadURL();
                                            setState(() {
                                              imageurlofIndividualItem =
                                                  downloadUrl;
                                            });
                                            // after uploading it into firebasestorage, firebase gives us a public download link
                                            // getdownloadurl() helps to retreice url
                                          }
                                        } catch (e) {
                                          ScaffoldMessenger.of(context)
                                              .showSnackBar(SnackBar(
                                                  content: Text(
                                                      "Error in selecting img : ${e}")));
                                        }
                                      },
                                      child: Container(
                                        decoration: BoxDecoration(
                                            color: Colors.grey.shade200,
                                            borderRadius:
                                                BorderRadius.circular(8)),
                                        height: 110,
                                        width: 110,
                                        child: imageurlofIndividualItem.isEmpty
                                            ? Column(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                children: [
                                                  Icon(
                                                    FontAwesomeIcons.image,
                                                    color: Colors.grey.shade600,
                                                    size: 18,
                                                  ),
                                                  SizedBox(height: 8),
                                                  Text(
                                                    "Add photo",
                                                    style: TextStyle(
                                                      color:
                                                          Colors.grey.shade700,
                                                      fontSize: 12,
                                                    ),
                                                  ),
                                                ],
                                              )
                                            : Image.network(
                                                fit: BoxFit.fill,
                                                imageurlofIndividualItem),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          SizedBox.square(
                            dimension: 22,
                          ),
                          Center(
                            child: Container(
                              width: 380,
                              height: 450,
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  SizedBox.square(dimension: 18),
                                  Container(
                                      margin: EdgeInsets.only(left: 24),
                                      child: Text("Item Title *",
                                          style: TextStyle(
                                            fontWeight: FontWeight.w600,
                                          ))),
                                  SizedBox.square(dimension: 15),
                                  Center(
                                    child: Container(
                                      width: 330,
                                      height: 50,
                                      child: TextField(
                                        maxLines: 1,
                                        controller:
                                            itemTitleControllerofINDIVIDUAL,
                                        keyboardType: TextInputType.text,
                                        decoration: InputDecoration(
                                          hintText: "What are you selling?",
                                          border: OutlineInputBorder(
                                              borderRadius:
                                                  BorderRadius.circular(10),
                                              borderSide: BorderSide(
                                                color: Colors.grey,
                                                width: 1,
                                              )),
                                          focusedBorder: OutlineInputBorder(
                                            borderRadius:
                                                BorderRadius.circular(10),
                                            borderSide: BorderSide(
                                              width: 2,
                                              color: Colors.blue,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                  SizedBox.square(
                                    dimension: 22,
                                  ),
                                  Container(
                                      margin: EdgeInsets.only(left: 24),
                                      child: Text("Description *",
                                          style: TextStyle(
                                            fontWeight: FontWeight.w600,
                                          ))),
                                  SizedBox.square(dimension: 15),
                                  Center(
                                    child: Container(
                                      width: 330,
                                      height: 50,
                                      child: TextField(
                                        controller:
                                            decriptioncontrollerofINDIVIDUAL,
                                        keyboardType: TextInputType.text,
                                        decoration: InputDecoration(
                                          hintText:
                                              "Describe your item, condition, reason for selling...",
                                          border: OutlineInputBorder(
                                              borderRadius:
                                                  BorderRadius.circular(10),
                                              borderSide: BorderSide(
                                                color: Colors.grey,
                                                width: 1,
                                              )),
                                          focusedBorder: OutlineInputBorder(
                                            borderRadius:
                                                BorderRadius.circular(10),
                                            borderSide: BorderSide(
                                              width: 2,
                                              color: Colors.blue,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                  SizedBox.square(
                                    dimension: 22,
                                  ),
                                  Center(
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Container(
                                          margin: EdgeInsets.only(left: 0),
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text("Category *",
                                                  style: TextStyle(
                                                    fontWeight: FontWeight.w600,
                                                  )),
                                              Container(
                                                width: 167,
                                                child: DropdownButton<String>(
                                                    value: dropdownvalue,
                                                    icon: const Icon(
                                                        Icons.arrow_drop_down),
                                                    items: items
                                                        .map((String items) {
                                                      return DropdownMenuItem<
                                                          String>(
                                                        child: Text(
                                                          items,
                                                          style: TextStyle(
                                                              fontSize: 14),
                                                        ),
                                                        value: items,
                                                      );
                                                    }).toList(),
                                                    onChanged:
                                                        (String? newValue) {
                                                      setState(() {
                                                        dropdownvalue =
                                                            newValue!;
                                                      });
                                                    }),
                                              ),
                                            ],
                                          ),
                                        ),
                                        SizedBox.square(
                                          dimension: 22,
                                        ),
                                        Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text("Condition *",
                                                style: TextStyle(
                                                  fontWeight: FontWeight.w600,
                                                )),
                                            DropdownButton(
                                                value: condnvalue,
                                                icon: const Icon(
                                                    Icons.arrow_drop_down),
                                                items:
                                                    condn.map((String condn) {
                                                  return DropdownMenuItem(
                                                    child: Text(
                                                      condn,
                                                      style: TextStyle(
                                                          fontSize: 14),
                                                    ),
                                                    value: condn,
                                                  );
                                                }).toList(),
                                                onChanged: (String? newvalue) {
                                                  setState(() {
                                                    condnvalue = newvalue!;
                                                  });
                                                }),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                  SizedBox.square(
                                    dimension: 22,
                                  ),
                                  Container(
                                      margin: EdgeInsets.only(left: 24),
                                      child: Text("Price *",
                                          style: TextStyle(
                                            fontWeight: FontWeight.w600,
                                          ))),
                                  SizedBox.square(dimension: 15),
                                  Center(
                                    child: Container(
                                      width: 330,
                                      height: 50,
                                      child: TextField(
                                        controller: pricecontrollerofINDIVIDUAL,
                                        keyboardType: TextInputType.number,
                                        decoration: InputDecoration(
                                          hintText: "Enter price",
                                          border: OutlineInputBorder(
                                              borderRadius:
                                                  BorderRadius.circular(10),
                                              borderSide: BorderSide(
                                                color: Colors.grey,
                                                width: 1,
                                              )),
                                          focusedBorder: OutlineInputBorder(
                                            borderRadius:
                                                BorderRadius.circular(10),
                                            borderSide: BorderSide(
                                              width: 2,
                                              color: Colors.blue,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          SizedBox.square(
                            dimension: 20,
                          ),
                          Center(
                            child: Container(
                              margin: EdgeInsets.only(bottom: 40),
                              width: 330,
                              height: 50,
                              child: ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                    backgroundColor: Colors.blue,
                                    elevation: 6,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(10),
                                    )),
                                onPressed: () async {
                                  String title = itemTitleControllerofINDIVIDUAL
                                      .text
                                      .toString();
                                  String price = pricecontrollerofINDIVIDUAL
                                      .text
                                      .toString();
                                  String condition = condnvalue;
                                  String cat = dropdownvalue;
                                  String desc =
                                      decriptioncontrollerofINDIVIDUAL.text;
                                  String timing =
                                      timingcontrollerINDIVIDUAL.text;

                                  // Validate all fields
                                  if (isSelected == false ||
                                      title.isEmpty ||
                                      price.isEmpty ||
                                      desc.isEmpty ||
                                      condition == "Select condition" ||
                                      cat == "Select category" ||
                                      timing.isEmpty) {
                                    ScaffoldMessenger.of(context).showSnackBar(
                                        SnackBar(
                                            content: Text(
                                                "Please fill the required fields")));
                                    return;
                                  }
                                  // String? url = await pickimage();

                                  // Check if image is uploaded
                                  // if(url== null) {
                                  //   ScaffoldMessenger.of(context).showSnackBar(
                                  //       SnackBar(content: Text("Please upload an image first"))
                                  //   );
                                  //   return; // ✅ This will exit the function
                                  // }
                                  try {
                                    String curruid =
                                        FirebaseAuth.instance.currentUser!.uid;

                                    // ✅ GET USER DATA PROPERLY
                                    DocumentSnapshot snapshot =
                                        await FirebaseFirestore.instance
                                            .collection("userprofiledata")
                                            .doc(curruid)
                                            .get();

                                    if (!snapshot.exists) {
                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(
                                        SnackBar(
                                            content: Text("Profile not found")),
                                      );
                                      return;
                                    }

                                    var data =
                                        snapshot.data() as Map<String, dynamic>;
                                    notificationserviceclass obj =
                                        notificationserviceclass();
                                    String? devicetokenofseller =
                                        await obj.getfcmToken();

                                    await FirebaseFirestore.instance
                                        .collection("Allsellingitems")
                                        .add({
                                      "title": title,
                                      "desc": desc,
                                      "isbusiness": false,
                                      "keptforselltiming":
                                          FieldValue.serverTimestamp(),
                                      "name": data["name"],
                                      "roomno": data["roomno"],
                                      "price": price,
                                      "soldatTime": "",
                                      "timing": timing,
                                      "category": cat.toString(),
                                      "condition": condition.toString(),
                                      "imageurl":
                                          imageurlofIndividualItem.isEmpty
                                              ? null
                                              : imageurlofIndividualItem,
                                      "status": "notsold",
                                      "uid": curruid,
                                      "buyeruid": "",
                                      "buyername": "",
                                      "devicetokenofseller":
                                          devicetokenofseller,
                                      "devicetokenofbuyer": "",
                                    });
                                    itemTitleControllerofINDIVIDUAL.clear();
                                    decriptioncontrollerofINDIVIDUAL.clear();
                                    pricecontrollerofINDIVIDUAL.clear();
                                    timingcontrollerINDIVIDUAL.clear();

                                    // Reset dropdowns
                                    setState(() {
                                      condnvalue = "Select condition";
                                      dropdownvalue = "Select category";
                                    });
                                    Navigator.pop(context);
                                    ScaffoldMessenger.of(context).showSnackBar(
                                        SnackBar(
                                            content: Text(
                                                "Kept for sell successfully !")));
                                  }
                                  // Clear fields

                                  // url = null; // Reset image URL

                                  catch (e) {
                                    Navigator.pop(context); // Close loading
                                    ScaffoldMessenger.of(context).showSnackBar(
                                        SnackBar(content: Text("Error: ${e}")));
                                  }
                                },
                                child: Text("List item for sale",
                                    style: TextStyle(
                                        color: Colors.white, fontSize: 18)),
                              ),
                            ),
                          ),
                          SizedBox.square(
                            dimension: 20,
                          ),
                        ],
                      )
                    : Column(
                        children: [
                          Center(
                            child: Container(
                              width: 380,
                              padding: EdgeInsets.all(16),
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Container(
                                    child: Text("Add Logo (Optional)",
                                        style: TextStyle(
                                            fontWeight: FontWeight.w600,
                                            fontSize: 14)),
                                  ),
                                  SizedBox.square(dimension: 8),
                                  Center(
                                    child: InkWell(
                                      onTap: () async {
                                        imageselecterclass obj =
                                            imageselecterclass();
                                        XFile? imageselected =
                                            await obj.selectimage();
                                        if (imageselected != null) {
                                          File file = File(imageselected.path);
                                          // File() this func converts xfile into file obj for flutter
                                          // .path() this gives path of the img in the phone storage
                                          var ref = FirebaseStorage.instance
                                              .ref()
                                              .child(
                                                  "selectedimages/${DateTime.now()}.jpg");
                                          // .child() creates a folder names images
                                          // eg images/2026-03-08 18:45:12.345.jpg
                                          await ref.putFile(file);
                                          // putfile() upload the file to firebasestorage
                                          String downloadUrl =
                                              await ref.getDownloadURL();
                                          setState(() {
                                            logourlofBusiness = downloadUrl;
                                          });
                                          // after uploading it into firebasestorage, firebase gives us a public download link
                                          // getdownloadurl() helps to retreice url
                                        }
                                      },
                                      child: CircleAvatar(
                                        backgroundColor: Colors.grey.shade200,
                                        radius: 55,
                                        child: logourlofBusiness.isEmpty
                                            ? Column(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                children: [
                                                  Icon(
                                                    FontAwesomeIcons.image,
                                                    color: Colors.grey.shade600,
                                                    size: 18,
                                                  ),
                                                  SizedBox(
                                                    height: 8,
                                                  ),
                                                  Text(
                                                    "Add logo",
                                                    style: TextStyle(
                                                      color:
                                                          Colors.grey.shade700,
                                                      fontSize: 12,
                                                    ),
                                                  ),
                                                ],
                                              )
                                            : Text(""),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),

                          SizedBox.square(
                            dimension: 22,
                          ),
                          Center(
                            child: Container(
                              width: 380,
                              padding: EdgeInsets.all(16),
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text("Business title",
                                      style: TextStyle(
                                        fontWeight: FontWeight.w600,
                                      )),
                                  SizedBox(height: 15),
                                  Container(
                                    width: 330,
                                    height: 50,
                                    child: TextField(
                                      controller: titlecontrollerofBUSINESS,
                                      decoration: InputDecoration(
                                        hintText: "eg : Crochet earrings stock",
                                        border: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(10),
                                        ),
                                        focusedBorder: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(10),
                                          borderSide: BorderSide(
                                            width: 2,
                                            color: Colors.blue,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),

                          SizedBox(height: 22),
                          Center(
                            child: Container(
                              width: 380,
                              padding: EdgeInsets.all(16),
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text("When can customer visit your room?",
                                      style: TextStyle(
                                          fontWeight: FontWeight.w600,
                                          fontSize: 14)),
                                  SizedBox(height: 15),
                                  Container(
                                    width: 330,
                                    height: 50,
                                    child: TextField(
                                      controller: timingcontrollerofBUSINESS,
                                      decoration: InputDecoration(
                                        hintText: "eg : After 8 pm",
                                        border: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(10),
                                        ),
                                        focusedBorder: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(10),
                                          borderSide: BorderSide(
                                            width: 2,
                                            color: Colors.blue,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),

                          SizedBox(height: 22),

                          Container(
                            width: 380,
                            height: 55,
                            child: ElevatedButton.icon(
                              onPressed: () {
                                setState(() {
                                  businessitems.add(businessitems.length + 1);
                                  businesscollection.add(BusinessClass(
                                    priceController: TextEditingController(),
                                    quantityController: TextEditingController(),
                                    titleController: TextEditingController(),
                                    descController: TextEditingController(),
                                  ));
                                });
                              },
                              icon: Icon(
                                Icons.add_circle_outline,
                                color: Colors.blue,
                              ),
                              label: Text(
                                "Add More Items",
                                style: TextStyle(
                                  color: Colors.blue,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.blue
                                    .withOpacity(0.07), // light blue background

                                elevation: 0,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(14),
                                ),
                              ),
                            ),
                          ),
                          SizedBox(height: 22), // 2️⃣ ADD PHOTO BOX
                          ListView.builder(
                              shrinkWrap: true,
                              padding: EdgeInsets.zero,
                              physics: NeverScrollableScrollPhysics(),
                              itemCount: businessitems.length,
                              itemBuilder: (context, index) {
                                return Column(
                                  children: [
                                    Center(
                                      child: Container(
                                        width: 380,
                                        padding: EdgeInsets.all(16),
                                        decoration: BoxDecoration(
                                          color: Colors.white,
                                          borderRadius:
                                              BorderRadius.circular(10),
                                        ),
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Row(
                                              children: [
                                                Text("Item ${index + 1}"),
                                                SizedBox(
                                                  width: 260,
                                                ),
                                                businessitems.length == 1
                                                    ? Text("")
                                                    : InkWell(
                                                        onTap: () {
                                                          setState(() {
                                                            businessitems
                                                                .removeAt(
                                                                    index);
                                                          });
                                                        },
                                                        child: Container(
                                                            height: 20,
                                                            child: Image.asset(
                                                                "assets/images/cross.png")),
                                                      ),
                                              ],
                                            ),
                                            Text("Add Photo *",
                                                style: TextStyle(
                                                  fontWeight: FontWeight.w600,
                                                )),
                                            SizedBox(height: 15),
                                            Container(
                                              width: 330,
                                              height: 50,
                                              child: ElevatedButton(
                                                onPressed: () async {},
                                                style: ElevatedButton.styleFrom(
                                                  side: BorderSide(
                                                      color:
                                                          Colors.grey.shade300),
                                                  backgroundColor: Colors.white,
                                                  shape: RoundedRectangleBorder(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            12),
                                                  ),
                                                ),
                                                child: Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.center,
                                                  children: [
                                                    Icon(
                                                        FontAwesomeIcons.camera,
                                                        color: Colors
                                                            .grey.shade600,
                                                        size: 18),
                                                    SizedBox(width: 10),
                                                    Text("Add photo",
                                                        style: TextStyle(
                                                          color: Colors
                                                              .grey.shade700,
                                                        )),
                                                  ],
                                                ),
                                              ),
                                            ),
                                            SizedBox(
                                              height: 22,
                                            ),
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                /// PRICE
                                                Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    Text("Price (₹)",
                                                        style: TextStyle(
                                                          fontWeight:
                                                              FontWeight.w600,
                                                        )),
                                                    SizedBox(height: 5),
                                                    Container(
                                                      width: 158,
                                                      height: 50,
                                                      child: TextField(
                                                        controller:
                                                            businesscollection[
                                                                    index]
                                                                .priceController,
                                                        keyboardType:
                                                            TextInputType
                                                                .number,
                                                        decoration:
                                                            InputDecoration(
                                                          hintText:
                                                              "Enter price",
                                                          border:
                                                              OutlineInputBorder(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        10),
                                                          ),
                                                          focusedBorder:
                                                              OutlineInputBorder(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        10),
                                                            borderSide:
                                                                BorderSide(
                                                              width: 2,
                                                              color:
                                                                  Colors.blue,
                                                            ),
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                  ],
                                                ),

                                                /// QUANTITY
                                                Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    Text("Quantity",
                                                        style: TextStyle(
                                                          fontWeight:
                                                              FontWeight.w600,
                                                        )),
                                                    SizedBox(height: 5),
                                                    Container(
                                                      width: 160,
                                                      height: 50,
                                                      child: TextField(
                                                        controller:
                                                            businesscollection[
                                                                    index]
                                                                .quantityController,
                                                        keyboardType:
                                                            TextInputType
                                                                .number,
                                                        decoration:
                                                            InputDecoration(
                                                          hintText:
                                                              "Enter quantity",
                                                          border:
                                                              OutlineInputBorder(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        10),
                                                          ),
                                                          focusedBorder:
                                                              OutlineInputBorder(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        10),
                                                            borderSide:
                                                                BorderSide(
                                                              width: 2,
                                                              color:
                                                                  Colors.blue,
                                                            ),
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ],
                                            ),
                                            SizedBox(
                                              height: 22,
                                            ),
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                /// PRICE
                                                Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    Text("Title",
                                                        style: TextStyle(
                                                          fontWeight:
                                                              FontWeight.w600,
                                                        )),
                                                    SizedBox(height: 5),
                                                    Container(
                                                      width: 158,
                                                      height: 50,
                                                      child: TextField(
                                                        controller:
                                                            businesscollection[
                                                                    index]
                                                                .titleController,
                                                        keyboardType:
                                                            TextInputType.text,
                                                        decoration:
                                                            InputDecoration(
                                                          hintText:
                                                              "Enter title",
                                                          border:
                                                              OutlineInputBorder(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        10),
                                                          ),
                                                          focusedBorder:
                                                              OutlineInputBorder(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        10),
                                                            borderSide:
                                                                BorderSide(
                                                              width: 2,
                                                              color:
                                                                  Colors.blue,
                                                            ),
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                  ],
                                                ),

                                                /// QUANTITY
                                                Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    Text("Description",
                                                        style: TextStyle(
                                                          fontWeight:
                                                              FontWeight.w600,
                                                        )),
                                                    SizedBox(height: 5),
                                                    Container(
                                                      width: 160,
                                                      height: 50,
                                                      child: TextField(
                                                        controller:
                                                            businesscollection[
                                                                    index]
                                                                .descController,
                                                        keyboardType:
                                                            TextInputType.text,
                                                        decoration:
                                                            InputDecoration(
                                                          hintText:
                                                              "Enter description",
                                                          border:
                                                              OutlineInputBorder(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        10),
                                                          ),
                                                          focusedBorder:
                                                              OutlineInputBorder(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        10),
                                                            borderSide:
                                                                BorderSide(
                                                              width: 2,
                                                              color:
                                                                  Colors.blue,
                                                            ),
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ],
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                    if (index < businessitems.length - 1)
                                      SizedBox(
                                        height: 10,
                                      ),
                                  ],
                                );
                              }),

                          SizedBox(
                            height: 22,
                          ),

                          /// 4️⃣ DESCRIPTION BOX
                          Center(
                            child: Container(
                              width: 380,
                              padding: EdgeInsets.all(16),
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text("Collection Description",
                                      style: TextStyle(
                                        fontWeight: FontWeight.w600,
                                      )),
                                  SizedBox(height: 15),
                                  TextField(
                                    controller:
                                        collectiondescriptionControllerCfBUSINESS,
                                    maxLines: 3,
                                    decoration: InputDecoration(
                                      hintText: "Describe your collection...",
                                      border: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                      focusedBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(10),
                                        borderSide: BorderSide(
                                          width: 2,
                                          color: Colors.blue,
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 22,
                          ),
                          Center(
                            child: Container(
                              margin: EdgeInsets.only(bottom: 40),
                              width: 330,
                              height: 50,
                              child: ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                    backgroundColor: Colors.blue,
                                    elevation: 6,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(10),
                                    )),
                                onPressed: () async {
                                  String currentuseruid =
                                      FirebaseAuth.instance.currentUser!.uid;

                                  DocumentSnapshot userdoc1 =
                                      await FirebaseFirestore.instance
                                          .collection("userprofiledata")
                                          .doc(currentuseruid)
                                          .get();

                                  Map<String, dynamic> userdata =
                                      userdoc1.data() as Map<String, dynamic>;
                                  DocumentReference collectiondocument =
                                      await FirebaseFirestore.instance
                                          .collection("Allsellingitems")
                                          .add({
                                    "desc":
                                        collectiondescriptionControllerCfBUSINESS
                                            .text
                                            .trim(),
                                    "isbusiness": true,
                                    "name": userdata["name"],
                                    "timing":
                                        timingcontrollerofBUSINESS.text.trim(),
                                    "keptforselltiming":
                                        FieldValue.serverTimestamp(),
                                    "uid":
                                        FirebaseAuth.instance.currentUser!.uid,
                                    "roomno": userdata["roomno"],
                                    "collectiontitle": titlecontrollerofBUSINESS
                                        .text
                                        .toString(),
                                    "logo": logourlofBusiness.isEmpty
                                        ? null
                                        : logourlofBusiness,
                                  });

                                  try {
                                    for (int i = 0;
                                        i < businesscollection.length;
                                        i++) {
                                      String priceofoneitem =
                                          businesscollection[i]
                                              .priceController
                                              .text
                                              .trim();

                                      String quantityofoneitem =
                                          businesscollection[i]
                                              .quantityController
                                              .text
                                              .trim();
                                      String titleofoneitem =
                                          businesscollection[i]
                                              .titleController
                                              .text
                                              .trim();

                                      String descofoneitem =
                                          businesscollection[i]
                                              .descController
                                              .text
                                              .trim();
                                      File? imageFile =
                                          businesscollection[i].image;
                                      if (priceofoneitem.isEmpty ||
                                              quantityofoneitem.isEmpty
                                          //   ||
                                          //  imageFile == null
                                          ) {
                                        ScaffoldMessenger.of(context)
                                            .showSnackBar(
                                          SnackBar(
                                              content: Text(
                                                  "Fill all item details")),
                                        );
                                        return;
                                      }

                                      await collectiondocument
                                          .collection("items")
                                          .add({
                                        "price": priceofoneitem,
                                        "individualtitle": titleofoneitem,
                                        "individualdesc": descofoneitem,
                                        "uid": FirebaseAuth
                                            .instance.currentUser!.uid,
                                        "quantity": quantityofoneitem,
                                        "status": "notsold",
                                        "soldatTime": "",
                                      });
                                    }
                                    ScaffoldMessenger.of(context).showSnackBar(
                                        SnackBar(
                                            content: Text(
                                                "Business collection listed successfully !")));
                                    Navigator.pop(context);

                                    return; // ✅ This will exit the function
                                    // Validate all fields

                                    // String? url = await pickimage();

                                    // Check if image is uploaded
                                    // if(url== null) {
                                    //   ScaffoldMessenger.of(context).showSnackBar(
                                    //       SnackBar(content: Text("Please upload an image first"))
                                    //   );
                                    //   return; // ✅ This will exit the function
                                    // }
                                  } catch (e) {
                                    Navigator.pop(context); // Close loading
                                    ScaffoldMessenger.of(context).showSnackBar(
                                        SnackBar(content: Text("Error: ${e}")));
                                  }
                                },
                                child: Text("List items for business",
                                    style: TextStyle(
                                        color: Colors.white, fontSize: 18)),
                              ),
                            ),
                          ),

                          SizedBox.square(
                            dimension: 20,
                          ),
                        ],
                      ),
              ],
            ),
          ],
        ),
      ),
    );
  }
/*
  Future<void> additemstosell(
      sellingitemsclass item1, BuildContext context) async {
    try {
      FirebaseFirestore db = FirebaseFirestore.instance;
      User? user = FirebaseAuth.instance.currentUser;

      DocumentSnapshot userdoc1 =
          await db.collection("userprofiledata").doc(user?.uid).get();
      String name = "Unknown";
      String roomno = "N/A";
      if (userdoc1.exists && userdoc1.data() != null) {
        Map<String, dynamic> userdata = userdoc1.data() as Map<String, dynamic>;
        name = userdata["name"]?.toString() ?? "Unknown";
        roomno = userdata["roomno"]?.toString() ?? "N/A";
      }
      DocumentReference docRef = await db.collection("Allsellingitems").add({
        "title": item1.title,
        "price": item1.price,
        "desc": item1.desc,
        "imageurl": item1.imageurl,
        "category": item1.category,
        "timing": item1.timing,
        "name": name,
        "roomno": roomno,
        "condition": item1.condition,
        "uid": FirebaseAuth.instance.currentUser!.uid,
        "isbusiness": false,
        "keptforselltiming": FieldValue.serverTimestamp(),
        "status": "notsold",
        "soldatTime": "",
        "quantity": "1",
      });

      ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("Item added succcessfully for selling")));
      Navigator.pop(context);
    } catch (error) {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text("Error : ${error.toString()}")));
    }
  }*/
}
