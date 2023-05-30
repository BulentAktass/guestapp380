import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:firebase_auth/firebase_auth.dart';


class firebaseActivition extends StatelessWidget{

  final CollectionReference partylist = FirebaseFirestore.instance.collection("Parties");

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
  Future<String> getPartyOwner(index) async{
    List parties = [];
    await partylist.get().then((QuerySnapshot){
      QuerySnapshot.docs.forEach((element) {
        parties.add(element.data());
      });
    });
    return parties[index]["PartyOwner"];
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