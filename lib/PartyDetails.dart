import 'package:flutter/material.dart';
import 'package:guestapp380/firebaseActivition.dart';

class PartyDetails extends StatelessWidget {
  final int length;

  const PartyDetails({Key? key, required this.length}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
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
            height: 554,
            width: 600,
            decoration: BoxDecoration(
              color: Color.fromARGB(255,45,19,44),
            ),
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Container(
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
                    SizedBox(height: 8),
                    FutureBuilder<String>(
                      future: firebaseActivition().getPartyOwner(length),
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
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
