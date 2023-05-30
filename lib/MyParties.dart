import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:guestapp380/PartyDetails.dart';

class MyParties extends StatefulWidget {
  @override
  State<MyParties> createState() => _MyPartiesState();
}

class _MyPartiesState extends State<MyParties> {
  List partiler = [];

  void initState() {
    super.initState();
    fetchUsersParties();
  }

  Future<void> fetchUsersParties() async {
    final User? user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      final String currentUserId = user.uid;
      final DocumentSnapshot userSnapshot = await FirebaseFirestore.instance.collection('Account').doc(currentUserId).get();
      final String currentUserUsername = userSnapshot['userName'];
      final QuerySnapshot partiesSnapshot = await FirebaseFirestore.instance.collection('Parties').where('PartyOwner', isEqualTo: currentUserUsername).get();
      setState(() {
        partiler = partiesSnapshot.docs.map((doc) => doc.data()).toList();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
          child: Column(
              children: [
                SizedBox(height: 40),
                Text("MY EVENTS",style: TextStyle(fontSize: 30)),
                Expanded(
                    child: ListView.builder(
                        itemExtent: 130,
                        itemCount: partiler.length,
                        itemBuilder: (context, index) {
                          return Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Container(
                              decoration: BoxDecoration(
                                color: Colors.lightGreen,
                                // Background color of the container
                                borderRadius: BorderRadius.circular(20.0),
                                // Rounded corners for the container
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.grey.withOpacity(0.6),
                                    // Shadow color
                                    blurRadius: 3.0,
                                    // Spread radius of the shadow
                                    offset: Offset(0, 3), // Offset of the shadow
                                  ),
                                ],
                              ),
                              child: ListTile(
                                tileColor: Colors.grey[200],
                                // Background color
                                contentPadding: EdgeInsets.symmetric(
                                    horizontal: 16.0),
                                leading: Container(
                                  child: Image.network(
                                    'https://as2.ftcdn.net/v2/jpg/01/20/87/67/1000_F_120876722_dJlNWgyMJxnhLzuA6e9cKRypSECZVQjy.jpg',
                                    fit: BoxFit.cover,),
                                ),
                                title: Text(partiler[index]["Name"]),
                                subtitle: Text(
                                  partiler[index]["Description"],
                                  overflow: TextOverflow.ellipsis,
                                ),
                                trailing: Text(partiler[index]["DateTime"]),
                                onTap: () =>
                                    Navigator.push(
                                        context, MaterialPageRoute(builder: (
                                        context) => PartyDetails(length: index,))),
                              ),
                            ),
                          );
                        }),
                )
            ]
          ),
        )
    );
  }
}