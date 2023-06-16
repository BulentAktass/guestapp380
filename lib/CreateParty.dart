import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
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

  late List<dynamic> participants = [];

  late String partyowner;
  
  late int upperlimit=0;
  
  late int underage=0;

  final User? user = FirebaseAuth.instance.currentUser;

  final CollectionReference partylist = FirebaseFirestore.instance.collection("Parties");

  late String location;

  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset : false,
        body: Center(
          child: Container(
            decoration: BoxDecoration(
              color: Color.fromARGB(255,45,19,44),
            ),
            child: Column(
              children: [
                SizedBox(height: 60),
                Text("CREATE YOUR OWN PARTY!!",style: TextStyle(fontSize: 27,color: Color.fromARGB(255,238,69,64),fontWeight: FontWeight.w400)),
                SizedBox(height: 20),

                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextField(
                    style: TextStyle(color: Colors.white),
                    decoration: InputDecoration(
                      enabledBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.white),
                      ),
                      focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(
                          color: Color.fromARGB(255,238,69,64),
                        )
                      ),
                      labelText: 'Party Name',
                      labelStyle: TextStyle(
                        color: Colors.white,
                      ),
                    ),
                    onChanged: (value){
                    partyname = value;
                  },),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextField(
                      style: TextStyle(color: Colors.white),
                      decoration: InputDecoration(
                      enabledBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.white),
                      ),
                      focusedBorder: UnderlineInputBorder(
                          borderSide: BorderSide(
                            color: Color.fromARGB(255,238,69,64),
                          )
                      ),
                      labelText: 'Party Description',
                      labelStyle: TextStyle(
                        color: Colors.white,
                      ),
                    ),
                    onChanged: (value){
                    description = value;
                  },),
                ),

                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextField(
                    style: TextStyle(color: Colors.white),
                    decoration: InputDecoration(
                      enabledBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.white),
                      ),
                      focusedBorder: UnderlineInputBorder(
                          borderSide: BorderSide(
                            color: Color.fromARGB(255,238,69,64),
                          )
                      ),
                      labelText: 'Date Time',
                      labelStyle: TextStyle(
                        color: Colors.white,
                      ),
                    ),
                    onChanged: (value){
                    datetime = value;
                  },),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextField(
                    style: TextStyle(color: Colors.white),
                    decoration: InputDecoration(
                      enabledBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.white),
                      ),
                      focusedBorder: UnderlineInputBorder(
                          borderSide: BorderSide(
                            color: Color.fromARGB(255,238,69,64),
                          )
                      ),
                      labelText: 'Location',
                      labelStyle: TextStyle(
                        color: Colors.white,
                      ),
                    ),
                    onChanged: (value){
                      location = value;
                    },),
                ),
                Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text("Required age range :", style: TextStyle(color: Colors.white,fontSize: 16,),),
                    ),
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: TextField(
                          style: TextStyle(color: Colors.white),
                          decoration: InputDecoration(
                            enabledBorder: UnderlineInputBorder(
                              borderSide: BorderSide(color: Colors.white),
                            ),
                            focusedBorder: UnderlineInputBorder(
                                borderSide: BorderSide(
                                  color: Color.fromARGB(255,238,69,64),
                                )
                            ),
                            labelStyle: TextStyle(
                              color: Colors.white,
                            ),
                          ),
                          onChanged: (value) {
                            int? parsedValue = int.tryParse(value);
                            if (parsedValue != null) {
                              underage = parsedValue;
                            }
                          },),
                      ),
                    ),
                    Text(" - ", style: TextStyle(color: Colors.white,fontSize: 25),),
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: TextField(
                          style: TextStyle(color: Colors.white),
                          decoration: InputDecoration(
                            enabledBorder: UnderlineInputBorder(
                              borderSide: BorderSide(color: Colors.white),
                            ),
                            focusedBorder: UnderlineInputBorder(
                                borderSide: BorderSide(
                                  color: Color.fromARGB(255,238,69,64),
                                )
                            ),
                            labelStyle: TextStyle(
                              color: Colors.white,
                            ),
                          ),
                            onChanged: (value) {
                              int? parsedValue = int.tryParse(value);
                              if (parsedValue != null) {
                                upperlimit = parsedValue;
                              }
                            },),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 19),
                ElevatedButton(
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all<Color>(Color.fromARGB(255,238,69,64)),
                  ),
                  child: Text("LETS GIVE A PARTY"),
                  onPressed: () async{
                    firebaseActivition().loadUsername().then((value) {
                      setState(() {
                        partyowner = value;
                      });
                    });
                    await partylist.add({
                      'ownerUID' : user?.uid.toString(),
                      'PartyOwner' : partyowner,
                      'Name' : partyname,
                      'Description' : description,
                      'DateTime' : datetime,
                      'Location' : location,
                      'participants' : participants,
                      'underage' : underage,
                      'upperlimit' : upperlimit,
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