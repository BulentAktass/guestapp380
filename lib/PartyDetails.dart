import 'package:flutter/material.dart';
import 'package:guestapp380/PartyOwnerProfilePage.dart';
import 'package:guestapp380/firebaseActivition.dart';

class PartyDetails extends StatelessWidget {
  final int length;

  const PartyDetails({Key? key, required this.length}) : super(key: key);

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
                    color: Colors.grey.withOpacity(0.7), // Shadow color
                    blurRadius: 7.0, // Spread radius of the shadow
                    offset: Offset(0, 8), // Offset of the shadow
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
                            future: firebaseActivition().getPartyName(length),
                            builder: (BuildContext context,
                                AsyncSnapshot<String> snapshot) {
                              if (snapshot.hasData) {
                                return Text(
                                  snapshot.data.toString(),
                                  style: TextStyle(fontSize: 16,color: Colors.white),
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
                            future: firebaseActivition().getPartyDescription(length),
                            builder: (BuildContext context,
                                AsyncSnapshot<String> snapshot) {
                              if (snapshot.hasData) {
                                return Text(
                                  snapshot.data.toString(),
                                  style: TextStyle(fontSize: 16,color: Colors.white),
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
                            future: firebaseActivition().getPartyDateTime(length),
                            builder: (BuildContext context,
                                AsyncSnapshot<String> snapshot) {
                              if (snapshot.hasData) {
                                return Text(
                                  snapshot.data.toString(),
                                  style: TextStyle(fontSize: 16,color: Colors.white),
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
                            future: firebaseActivition().getPartyLocation(length),
                            builder: (BuildContext context,
                                AsyncSnapshot<String> snapshot) {
                              if (snapshot.hasData) {
                                return Text(
                                  snapshot.data.toString(),
                                  style: TextStyle(fontSize: 16,color: Colors.white),
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
                          SizedBox(height: 15),
                          FutureBuilder<String>(
                            future: firebaseActivition().getPartyOwner(length),
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
                                        style: TextStyle(fontSize: 15, color: Colors.white),
                                      ),
                                      onTap: () => Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) => FutureBuilder<String>(
                                            future: firebaseActivition().getPartyOwnerUID(length),
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

                          SizedBox(height: 20),
                          Row(
                            children: [
                              Text(
                                  'Participants List',
                                  style: TextStyle(fontSize: 27,color: Color.fromARGB(255,238,69,64),fontWeight: FontWeight.w600)
                              ),
                              SizedBox(width: 40,),
                              FutureBuilder<List<dynamic>>(
                                future: firebaseActivition().fetchPartyParticipants(length),
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
                          SizedBox(height: 20),
                          Center(
                              child: ElevatedButton(
                                  style: ButtonStyle(
                                    backgroundColor: MaterialStateProperty.all<Color>(Color.fromARGB(255,238,69,64)), // Set the background color to red
                                    // Additional button style properties
                                  ),
                                  onPressed: () async {
                                    try {
                                      String username = await firebaseActivition().loadUsername();
                                      await firebaseActivition().addParticipant(length, username);
                                    } catch (e) {
                                      print('Error adding participant: $e');
                                    }
                                  },
                                  child: Text("PARTICIPATE!", style: TextStyle(fontSize: 16,color: Colors.white),)
                              )
                          )
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
