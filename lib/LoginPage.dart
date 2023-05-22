import 'package:flutter/material.dart';
import 'package:guestapp380/MainPage.dart';


class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  bool _obsecuretext = true;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
            image: DecorationImage(image: NetworkImage("https://wallpaperaccess.com/full/4325152.jpg"),fit: BoxFit.fill)
        ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              //Hellotext
              Text('GUEST',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 70,color: Colors.purple),),
              SizedBox(height: 8),
              Text('                                     Events and more...',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16, color: Colors.white),),

              SizedBox(height: 90),

              //emailtext
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 30.0),
                child: Container(
                  decoration: BoxDecoration(
                      color: Colors.grey[200],
                      border: Border.all(color: Colors.white),
                      borderRadius: BorderRadius.circular(14)
                  ),
                  child: Padding(
                    padding: const EdgeInsets.only(left: 20.0),
                    child: TextField(
                      keyboardType: TextInputType.emailAddress,
                      decoration: InputDecoration(
                          border: InputBorder.none,
                          hintText: 'Email'
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(height: 10,),

              //passwordtext
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 30.0),
                child: Container(
                  decoration: BoxDecoration(
                      color: Colors.grey[200],
                      border: Border.all(color: Colors.white),
                      borderRadius: BorderRadius.circular(14)
                  ),
                  child: Padding(
                    padding: const EdgeInsets.only(left: 20.0),
                    child: TextField(
                      obscureText: _obsecuretext,
                      decoration: InputDecoration(
                          suffixIcon: GestureDetector(
                            onTap: (){
                              setState(() {
                                _obsecuretext = !_obsecuretext;
                              });
                            },
                            child: Icon(_obsecuretext
                                ? Icons.visibility
                                : Icons.visibility_off),
                          ),
                          border: InputBorder.none,
                          hintText: 'Password'
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(height: 12,),

              Padding(
                padding: const EdgeInsets.only(left: 230.0),
                child: Text('Forgot Password?',
                  style: TextStyle(
                      color: Colors.blue,
                      fontWeight: FontWeight.bold,
                      fontSize: 15
                  ),
                ),
              ),
              SizedBox(height: 15,),

              //sign button
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 30.0),
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.deepPurple,
                    borderRadius: BorderRadius.circular(14),
                  ),
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.transparent,
                      elevation: 0,),
                    onPressed:(){
                      Navigator.push(context,
                        MaterialPageRoute(builder: (context) => MainPage()),);
                    }, child: Text("Login",style: TextStyle(color:Colors.white),),
                  ),
                ),
              ),

              SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text('-------------------- Not a member? --------------------',
                    style: TextStyle(
                        fontWeight: FontWeight.bold,color: Colors.white
                    ),
                  ),
                ],
              ),
              SizedBox(height: 16),

              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text('Register Now',
                    style: TextStyle(
                        color: Colors.blue,
                        fontWeight: FontWeight.bold,
                        fontSize: 15
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}