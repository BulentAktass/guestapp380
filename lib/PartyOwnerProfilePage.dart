import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class PartyOwnerProfilePage extends StatefulWidget {
  @override
  _PartyOwnerProfilePageState createState() => _PartyOwnerProfilePageState();
  final String index;
  const PartyOwnerProfilePage({Key? key, required this.index}) : super(key: key);
}

class _PartyOwnerProfilePageState extends State<PartyOwnerProfilePage> {
  final CollectionReference accounts =
  FirebaseFirestore.instance.collection("Account");
  User? currentUser;
  String? age;
  String? location;
  String? email;
  String? userName;

  @override
  void initState() {
    super.initState();
    fetchCurrentUser();
  }

  void fetchCurrentUser() async {
    final User? user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      final DocumentSnapshot userSnapshot = await FirebaseFirestore.instance
          .collection('Account').doc(widget.index).get();
      final String currentUserAge = userSnapshot['Age'];
      final String currentUserLocation = userSnapshot['Location'];
      final String currentUserEmail = userSnapshot['email'];
      final String currentUserUsername = userSnapshot['userName'];
      setState(() {
        age = currentUserAge;
        location = currentUserLocation;
        email = currentUserEmail;
        userName = currentUserUsername;
      });
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset : false,
      body: Container(
        decoration: BoxDecoration(
          color: Color.fromARGB(255,45,19,44),
        ),
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 30),
            Padding(
              padding: const EdgeInsets.only(bottom: 16),
              child: Align(
                alignment: Alignment.centerRight,
                child: Text(
                  'Profıle Detaıls  ',
                  style: TextStyle(
                    color: Color.fromARGB(255,238,69,64),
                    fontSize: 30,letterSpacing: 2,
                  ),
                ),
              ),
            ),
            SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.only(right: 10,left: 10,bottom: 20),
              child: Container(
                decoration: BoxDecoration(
                  color: Color.fromARGB(255,238,69,64),
                  borderRadius: BorderRadius.circular(20.0),
                ),
                child: ListTile(
                  leading: Icon(Icons.person),
                  title: Text(
                    'Username:',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  subtitle: Text(
                    '$userName',
                    style: TextStyle(
                      fontSize: 18,
                    ),
                  ),
                ),
              ),
            ),

            Padding(
              padding: const EdgeInsets.only(right: 10,left: 10,bottom: 20),
              child: Container(
                decoration: BoxDecoration(
                  color: Color.fromARGB(255,238,69,64),
                  borderRadius: BorderRadius.circular(20.0),
                ),
                child: ListTile(
                  leading: Icon(Icons.email),
                  title: Text(
                    'Email:',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  subtitle: Text(
                    '$email',
                    style: TextStyle(
                      fontSize: 18,
                    ),
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(right: 10,left: 10,bottom: 20),
              child: Container(
                decoration: BoxDecoration(
                  color: Color.fromARGB(255,238,69,64),
                  borderRadius: BorderRadius.circular(20.0),
                ),
                child: ListTile(
                  leading: Icon(Icons.location_on),
                  title: Text(
                    'Location:',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  subtitle: Text(
                    '$location',
                    style: TextStyle(
                      fontSize: 18,
                    ),
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(right: 10,left: 10,bottom: 20),
              child: Container(
                decoration: BoxDecoration(
                  color: Color.fromARGB(255,238,69,64),
                  borderRadius: BorderRadius.circular(20.0),
                ),
                child: ListTile(
                  leading: Icon(Icons.cake),
                  title: Text(
                    'Age:',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  subtitle: Text(
                    '$age',
                    style: TextStyle(
                      fontSize: 18,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

}