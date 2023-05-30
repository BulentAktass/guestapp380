import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ProfilePage extends StatefulWidget {
  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
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
      final String currentUserId = user.uid;
      final DocumentSnapshot userSnapshot = await FirebaseFirestore.instance
          .collection('Account').doc(currentUserId).get();
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
      body: Container(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 30),
            Padding(
              padding: const EdgeInsets.only(bottom: 16),
              child: Text(
                'Profile Details',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            ListTile(
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
            ListTile(
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
            ListTile(
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
            ListTile(
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
          ],
        ),
      ),
    );
  }

}