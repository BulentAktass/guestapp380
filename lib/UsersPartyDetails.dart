import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:guestapp380/PartyOwnerProfilePage.dart';
import 'package:guestapp380/firebaseActivition.dart';

class UsersPartyDetails extends StatefulWidget {
  final int length;

  const UsersPartyDetails({Key? key, required this.length}) : super(key: key);

  @override
  State<UsersPartyDetails> createState() => _UsersPartyDetailsState();
}

class _UsersPartyDetailsState extends State<UsersPartyDetails> {
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
  Future<String> getPartyName(index) async{
    return partiler[index]["Name"];
  }
  Future<String> getPartyDescription(index) async{
    return partiler[index]["Description"];
  }
  Future<String> getPartyDateNTime(index) async{
    return partiler[index]["DateTime"];
  }
  Future<String> getPartyLocation(index) async{
    return partiler[index]["Location"];
  }
  Future<String> getPartyOwner(index) async{
    return partiler[index]["PartyOwner"];
  }
  Future<List<dynamic>> fetchPartyParticipants(index) async{
    return partiler[index]["participants"];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              height: 220,
              decoration: BoxDecoration(
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.7),
                    blurRadius: 7.0,
                    offset: Offset(0, 8),
                  ),
                ],
                image: DecorationImage(
                  image: NetworkImage(
                    'https://as2.ftcdn.net/v2/jpg/01/20/87/67/1000_F_120876722_dJlNWgyMJxnhLzuA6e9cKRypSECZVQjy.jpg',
                  ),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            Container(
              width: double.infinity,
              decoration: BoxDecoration(
                color: Color.fromARGB(255,45,19,44),
              ),
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height:10),
                    Text(
                        'Party Name',
                        style: TextStyle(fontSize: 27,color: Color.fromARGB(255,238,69,64),fontWeight: FontWeight.w600)
                    ),
                    SizedBox(height: 8),
                    FutureBuilder<String>(
                      future: getPartyName(widget.length),
                      builder: (BuildContext context,
                          AsyncSnapshot<String> snapshot) {
                        if (snapshot.hasData) {
                          return Text(
                            snapshot.data.toString(),
                            style: TextStyle(fontSize: 16,color: Colors.white ,fontFamily: 'Montserrat',
                                fontWeight: FontWeight.bold),
                          );
                        } else if (snapshot.hasError) {
                          return Text("Error: ${snapshot.error}");
                        } else {
                          return CircularProgressIndicator();
                        }
                      },
                    ),
                    SizedBox(height: 24),
                    Text(
                        'Party Description',
                        style: TextStyle(fontSize: 27,color: Color.fromARGB(255,238,69,64),fontWeight: FontWeight.w600)
                    ),
                    SizedBox(height: 8),
                    FutureBuilder<String>(
                      future: getPartyDescription(widget.length),
                      builder: (BuildContext context,
                          AsyncSnapshot<String> snapshot) {
                        if (snapshot.hasData) {
                          return Text(
                            snapshot.data.toString(),
                            style: TextStyle(fontSize: 16,color: Colors.white ,fontFamily: 'Montserrat',
                                fontWeight: FontWeight.bold),
                          );
                        } else if (snapshot.hasError) {
                          return Text("Error: ${snapshot.error}");
                        } else {
                          return CircularProgressIndicator();
                        }
                      },
                    ),
                    SizedBox(height: 24),
                    Text(
                        'Party Date and Time',
                        style: TextStyle(fontSize: 27,color: Color.fromARGB(255,238,69,64),fontWeight: FontWeight.w600)
                    ),
                    SizedBox(height: 8),
                    FutureBuilder<String>(
                      future: getPartyDateNTime(widget.length),
                      builder: (BuildContext context,
                          AsyncSnapshot<String> snapshot) {
                        if (snapshot.hasData) {
                          return Text(
                            snapshot.data.toString(),
                            style: TextStyle(fontSize: 16,color: Colors.white ,fontFamily: 'Montserrat',
                                fontWeight: FontWeight.bold),
                          );
                        } else if (snapshot.hasError) {
                          return Text("Error: ${snapshot.error}");
                        } else {
                          return CircularProgressIndicator();
                        }
                      },
                    ),
                    SizedBox(height: 24),
                    Text(
                        'Party Location',
                        style: TextStyle(fontSize: 27,color: Color.fromARGB(255,238,69,64),fontWeight: FontWeight.w600)
                    ),
                    SizedBox(height: 8),
                    FutureBuilder<String>(
                      future: getPartyLocation(widget.length),
                      builder: (BuildContext context,
                          AsyncSnapshot<String> snapshot) {
                        if (snapshot.hasData) {
                          return Text(
                            snapshot.data.toString(),
                            style: TextStyle(fontSize: 16,color: Colors.white ,fontFamily: 'Montserrat',
                                fontWeight: FontWeight.bold),
                          );
                        } else if (snapshot.hasError) {
                          return Text("Error: ${snapshot.error}");
                        } else {
                          return CircularProgressIndicator();
                        }
                      },
                    ),
                    SizedBox(height: 24),
                    Text(
                        'Party Owner',
                        style: TextStyle(fontSize: 27,color: Color.fromARGB(255,238,69,64),fontWeight: FontWeight.w600)
                    ),
                    SizedBox(height: 8),
                    FutureBuilder<String>(
                      future: getPartyOwner(widget.length),
                      builder: (BuildContext context, AsyncSnapshot<String> snapshot) {
                        if (snapshot.hasData) {
                          return IntrinsicWidth(
                            child: Container(
                              decoration: BoxDecoration(
                                color: Color.fromARGB(255,238,69,64),
                                borderRadius: BorderRadius.circular(20.0),
                              ),
                              child: ListTile(
                                leading: Icon(Icons.person,size: 25,),
                                title: Text(
                                  snapshot.data.toString().toUpperCase(),
                                  style: TextStyle(fontSize: 16, color: Colors.white),
                                ),
                                onTap: () => Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => FutureBuilder<String>(
                                      future: firebaseActivition().getPartyOwnerUID(widget.length),
                                      builder: (BuildContext context, AsyncSnapshot<String> snapshot) {
                                        if (snapshot.hasData) {
                                          return PartyOwnerProfilePage(index: snapshot.data.toString());
                                        } else if (snapshot.hasError) {
                                          return Text("Error: ${snapshot.error}");
                                        } else {
                                          return CircularProgressIndicator();
                                        }
                                      },
                                    ),
                                  ),
                                ),

                              ),
                            ),
                          );
                        } else if (snapshot.hasError) {
                          return Text("Error: ${snapshot.error}");
                        } else {
                          return CircularProgressIndicator();
                        }
                      },
                    ),

                    SizedBox(height: 24),
                    Row(
                      children: [
                        Text(
                            'Participants List',
                            style: TextStyle(fontSize: 27,color: Color.fromARGB(255,238,69,64),fontWeight: FontWeight.w600)
                        ),
                        SizedBox(width: 40,),
                        FutureBuilder<List<dynamic>>(
                          future: fetchPartyParticipants(widget.length),
                          builder: (BuildContext context, AsyncSnapshot<List<dynamic>> snapshot) {
                            if (snapshot.connectionState == ConnectionState.waiting) {
                              return CircularProgressIndicator();
                            } else if (snapshot.hasError) {
                              return Text("Error: ${snapshot.error}");
                            } else if (snapshot.hasData) {
                              List<dynamic> participants = snapshot.data!;
                              return DropdownButton<dynamic>(
                                dropdownColor: Color.fromARGB(255,238,69,64),
                                icon: Icon(
                                  Icons.account_box_rounded,
                                  color: Colors.white,
                                ),
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 15,
                                  fontWeight: FontWeight.bold,
                                ),
                                underline: Container(
                                  height: 2,
                                  color: Colors.white,
                                ),
                                elevation: 8,
                                items: participants.map((participant) {
                                  return DropdownMenuItem<dynamic>(
                                    value: participant,
                                    child: Text(participant.toString()),
                                  );
                                }).toList(),
                                onChanged: (dynamic? selectedParticipant) {
                                  // Handle the selected participant
                                  print('Selected Participant: $selectedParticipant');
                                },
                              );
                            } else {
                              return Text("No participants found.");
                            }
                          },
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
