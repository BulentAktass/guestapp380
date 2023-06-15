import 'package:flutter/material.dart';
import 'package:guestapp380/CreateParty.dart';
import 'package:guestapp380/LoginPage.dart';
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
        backgroundColor: Color.fromARGB(255,238,69,64),
        child: ListView(
          padding: EdgeInsets.zero,
          children:[
            SizedBox(height:55),
            Align(
              alignment: Alignment.center,
                child: Text("GUEST",style: TextStyle(color: Color.fromARGB(255,45,19,44),fontSize: 35,letterSpacing: 3),)
            ),
            SizedBox(height:45),
            Padding(
              padding: const EdgeInsets.only(right: 10,left: 10,bottom: 20),
              child: Container(
                decoration: BoxDecoration(
                  color: Color.fromARGB(255,45,19,44),
                  borderRadius: BorderRadius.circular(30.0),
                ),
                child: ListTile(
                  leading: Icon(Icons.account_circle,color: Color.fromARGB(255,238,69,64),),
                  title: Text('Profıle',style: TextStyle(color: Color.fromARGB(255,238,69,64),fontSize: 16,letterSpacing: 3),),
                  onTap: () => Navigator.push( context,
                    MaterialPageRoute(builder: (context) => ProfilePage()),),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(right: 10,left: 10,bottom: 20),
              child: Container(
                decoration: BoxDecoration(
                  color: Color.fromARGB(255,45,19,44),
                  borderRadius: BorderRadius.circular(30.0),
                ),
                child: ListTile(
                  leading: Icon(Icons.add_circle_outline,color: Color.fromARGB(255,238,69,64),),
                  title: Text('Create Party',style: TextStyle(color: Color.fromARGB(255,238,69,64),fontSize: 16,letterSpacing: 3),),
                  onTap: () => Navigator.push( context,
                    MaterialPageRoute(builder: (context) => CreateParty()),),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(right: 10,left: 10,bottom: 20),
              child: Container(
                decoration: BoxDecoration(
                  color: Color.fromARGB(255,45,19,44),
                  borderRadius: BorderRadius.circular(30.0),
                ),
                child: ListTile(
                  leading: Icon(Icons.local_fire_department_outlined,color: Color.fromARGB(255,238,69,64),),
                  title: Text('My Parties',style: TextStyle(color: Color.fromARGB(255,238,69,64),fontSize: 16,letterSpacing: 3),),
                  onTap: () => Navigator.push( context,
                    MaterialPageRoute(builder: (context) => MyParties()),),
                ),
              ),
            ),
            SizedBox(height: 50),
            Padding(
              padding: const EdgeInsets.only(right: 10,left: 10,bottom: 20),
              child: Container(
                decoration: BoxDecoration(
                  color: Color.fromARGB(255,45,19,44),
                  borderRadius: BorderRadius.circular(30.0),
                ),
                child: ListTile(
                  leading: Icon(Icons.logout,color: Color.fromARGB(255,238,69,64),),
                  title: Text('Logout',style: TextStyle(color: Color.fromARGB(255,238,69,64),fontSize: 16,letterSpacing: 3),),
                  onTap: () => Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                          builder: (context) => LoginPage())),
                ),
              ),
            ),
          ],
        ),
      ),
      body: Container(
        decoration: BoxDecoration(
          color: Color.fromARGB(255,45,19,44),
        ),
        child: Column(
          children:[
            SizedBox(height: 45),
            Row(
              children:[
                SizedBox(width: 5),
                IconButton(alignment: Alignment.topLeft,icon: Icon(Icons.menu,size: 32,),color: Color.fromARGB(255,238,69,64),onPressed: () => _scaffkey.currentState?.openDrawer()),
                SizedBox(width: 230),
                Text("EVENTS",style: TextStyle(fontSize: 30,color: Color.fromARGB(255,238,69,64),fontWeight: FontWeight.w600)),
              ],
            ),
            Expanded(
              child: Container(
                child: ListView.builder(
                    itemCount: partiler.length,
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: const EdgeInsets.only(right: 10,left: 10,bottom: 20),
                        child: Container(
                          decoration: BoxDecoration(
                            color: Color.fromARGB(255,238,69,64),
                            borderRadius: BorderRadius.circular(20.0),
                          ),
                          child: ListTile(
                            tileColor: Colors.grey[200], // Background color
                            contentPadding: EdgeInsets.symmetric(horizontal: 16.0),
                            leading: ClipRRect(
                                borderRadius: BorderRadius.circular(10.0), // Adjust the value as needed
                                child: Container(
                                  decoration: BoxDecoration(
                                      border: Border.all(
                                        color: Colors.black,
                                        width: 1.5,)
                                  ),
                                  child: Image.network(
                                    'https://as2.ftcdn.net/v2/jpg/01/20/87/67/1000_F_120876722_dJlNWgyMJxnhLzuA6e9cKRypSECZVQjy.jpg',
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              ),

                            title: Text(partiler[index]["Name"],style: TextStyle(fontSize: 18),),
                            subtitle: Text(
                              partiler[index]["Description"],
                              overflow: TextOverflow.ellipsis,
                            ),
                            trailing: Text(partiler[index]["DateTime"]),
                            onTap: () => Navigator.push(context, MaterialPageRoute(builder: (context) => PartyDetails(length: index,))),
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
