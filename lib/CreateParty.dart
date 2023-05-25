import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class CreateParty extends StatelessWidget {
  late String partyname;
  late String description;
  late String datetime;

  final CollectionReference partylist = FirebaseFirestore.instance.collection("Parties");

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

                ElevatedButton(
                  child: Text("LETS GIVE A PARTY"),
                  onPressed: () async{
                    await partylist.add({
                      'Name' : partyname,
                      'Description' : description,
                      'DateTime' : datetime,
                      'PartyOwner' : "BUNU HALLEDİCEZ Bİ ŞEKİL",
                    });
                  },
                )
              ],
            ),
          ),
        )
    );
  }
}