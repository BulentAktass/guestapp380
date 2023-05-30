import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:guestapp380/MainPage.dart';
import 'package:guestapp380/firebaseActivition.dart';

class CreateParty extends StatefulWidget {
  @override
  State<CreateParty> createState() => _CreatePartyState();
}

class _CreatePartyState extends State<CreateParty> {
  late String partyname;

  late String description;

  late String datetime;

  late String partyowner;

  final CollectionReference partylist = FirebaseFirestore.instance.collection("Parties");

  late String location;

  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
          child: Container(
            decoration: const BoxDecoration(
                image: DecorationImage(image: NetworkImage("https://camo.githubusercontent.com/ec9d627e96a9a77c1a18eb08ce9f7d15bfcaf6b3736c55d469ea2973b72fe8fe/687474703a2f2f692e696d6775722e636f6d2f494d524c6c39442e706e67"),fit: BoxFit.fill)
            ),
            child: Column(
              children: [
                SizedBox(height: 60),
                Text("CREATE YOUR OWN PARTY!!", style: TextStyle(fontSize: 25, ),),
                SizedBox(height: 20),

                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextField(
                    decoration: InputDecoration(

                      border: OutlineInputBorder(),
                      labelText: 'Party Name',
                    ),
                    onChanged: (value){
                    partyname = value;
                  },),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextField(
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Party Description',
                    ),
                    onChanged: (value){
                    description = value;
                  },),
                ),

                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextField(
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Date Time',
                    ),
                    onChanged: (value){
                    datetime = value;
                  },),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextField(
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Location',
                    ),
                    onChanged: (value){
                      location = value;
                    },),
                ),

                ElevatedButton(
                  child: Text("LETS GIVE A PARTY"),
                  onPressed: () async{
                    firebaseActivition().loadUsername().then((value) {
                      setState(() {
                        partyowner = value;
                      });
                    });
                    await partylist.add({
                      'PartyOwner' : partyowner,
                      'Name' : partyname,
                      'Description' : description,
                      'DateTime' : datetime,
                      'Location' : location,
                    });
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => MainPage()));
                  },
                )
              ],
            ),
          ),
        )
    );
  }
}