import 'package:cloud_firestore/cloud_firestore.dart';

class StudentRequests {
  String title;
  String desc;
  String need;
  String requestat;
  String name;
  String roomno;
  String uid;
    Timestamp? createdat;
  String docid;
  StudentRequests({
    required this.title,
    required this.desc,
    required this.need,
    required this.requestat,
    required this.name,
    required this.roomno,
    this.createdat,
    required this.docid,
    required this.uid,
  });

  // Factory constructor from Map (for Firestore)
  factory StudentRequests.fromMap(Map<String, dynamic> map) {
    return StudentRequests(
      title: map['title'] ?? 'No Title',
      desc: map['desc'] ?? 'No Description',
      need: map['need'] ?? 'General',
      requestat: map['requestat'] ?? 'Unknown',
      name: map['name'] ?? 'Anonymous',
      roomno: map['roomno'] ?? 'N/A',
      docid: map["docid"] ?? "Null", 
      uid: map["uid"],
    
    );
  }

  // Convert to Map (for Firestore)
  Map<String, dynamic> toMap() {
    return {
      'title': title,
      'desc': desc,
      'need': need,
      'requestat': requestat,
      'name': name,
      'roomno': roomno,
    };
  }
}
