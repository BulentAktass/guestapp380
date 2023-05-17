import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:guestapp380/CreateParty.dart';
import 'package:guestapp380/ProfilePage.dart';
import 'package:guestapp380/PartyDetails.dart';

class MainPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  GlobalKey<ScaffoldState> _scaffkey = GlobalKey<ScaffoldState>();
  List partiler = [];

  @override
  void initState(){
    super.initState();
    fetchdata();
  }

  fetchdata() async {
    dynamic resultant = await CreateParty().getPartyList();
    if(resultant==null){
      print("Unable to retrieve");
    }
    else{
      setState(() {
        partiler = resultant;
        print(partiler.length.toString());
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        key: _scaffkey,
        drawer: Drawer(
          child: ListView(
            padding: EdgeInsets.zero,
            children: <Widget>[
              DrawerHeader(
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: NetworkImage(
                      "https://wallpaperaccess.com/full/4325152.jpg",
                    ),
                    fit: BoxFit.cover,
                  ),
                  color: Colors.blueGrey,
                ),
                child: Text(
                  'GUEST',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 27,
                  ),
                ),
              ),
              ListTile(
                leading: Icon(Icons.account_circle),
                title: Text('Profile'),
                onTap: () => Navigator.push( context,
                  MaterialPageRoute(builder: (context) => ProfilePage()),),
              ),
              ListTile(
                leading: Icon(Icons.add_location_alt_sharp),
                title: Text('Create Party'),
                onTap: () => Navigator.push( context,
                  MaterialPageRoute(builder: (context) => CreateParty()),),
              ),
            ],
          ),
        ),
        body: Container(
          child: Column(
            children:[
              SizedBox(height: 40),
              Row(
                children:[
                  IconButton(alignment: Alignment.topLeft,icon: Icon(Icons.menu),color: Colors.black,onPressed: () => _scaffkey.currentState?.openDrawer()),
                  Text("EVENTS",style: TextStyle(fontSize: 30), textAlign: TextAlign.right,),
                ],
              ),
            Container(
              height: 500,
              child: ListView.builder(
                    itemCount: partiler.length,
                      itemBuilder: (context, index) {
                        return ListTile(
                                leading: Image.asset('lib/icons/mandancing.png',height: 45,),
                                title: Text(partiler[index]["Name"]),
                                subtitle: Text(partiler[index]["Description"]),
                                trailing: Text(partiler[index]["DateTime"]),
                                onTap: () => Navigator.push( context, MaterialPageRoute(builder: (context) => PartyDetails())),
                        );
                      }),
            ),
            ],
            ),
        ),
        );
  }
  }
