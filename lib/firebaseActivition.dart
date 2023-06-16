import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:guestapp380/PartyDetails.dart';


class firebaseActivition extends StatefulWidget{

  @override
  State<firebaseActivition> createState() => _firebaseActivitionState();

  final CollectionReference partylist = FirebaseFirestore.instance.collection("Parties");
  late String participateDialogMessage="";
  Future getPartyList() async{
    List parties = [];
    try{
      await partylist.get().then((QuerySnapshot){
        QuerySnapshot.docs.forEach((element) {
          parties.add(element.data());
        });
      });
      return parties;
    } catch(e){
      print(e.toString());
      return null;
    }
  }
  Future<List<dynamic>> fetchPartyParticipants(int index) async {
    List<Map<String, dynamic>> parties = [];
    await partylist.get().then((QuerySnapshot querySnapshot) {
      querySnapshot.docs.forEach((QueryDocumentSnapshot doc) {
        parties.add(doc.data() as Map<String, dynamic>);
      });
    });
    List<dynamic> participants = parties[index]['participants'];
    List<dynamic> emptylist = ["This party is empty for now...","asd"];
    if (participants == null){
      return emptylist;
    }
    else{
      return participants;
    }
  }

  Future<void> addParticipant(int index, String newParticipant) async {
    try {
      List<Map<String, dynamic>> parties = [];
      String docID = "";
      int currentIndex = 0;

      await partylist.get().then((QuerySnapshot querySnapshot) {
        querySnapshot.docs.forEach((QueryDocumentSnapshot doc) {
          Map<String, dynamic> party = doc.data() as Map<String, dynamic>;
          parties.add(party);

          if (currentIndex == index) {
            docID = doc.id;
          }
          currentIndex++;
        });
      });
      Map<String, dynamic> thisParty = parties[index];
      List<dynamic> participants = thisParty['participants'];
      print(participants.toString());
      int Age = 0;
      String username="";
      await getPartyOwner(index).then((value){
        username = value;
      });
      await loadUserAge().then((int userAge) {
        Age = userAge;
      });
      int underage = thisParty['underage'];
      int upperlimit = thisParty['upperlimit'];
      if (Age < underage || Age > upperlimit) {
        print("You cannot enter. Your age is not within the allowed range.");
        updateParticipateDialogMessage("You cannot enter. Your age is not within the allowed range.");
        PartyDetails.dialogMessage = participateDialogMessage;
        return;
      } else if (participants.contains(newParticipant)) {
        print('You are already in the party.');
        updateParticipateDialogMessage('You are already in the party.');
        PartyDetails.dialogMessage = participateDialogMessage;
        return;
      } else if( newParticipant == username){
        print("You cannot participate to your own party :)");
        updateParticipateDialogMessage("You cannot participate to your own party :)");
        PartyDetails.dialogMessage = participateDialogMessage;
      }
      else {
        participants.add(newParticipant);
        thisParty['participants'] = participants;
        await partylist.doc(docID).update(thisParty);
        print('New participant added successfully!');
        updateParticipateDialogMessage('New participant added successfully!');
        PartyDetails.dialogMessage = participateDialogMessage;
      }
    }
     catch (e) {
      print('Error adding participant: $e');
    }
  }

  void updateParticipateDialogMessage(String message) {
    participateDialogMessage = message;
  }

  Future<int> getPartyunderage(index) async{
    List parties = [];
    await partylist.get().then((QuerySnapshot){
      QuerySnapshot.docs.forEach((element) {
        parties.add(element.data());
      });
    });
    return parties[index]["underage"];
  }
  Future<int> getPartyupperage(index) async{
    List parties = [];
    await partylist.get().then((QuerySnapshot){
      QuerySnapshot.docs.forEach((element) {
        parties.add(element.data());
      });
    });
    return parties[index]["upperlimit"];
  }

  Future<String> getPartyName(index) async{
    List parties = [];
    await partylist.get().then((QuerySnapshot){
      QuerySnapshot.docs.forEach((element) {
        parties.add(element.data());
      });
    });
    return parties[index]["Name"];
  }

  Future<String> loadUsername() async {
    final User? user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      final DocumentSnapshot snapshot =
      await FirebaseFirestore.instance.collection('Account').doc(user.uid).get();
      return snapshot['userName'];
    }
    return '( USERNAME CANT LOADED )';
  }
  Future<int> loadUserAge() async {
    final User? user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      final DocumentSnapshot snapshot =
      await FirebaseFirestore.instance.collection('Account').doc(user.uid).get();
      String value = snapshot['Age'];
      int userage = int.parse(value);
      print(userage);
      return userage;
    }
    return 0;
  }

  Future<String> getPartyOwner(index) async{
    List parties = [];
    await partylist.get().then((QuerySnapshot){
      QuerySnapshot.docs.forEach((element) {
        parties.add(element.data());
      });
    });
    return parties[index]["PartyOwner"];
  }

  Future<String> getPartyOwnerUID(index) async{
    List parties = [];
    await partylist.get().then((QuerySnapshot){
      QuerySnapshot.docs.forEach((element) {
        parties.add(element.data());
      });
    });
    return parties[index]["ownerUID"];
  }

  Future<String> getPartyDescription(index) async{
    List parties = [];
    await partylist.get().then((QuerySnapshot){
      QuerySnapshot.docs.forEach((element) {
        parties.add(element.data());
      });
    });
    return parties[index]["Description"];
  }

  Future<String> getPartyLocation(index) async{
    List parties = [];
    await partylist.get().then((QuerySnapshot){
      QuerySnapshot.docs.forEach((element) {
        parties.add(element.data());
      });
    });
    return parties[index]["Location"];
  }

  Future<String> getPartyDateTime(index) async{
    List parties = [];
    await partylist.get().then((QuerySnapshot){
      QuerySnapshot.docs.forEach((element) {
        parties.add(element.data());
      });
    });
    return parties[index]["DateTime"];
  }
}

class _firebaseActivitionState extends State<firebaseActivition> {

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    throw UnimplementedError();
  }
}

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<User?> signIn(String email, String password) async {
    var user = await _auth.signInWithEmailAndPassword(
        email: email, password: password);
    return user.user;
  }

  signOut() async {
    return await _auth.signOut();
  }


  Future<User?> createAccount(String name, String email, String password, String Age, String Location) async {
    var user = await _auth.createUserWithEmailAndPassword(
        email: email, password: password);

    await _firestore
        .collection("Account")
        .doc(user.user!.uid)
        .set({'userName': name, 'email': email, 'Age' : Age, 'Location' : Location});

    return user.user;
  }
}