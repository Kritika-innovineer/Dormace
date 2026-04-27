import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:hostel_app/businesscollection.dart';
import 'package:hostel_app/businessdashboard.dart';
import 'loginpgofstudent.dart';

import 'productdetails.dart';
import 'sellingitemsclass.dart';

class marketplace extends StatefulWidget {
  @override
  State<marketplace> createState() => _marketplaceState();
}

class _marketplaceState extends State<marketplace> {
  List<sellingitemsclass> sellingitemslist = [];
  List<String> documentids = [];
  void initState() {
    super.initState();
    getitemdata();
  }

  String selectedcategory = "Select category";
  bool isBusinessSelected = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Marketplace",
            style: TextStyle(fontSize: 17, fontWeight: FontWeight.w500)),
        actions: [
          PopupMenuButton<String>(
            icon: Icon(Icons.more_vert, color: Colors.black),
            onSelected: (value) => {
              if (value == "view")
                {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => businessdashboard())),
                }
            },
            itemBuilder: (BuildContext context) => [
              PopupMenuItem(
                value: "view",
                child: Text(
                  "View my business",
                  style: TextStyle(color: Colors.black),
                ),
              )
            ],
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Container(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                margin: EdgeInsets.symmetric(horizontal: 14, vertical: 15),
                child: Row(
                  children: [
                    InkWell(
                      onTap: () {
                        setState(() {
                          isBusinessSelected = false;
                        });
                      },
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(20)),
                          color: !isBusinessSelected
                              ? Colors.blueAccent.shade700
                              : Colors.grey.shade300,
                        ),
                        padding: EdgeInsets.only(
                            top: 8, bottom: 8, left: 5, right: 5),
                        child: Center(
                          child: Text(
                            "Individual Items",
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.normal,
                              color: !isBusinessSelected
                                  ? Colors.white
                                  : Colors.black,
                            ),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    InkWell(
                      onTap: () {
                        setState(() {
                          isBusinessSelected = true;
                        });
                      },
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(20)),
                          color: isBusinessSelected
                              ? Colors.blueAccent.shade700
                              : Colors.grey.shade300,
                        ),
                        padding: EdgeInsets.only(
                            top: 8, bottom: 8, left: 5, right: 5),
                        child: Center(
                          child: Text(
                            "Business Items",
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.normal,
                              color: isBusinessSelected
                                  ? Colors.white
                                  : Colors.black,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              if (!isBusinessSelected)
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      margin: EdgeInsets.only(left: 8),
                      child: Text(
                        "Categories",
                        style: TextStyle(
                            fontSize: 14, fontWeight: FontWeight.bold),
                      ),
                    ),
                    Center(
                      child: Wrap(
                        children: [
                          InkWell(
                            onTap: () {
                              setState(() {
                                if (selectedcategory == "Earrings") {
                                  selectedcategory = "Select category";
                                } else {
                                  selectedcategory = "Earrings";
                                }
                              });
                              getitemdata();
                            },
                            child: Container(
                              margin: EdgeInsets.all(8),
                              height: 95,
                              width: 110,
                              decoration: BoxDecoration(
                                color: selectedcategory == "Earrings"
                                    ? Colors.lightBlueAccent.shade100
                                    : Colors.grey.shade200,
                                border: Border.all(
                                  color: selectedcategory == "Earrings"
                                      ? Colors.blue.shade300
                                      : Colors.grey.shade400,
                                  width: 3,
                                ),
                                borderRadius: BorderRadius.circular(22),
                              ),
                              child: Center(
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Container(
                                        padding: EdgeInsets.only(bottom: 10),
                                        height: 50,
                                        width: 50,
                                        child: Image.asset(
                                            "assets/images/earrings.png")),
                                    Text(
                                      "Earrings",
                                      style: TextStyle(
                                          fontWeight: FontWeight.w600,
                                          fontSize: 14),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                          InkWell(
                            onTap: () {
                              setState(() {
                                if (selectedcategory == "Books") {
                                  selectedcategory = "Select category";
                                } else {
                                  selectedcategory = "Books";
                                }
                              });
                              getitemdata();
                            },
                            child: Container(
                              margin: EdgeInsets.all(8),
                              height: 95,
                              width: 110,
                              decoration: BoxDecoration(
                                color: selectedcategory == "Books"
                                    ? Colors.lightBlueAccent.shade100
                                    : Colors.grey.shade200,
                                border: Border.all(
                                  color: selectedcategory == "Books"
                                      ? Colors.blue.shade300
                                      : Colors.grey.shade400,
                                  width: 3,
                                ),
                                borderRadius: BorderRadius.circular(22),
                              ),
                              child: Center(
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Container(
                                        padding: EdgeInsets.only(bottom: 10),
                                        height: 50,
                                        width: 50,
                                        child: Icon(FontAwesomeIcons.book,
                                            size: 22)),
                                    Text(
                                      "Books",
                                      style: TextStyle(
                                          fontWeight: FontWeight.w600,
                                          fontSize: 14),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                          InkWell(
                            onTap: () {
                              setState(() {
                                if (selectedcategory == "Clothing") {
                                  selectedcategory = "Select category";
                                } else {
                                  selectedcategory = "Clothing";
                                }
                              });
                              getitemdata();
                            },
                            child: Container(
                              margin: EdgeInsets.all(8),
                              height: 95,
                              width: 110,
                              decoration: BoxDecoration(
                                color: selectedcategory == "Clothing"
                                    ? Colors.lightBlueAccent.shade100
                                    : Colors.grey.shade200,
                                border: Border.all(
                                  color: selectedcategory == "Clothing"
                                      ? Colors.blue.shade300
                                      : Colors.grey.shade400,
                                  width: 3,
                                ),
                                borderRadius: BorderRadius.circular(22),
                              ),
                              child: Center(
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Container(
                                      padding: EdgeInsets.only(bottom: 10),
                                      height: 50,
                                      width: 50,
                                      child:
                                          Image.asset("assets/images/img.png"),
                                    ),
                                    
                                    Text(
                                      "Clothing",
                                      style: TextStyle(
                                          fontWeight: FontWeight.w600,
                                          fontSize: 14),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                          InkWell(
                            onTap: () {
                              setState(() {
                                if (selectedcategory == "Electronics") {
                                  selectedcategory = "Select category";
                                } else {
                                  selectedcategory = "Electronics";
                                }
                              });
                              getitemdata();
                            },
                            child: Container(
                              margin: EdgeInsets.all(8),
                              height: 95,
                              width: 110,
                              decoration: BoxDecoration(
                                color: selectedcategory == "Electronics"
                                    ? Colors.lightBlueAccent.shade100
                                    : Colors.grey.shade200,
                                border: Border.all(
                                  color: selectedcategory == "Electronics"
                                      ? Colors.blue.shade300
                                      : Colors.grey.shade400,
                                  width: 3,
                                ),
                                borderRadius: BorderRadius.circular(22),
                              ),
                              child: Center(
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Container(
                                      padding: EdgeInsets.only(bottom: 10),
                                      height: 50,
                                      width: 50,
                                      child: Image.asset(
                                          "assets/images/cooler.png"),
                                    ),
                                    Text(
                                      "Electronics",
                                      style: TextStyle(
                                          fontWeight: FontWeight.w600,
                                          fontSize: 14),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                          InkWell(
                            onTap: () {
                              setState(() {
                                if (selectedcategory == "Shoes") {
                                  selectedcategory = "Select category";
                                } else {
                                  selectedcategory = "Shoes";
                                }
                              });

                              getitemdata();
                            },
                            child: Container(
                              margin: EdgeInsets.all(8),
                              height: 95,
                              width: 110,
                              decoration: BoxDecoration(
                                color: selectedcategory == "Shoes"
                                    ? Colors.lightBlueAccent.shade100
                                    : Colors.grey.shade200,
                                border: Border.all(
                                  color: selectedcategory == "Shoes"
                                      ? Colors.blue.shade300
                                      : Colors.grey.shade400,
                                  width: 3,
                                ),
                                borderRadius: BorderRadius.circular(22),
                              ),
                              child: Center(
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Container(
                                      padding: EdgeInsets.only(bottom: 10),
                                      height: 50,
                                      width: 50,
                                      child: Image.asset(
                                          "assets/images/shoes.png"),
                                    ),
                                    Text(
                                      "Shoes",
                                      style: TextStyle(
                                          fontWeight: FontWeight.w600,
                                          fontSize: 14),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                          InkWell(
                            onTap: () {
                              setState(() {
                                if (selectedcategory == "Food") {
                                  selectedcategory = "Select category";
                                } else {
                                  selectedcategory = "Food";
                                }
                              });
                              getitemdata();
                            },
                            child: Container(
                              margin: EdgeInsets.all(8),
                              height: 95,
                              width: 110,
                              decoration: BoxDecoration(
                                color: selectedcategory == "Food"
                                    ? Colors.lightBlueAccent.shade100
                                    : Colors.grey.shade200,
                                border: Border.all(
                                  color: selectedcategory == "Food"
                                      ? Colors.blue.shade300
                                      : Colors.grey.shade400,
                                  width: 3,
                                ),
                                borderRadius: BorderRadius.circular(22),
                              ),
                              child: Center(
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Container(
                                      padding: EdgeInsets.only(bottom: 10),
                                      height: 50,
                                      width: 50,
                                      child: Icon(Icons.fastfood,
                                          size: 28, color: Colors.orange),
                                    ),
                                    Text(
                                      "Food",
                                      style: TextStyle(
                                          fontWeight: FontWeight.w600,
                                          fontSize: 14),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                          InkWell(
                            onTap: () {
                              setState(() {
                                if (selectedcategory == "Others") {
                                  selectedcategory = "Select category";
                                } else {
                                  selectedcategory = "Others";
                                }
                              });
                              getitemdata();
                            },
                            child: Container(
                              margin: EdgeInsets.all(8),
                              height: 95,
                              width: 110,
                              decoration: BoxDecoration(
                                color: selectedcategory == "Others"
                                    ? Colors.lightBlueAccent.shade100
                                    : Colors.grey.shade200,
                                border: Border.all(
                                  color: selectedcategory == "Others"
                                      ? Colors.blue.shade300
                                      : Colors.grey.shade400,
                                  width: 3,
                                ),
                                borderRadius: BorderRadius.circular(22),
                              ),
                              child: Center(
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Container(
                                      padding: EdgeInsets.only(bottom: 10),
                                      height: 50,
                                      width: 50,
                                      child:
                                          Image.asset("assets/images/lamp.png"),
                                    ),
                                    Text(
                                      "Others",
                                      style: TextStyle(
                                          fontWeight: FontWeight.w600,
                                          fontSize: 14),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox.square(dimension: 12),
                    Container(
                      margin: EdgeInsets.all(8),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            selectedcategory == "Select category"
                                ? "All Items"
                                : selectedcategory,
                            style: TextStyle(
                                fontSize: 14, fontWeight: FontWeight.bold),
                          ),
                          InkWell(
                            onTap: () {
                              setState(() {
                                selectedcategory = "Select category";
                              });
                              getitemdata();
                            },
                            child: selectedcategory != "Select category"
                                ? Text("View All",
                                    style: TextStyle(
                                        fontWeight: FontWeight.w600,
                                        color: Colors.blueAccent.shade700,
                                        fontSize: 14))
                                : SizedBox(),
                          ),
                        ],
                      ),
                    ),
                    SizedBox.square(dimension: 12),
                    StreamBuilder<QuerySnapshot>(
                        stream: selectedcategory == "Select category"
                            ? FirebaseFirestore.instance
                                .collection('Allsellingitems')
                                .where("isbusiness", isEqualTo: false)
                                .where("status",
                                    whereIn: ["notsold", "pending"])
                                .orderBy('keptforselltiming', descending: true)
                                .snapshots()
                            : FirebaseFirestore.instance
                                .collection('Allsellingitems')
                                .where('category', isEqualTo: selectedcategory)
                                .where("isbusiness", isEqualTo: false)
                                .where("status",
                                    whereIn: ["notsold", "pending"])
                                .orderBy('keptforselltiming', descending: true)
                                .snapshots(),
                        builder: (context, snapshot) {
                          if (snapshot.connectionState ==
                              ConnectionState.waiting) {
                            return Center(child: CircularProgressIndicator());
                          }
                          if (!snapshot.hasData ||
                              snapshot.data == null ||
                              snapshot.data!.docs.isEmpty) {
                            return Center(
                              child: Text("No item for sell"),
                            );
                          }

                          String? currentUserId =
                              FirebaseAuth.instance.currentUser?.uid;
                          var filteredDocs = snapshot.data!.docs.where((doc) {
                            var data = doc.data() as Map<String, dynamic>;
                            return data["uid"] != currentUserId;
                          }).toList();

                          if (filteredDocs.isEmpty) {
                            return Center(
                              child: Text("No item for sell"),
                            );
                          }

                          return ListView.builder(
                            shrinkWrap: true,
                            physics: NeverScrollableScrollPhysics(),
                            itemCount: filteredDocs.length,
                            itemBuilder: (context, index) {
                              final doc = filteredDocs[index];
                              final data = doc.data() as Map<String, dynamic>;

                              return Container(
                                height: 155,
                                padding: EdgeInsets.only(
                                    left: 13, right: 13, bottom: 5),
                                child: Card(
                                  color: Colors.grey.shade50,
                                  child: Stack(
                                    children: [
                                      Positioned(
                                          top: 17,
                                          left: 15,
                                          child: Container(
                                              decoration: BoxDecoration(
                                                  color: Colors.grey.shade200,
                                                  borderRadius:
                                                      BorderRadius.circular(8)),
                                              height: 110,
                                              width: 110,
                                              child: Icon(Icons.image,
                                                  size: 40,
                                                  color: Colors.grey))),
                                      Positioned(
                                        left: 150,
                                        top: 15,
                                        child: Text(
                                          data["title"] ?? "No title",
                                          style: TextStyle(
                                            fontWeight: FontWeight.w600,
                                          ),
                                        ),
                                      ),
                                      Positioned(
                                          left: 150,
                                          top: 35,
                                          child: Text("₹ ${data["price"]}",
                                              style: TextStyle(
                                                  fontSize: 18,
                                                  fontWeight: FontWeight.w700,
                                                  color: Colors
                                                      .blueAccent.shade700))),
                                      Positioned(
                                        left: 150,
                                        top: 60,
                                        child: Row(
                                          children: [
                                            Icon(
                                              Icons.person,
                                              size: 15,
                                            ),
                                            SizedBox(width: 5),
                                            Text(
                                              data["name"] ?? "No name",
                                              style: TextStyle(
                                                fontSize: 13,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      Positioned(
                                        top: 90,
                                        left: 140,
                                        child: Container(
                                          height: 33,
                                          width: 180,
                                          child: ElevatedButton(
                                              onPressed: () async {
                                                Navigator.push(
                                                    context,
                                                    MaterialPageRoute(
                                                        builder: (context) =>
                                                            productdetails(
                                                                documentid:
                                                                    doc.id)));
                                              },
                                              style: ElevatedButton.styleFrom(
                                                  backgroundColor: Colors
                                                      .blueAccent.shade700,
                                                  foregroundColor: Colors.white,
                                                  shape: RoundedRectangleBorder(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              10))),
                                              child: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                children: [
                                                  SizedBox(
                                                      width: 20,
                                                      child: Image.asset(
                                                          "assets/images/eyeimg.png")),
                                                  SizedBox(width: 10),
                                                  Text(
                                                    "View details",
                                                    style:
                                                        TextStyle(fontSize: 15),
                                                  ),
                                                ],
                                              )),
                                        ),
                                      ),
                                      Positioned(
                                        left: 15,
                                        top: 35,
                                        child: Text(
                                          data[""] ?? "",
                                          style: TextStyle(
                                            fontWeight: FontWeight.w600,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              );
                            },
                          );
                        }),
                  ],
                ),
              if (isBusinessSelected == true)
                Container(
                  padding: EdgeInsets.all(8),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "All Business Collection",
                        style: TextStyle(
                            fontSize: 14, fontWeight: FontWeight.bold),
                      ),
                      StreamBuilder<QuerySnapshot>(
                        stream: FirebaseFirestore.instance
                            .collection('Allsellingitems')
                            .where("isbusiness", isEqualTo: true)
                            .orderBy('keptforselltiming', descending: true)
                            .snapshots(),
                        builder: (context, snapshot) {
                          if (snapshot.connectionState ==
                              ConnectionState.waiting) {
                            return Center(child: CircularProgressIndicator());
                          }
                          if (!snapshot.hasData ||
                              snapshot.data == null ||
                              snapshot.data!.docs.isEmpty) {
                            return Center(
                              child: Text("No business collection yet"),
                            );
                          }

                          String? currentUserId =
                              FirebaseAuth.instance.currentUser?.uid;
                          var filteredDocs = snapshot.data!.docs.where((doc) {
                            var data = doc.data() as Map<String, dynamic>;
                            return data["uid"] != currentUserId;
                          }).toList();

                          if (filteredDocs.isEmpty) {
                            return Center(
                              child: Text("No business collection yet"),
                            );
                          }

                          return ListView.builder(
                              shrinkWrap: true,
                              physics: NeverScrollableScrollPhysics(),
                              itemCount: filteredDocs.length,
                              itemBuilder: (context, index) {
                                final doc = filteredDocs[index];
                                final data = doc.data() as Map<String, dynamic>;

                                //     if (data["uid"] !=
                                //FirebaseAuth.instance.currentUser!.uid) {
                                return Container(
                                  height: 155,
                                  child: Card(
                                    color: Colors.grey.shade100,
                                    child: Stack(
                                      children: [
                                        Positioned(
                                          left: 150,
                                          top: 15,
                                          child: Text(
                                            data["collectiontitle"] ??
                                                "No collection title",
                                            style: TextStyle(
                                                fontSize: 14,
                                                fontWeight: FontWeight.bold),
                                          ),
                                        ),
                                        Positioned(
                                            top: 30,
                                            left: 15,
                                            child: CircleAvatar(
                                              radius: 45,
                                              backgroundColor: Colors.blueAccent
                                                  .withOpacity(0.1),
                                              child: Text(
                                                  data["logo"] == null
                                                      ? data["name"][0]
                                                      : "",
                                                  style: TextStyle(
                                                      fontSize: 35,
                                                      fontWeight:
                                                          FontWeight.normal,
                                                      color:
                                                          Colors.blueAccent)),
                                            )),
                                        Positioned(
                                          left: 150,
                                          top: 60,
                                          child: Row(
                                            children: [
                                              Icon(Icons.person,
                                                  size: 15,
                                                  color: Colors.black54),
                                              SizedBox(width: 5),
                                              Text(
                                                data["name"] ?? "No name",
                                                style: TextStyle(
                                                    fontSize: 13,
                                                    color: Colors.black54),
                                              ),
                                            ],
                                          ),
                                        ),
                                        Positioned(
                                          top: 90,
                                          left: 140,
                                          child: Container(
                                            height: 33,
                                            width: 180,
                                            child: ElevatedButton(
                                                onPressed: () async {
                                                  Navigator.push(
                                                      context,
                                                      MaterialPageRoute(
                                                          builder: (context) =>
                                                              businesscollecitonpg(
                                                                collectionid:
                                                                    doc.id,
                                                                businesstitle: data[
                                                                    "collectiontitle"],
                                                              )));
                                                },
                                                style: ElevatedButton.styleFrom(
                                                    backgroundColor: Colors
                                                        .blueAccent.shade700,
                                                    foregroundColor:
                                                        Colors.white,
                                                    shape:
                                                        RoundedRectangleBorder(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        10))),
                                                child: Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.center,
                                                  children: [
                                                    SizedBox(
                                                        width: 18,
                                                        child: Image.asset(
                                                            "assets/images/store.png")),
                                                    SizedBox(width: 10),
                                                    Text(
                                                      "View Store",
                                                      style: TextStyle(
                                                          fontSize: 14),
                                                    ),
                                                  ],
                                                )),
                                          ),
                                        ),
                                        Positioned(
                                          left: 15,
                                          top: 35,
                                          child: Text(
                                            data[""] ?? "",
                                            style: TextStyle(
                                              fontWeight: FontWeight.w600,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                );
                              });
                        },
                      ),
                    ],
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> getitemdata() async {
    sellingitemslist.clear();
    documentids.clear();
    print("Starting to fetch items...");

    try {
      Query query = FirebaseFirestore.instance.collection("Allsellingitems");

      // Filter only if a category is selected
      if (selectedcategory != "Select category") {
        query = query.where("category", isEqualTo: selectedcategory);
        print("Applying filter: $selectedcategory");
      } else {
        print("No filter applied, fetching all items");
      }

      QuerySnapshot snapshot = await query.get();
      print("Query completed. Total items fetched: ${snapshot.docs.length}");

      if (snapshot.docs.isEmpty) {
        print("No items found in Firestore for this query.");
      } else {
        for (DocumentSnapshot doc in snapshot.docs) {
          String docid = doc.id;
          documentids.add(docid);
          var itemdata = doc.data() as Map<String, dynamic>;
          String title = itemdata["title"] ?? "No title";
          String price = itemdata["price"] ?? "0";
          String desc = itemdata["desc"] ?? "";
          String category = itemdata["category"] ?? "Others";
          String timing = itemdata["timing"] ?? "Not available";
          String condition = itemdata["condition"] ?? "No condn";
          String sellername = itemdata["sellername"] ?? "No name";
          String sellerroomno = itemdata["sellerroomno"] ?? "No roomno";

          sellingitemslist.add(
            sellingitemsclass(
              title: title,
              price: price,
              desc: desc,
              category: category,
              timing: timing,
              condition: condition,
              name: sellername,
              roomno: sellerroomno,
            ),
          );
          print("Added item: $title, $price, $category");
        }
      }

      setState(() {});
      print(
          "Data fetched successfully!!! Total items in list: ${sellingitemslist.length}");
    } catch (e) {
      print("Error fetching data: $e");
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Error fetching data: $e")),
      );
    }
  }
}
