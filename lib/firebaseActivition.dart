import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';

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
  Future<String> getPartyDescription(index) async{
    List parties = [];
    await partylist.get().then((QuerySnapshot){
      QuerySnapshot.docs.forEach((element) {
        parties.add(element.data());
      });
    });
    return parties[index]["Description"];
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