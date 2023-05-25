import 'package:flutter/material.dart';
import 'package:guestapp380/firebaseActivition.dart';

class PartyDetails extends StatelessWidget {
  final int length;

  const PartyDetails({Key? key, required this.length}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          children: [
            FutureBuilder<String>(
              future: firebaseActivition().getPartyName(length),
              builder: (BuildContext context, AsyncSnapshot<String> snapshot) {
                if (snapshot.hasData) {
                  return Text(snapshot.data.toString());
                } else if (snapshot.hasError) {
                  return Text("Error: ${snapshot.error}");
                } else {
                  return CircularProgressIndicator();
                }
              },
            ),
            FutureBuilder<String>(
              future: firebaseActivition().getPartyDescription(length),
              builder: (BuildContext context, AsyncSnapshot<String> snapshot) {
                if (snapshot.hasData) {
                  return Text(snapshot.data.toString());
                } else if (snapshot.hasError) {
                  return Text("Error: ${snapshot.error}");
                } else {
                  return CircularProgressIndicator();
                }
              },
            ),
            FutureBuilder<String>(
              future: firebaseActivition().getPartyDateTime(length),
              builder: (BuildContext context, AsyncSnapshot<String> snapshot) {
                if (snapshot.hasData) {
                  return Text(snapshot.data.toString());
                } else if (snapshot.hasError) {
                  return Text("Error: ${snapshot.error}");
                } else {
                  return CircularProgressIndicator();
                }
              },
            ),
            FutureBuilder<String>(
              future: firebaseActivition().getPartyOwner(length),
              builder: (BuildContext context, AsyncSnapshot<String> snapshot) {
                if (snapshot.hasData) {
                  return Text(snapshot.data.toString());
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
    );
  }
}


Widget buildCoverImage() => Container(
    color:Colors.grey,
    child:Image.network('https://as2.ftcdn.net/v2/jpg/01/20/87/67/1000_F_120876722_dJlNWgyMJxnhLzuA6e9cKRypSECZVQjy.jpg',
      width:double.infinity,
      height: 220,
      fit: BoxFit.cover,)
);
