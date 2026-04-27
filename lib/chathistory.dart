import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'chatpg.dart';

class chathistory extends StatefulWidget {
  @override
  State<chathistory> createState() => _chathistoryState();
}

class _chathistoryState extends State<chathistory> {
  final String currentUserId = FirebaseAuth.instance.currentUser!.uid;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Chat History",
           style: TextStyle(fontSize: 17, fontWeight: FontWeight.w500)),
        backgroundColor: Colors.grey.shade50,
        foregroundColor: Colors.black,
        elevation: 0,
      ),
      body: Container(
        color: Colors.grey.shade100,
        child: StreamBuilder<QuerySnapshot>(
          // We only query by 'users' arrayContains to avoid forcing you to create a new manual index!
          // We will sort them by timestamp in memory.
          stream: FirebaseFirestore.instance
              .collection('chats')
              .where('users', arrayContains: currentUserId)
              .snapshots(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(child: CircularProgressIndicator());
            }

            if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
              return Center(
                  child: Text(
                      "No chats yet.",
                      textAlign: TextAlign.center,
                      style: TextStyle(fontSize: 16, color: Colors.grey)));
            }

            // Client-side sorting by timestamp (descending) to prevent Firestore Index requirement
            var chatDocs = snapshot.data!.docs.toList();
            chatDocs.sort((a, b) {
              var aData = a.data() as Map<String, dynamic>;
              var bData = b.data() as Map<String, dynamic>;
              Timestamp? aTime = aData['timestamp'] as Timestamp?;
              Timestamp? bTime = bData['timestamp'] as Timestamp?;
              if (aTime == null && bTime == null) return 0;
              if (aTime == null) return 1;
              if (bTime == null) return -1;
              return bTime.compareTo(aTime);
            });

            return ListView.builder(
              padding: EdgeInsets.symmetric(vertical: 8),
              itemCount: chatDocs.length,
              itemBuilder: (context, index) {
                var chatData = chatDocs[index].data() as Map<String, dynamic>;
                List<dynamic> users = chatData['users'];

                // Get the ID of the person we are chatting with
                String otherUserId = users.firstWhere(
                    (id) => id != currentUserId,
                    orElse: () => currentUserId);
                String lastMessage = chatData['lastMessage'] ?? "";

                return FutureBuilder<DocumentSnapshot>(
                  // Fetch their details from userprofiledata
                  future: FirebaseFirestore.instance
                      .collection('userprofiledata')
                      .doc(otherUserId)
                      .get(),
                  builder: (context, userSnapshot) {
                    if (!userSnapshot.hasData) {
                      return ListTile(
                        leading: CircleAvatar(
                            backgroundColor: Colors.blueAccent.withOpacity(0.1),
                            child: Icon(Icons.person, color: Colors.grey)),
                        title: Text("Loading..."),
                        subtitle: Text(lastMessage,
                            maxLines: 1, overflow: TextOverflow.ellipsis),
                      );
                    }

                    var userData =
                        userSnapshot.data!.data() as Map<String, dynamic>?;
                    String otherUserName = userData?['name'] ?? "Unknown User";

                    return Card(
                      color: Colors.grey.shade100,
                      margin: EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                      elevation: 2,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12)),
                      child: ListTile(
                        contentPadding:
                            EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                        leading: CircleAvatar(
                          radius: 30,
                          backgroundColor: Colors.blueAccent.withOpacity(0.1),
                          child: Text(
                            otherUserName.isNotEmpty
                                ? otherUserName[0].toUpperCase()
                                : "?",
                            style: TextStyle(
                                color: Colors.blueAccent,
                                fontSize: 20,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                        title: Text(otherUserName,
                            style: TextStyle(
                                fontWeight: FontWeight.w600, fontSize: 16)),
                        subtitle: Padding(
                          padding: const EdgeInsets.only(top: 4.0),
                          child: Text(
                            lastMessage,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                                color: Colors.grey.shade600, fontSize: 14),
                          ),
                        ),
                        onTap: () {
                          // Navigate to the Chat Page
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => chatpg(
                                receiverId: otherUserId,
                                receiverName: otherUserName,
                              ),
                            ),
                          );
                        },
                      ),
                    );
                  },
                );
              },
            );
          },
        ),
      ),
    );
  }
}
