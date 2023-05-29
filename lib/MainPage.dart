import 'package:flutter/material.dart';
import 'package:guestapp380/CreateParty.dart';
import 'package:guestapp380/MyParties.dart';
import 'package:guestapp380/ProfilePage.dart';
import 'package:guestapp380/PartyDetails.dart';
import 'package:guestapp380/firebaseActivition.dart';

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
    dynamic resultant = await firebaseActivition().getPartyList();
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
            ListTile(
              leading: Icon(Icons.account_circle),
              title: Text('My Parties'),
              onTap: () => Navigator.push( context,
                MaterialPageRoute(builder: (context) => MyParties()),),
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
            Expanded(
              child: Container(
                child: ListView.builder(
                  itemExtent: 130,
                    itemCount: partiler.length,
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Container(
                          decoration: BoxDecoration(
                            color: Colors.lightGreen,
                            borderRadius: BorderRadius.circular(20.0),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey.withOpacity(0.6),
                                blurRadius: 3.0,
                                offset: Offset(0, 3),
                              ),
                            ],
                          ),
                          child: ListTile(
                            tileColor: Colors.grey[200], // Background color
                            contentPadding: EdgeInsets.symmetric(horizontal: 16.0),
                            leading: Container(
                              child: Image.network('https://as2.ftcdn.net/v2/jpg/01/20/87/67/1000_F_120876722_dJlNWgyMJxnhLzuA6e9cKRypSECZVQjy.jpg', fit: BoxFit.cover,),
                            ),
                            title: Text(partiler[index]["Name"]),
                            subtitle: Text(
                              partiler[index]["Description"],
                              overflow: TextOverflow.ellipsis,
                            ),
                            trailing: Text(partiler[index]["DateTime"]),
                            onTap: () => Navigator.push( context, MaterialPageRoute(builder: (context) => PartyDetails(length: index,))),
                          ),
                        ),
                      );
                    }),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
