import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:guestapp380/CreateParty.dart';
import 'package:guestapp380/ProfilePage.dart';
import 'package:guestapp380/PartyDetails.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

class PartyDetails extends StatelessWidget {

  Widget build(BuildContext context) {
    return Scaffold(
        body: buildCoverImage(),



      );

  }
}

Widget buildCoverImage() => Container(
  color:Colors.grey,
  child:Image.network('https://as2.ftcdn.net/v2/jpg/01/20/87/67/1000_F_120876722_dJlNWgyMJxnhLzuA6e9cKRypSECZVQjy.jpg',
  width:double.infinity,
  height: 280,
      fit: BoxFit.cover,)
);
