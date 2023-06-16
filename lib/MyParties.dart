import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:guestapp380/UsersPartyDetails.dart';

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
          decoration: BoxDecoration(
            color: Color.fromARGB(255,45,19,44),
          ),
          child: Column(
              children: [
                SizedBox(height: 40),
                Align(
                  alignment: Alignment.topRight,
                    child: Text("MY EVENTS  ",style: TextStyle(fontSize: 30,color: Color.fromARGB(255,238,69,64),fontWeight: FontWeight.w400))),
                SizedBox(height: 10,),
                Expanded(
                    child: ListView.builder(
                        itemCount: partiler.length,
                        itemBuilder: (context, index) {
                          return Padding(
                            padding: const EdgeInsets.only(right: 10,left: 10,bottom: 20),
                            child: Container(
                              decoration: BoxDecoration(
                                color: Color.fromARGB(255,238,69,64),
                                borderRadius: BorderRadius.circular(20.0),
                              ),
                              child: ListTile(
                                tileColor: Colors.grey[200],
                                contentPadding: EdgeInsets.symmetric(
                                    horizontal: 16.0),
                                leading: ClipRRect(
                                  borderRadius: BorderRadius.circular(10.0),
                                  child: Container(
                                    decoration: BoxDecoration(
                                        border: Border.all(
                                          color: Colors.black,
                                          width: 1.5,)
                                    ),
                                    child: Image.network(
                                      'https://as2.ftcdn.net/v2/jpg/01/20/87/67/1000_F_120876722_dJlNWgyMJxnhLzuA6e9cKRypSECZVQjy.jpg',
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                ),
                                title: Text(partiler[index]["Name"],style: TextStyle(fontSize: 18),),
                                subtitle: Text(
                                  partiler[index]["Description"],style: TextStyle(fontSize: 20, fontFamily: 'Montserrat',
                          fontWeight: FontWeight.bold,),
                                  overflow: TextOverflow.ellipsis,
                                ),
                                trailing: Text(partiler[index]["DateTime"]),
                                onTap: () => Navigator.push(context, MaterialPageRoute(builder: (context) => UsersPartyDetails(length: index,))),
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