import 'package:flutter/material.dart';
import 'package:guestapp380/firebaseActivition.dart';
import 'package:guestapp380/LoginPage.dart';

class RegisterPage extends StatefulWidget {
  @override
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _ageController = TextEditingController();
  final TextEditingController _LocationController = TextEditingController();

  AuthService _authService = AuthService();

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
        body: Stack(
          children: [
            Center(
              child: Container(
                decoration: BoxDecoration(
                    image: DecorationImage(image: NetworkImage("https://wallpaperaccess.com/full/4325152.jpg"),fit: BoxFit.fill)),
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      TextField(
                          controller: _nameController,
                          style: TextStyle(
                            color: Colors.white,
                          ),
                          cursorColor: Colors.white,
                          keyboardType: TextInputType.emailAddress,
                          decoration: InputDecoration(
                            prefixIcon: Icon(
                              Icons.person,
                              color: Colors.white,
                            ),
                            hintText: 'User ID',
                            prefixText: ' ',
                            hintStyle: TextStyle(color: Colors.white),
                            focusColor: Colors.white,
                            focusedBorder: UnderlineInputBorder(
                                borderSide: BorderSide(
                                  color: Colors.white,
                                )),
                            enabledBorder: UnderlineInputBorder(
                                borderSide: BorderSide(
                                  color: Colors.white,
                                )),
                          )),
                      SizedBox(
                        height: size.height * 0.02,
                      ),
                      TextField(
                          controller: _ageController,
                          style: TextStyle(
                            color: Colors.white,
                          ),
                          cursorColor: Colors.white,
                          keyboardType: TextInputType.number,
                          decoration: InputDecoration(
                            prefixIcon: Icon(
                              Icons.calendar_month,
                              color: Colors.white,
                            ),
                            hintText: 'Your Age',
                            prefixText: ' ',
                            hintStyle: TextStyle(color: Colors.white),
                            focusColor: Colors.white,
                            focusedBorder: UnderlineInputBorder(
                                borderSide: BorderSide(
                                  color: Colors.white,
                                )),
                            enabledBorder: UnderlineInputBorder(
                                borderSide: BorderSide(
                                  color: Colors.white,
                                )),
                          )),
                      SizedBox(
                        height: size.height * 0.02,
                      ),
                      TextField(
                          controller: _LocationController,
                          style: TextStyle(
                            color: Colors.white,
                          ),
                          cursorColor: Colors.white,
                          keyboardType: TextInputType.number,
                          decoration: InputDecoration(
                            prefixIcon: Icon(
                              Icons.location_on,
                              color: Colors.white,
                            ),
                            hintText: 'Location',
                            prefixText: ' ',
                            hintStyle: TextStyle(color: Colors.white),
                            focusColor: Colors.white,
                            focusedBorder: UnderlineInputBorder(
                                borderSide: BorderSide(
                                  color: Colors.white,
                                )),
                            enabledBorder: UnderlineInputBorder(
                                borderSide: BorderSide(
                                  color: Colors.white,
                                )),
                          )),
                      SizedBox(
                        height: size.height * 0.02,
                      ),
                      TextField(
                          controller: _emailController,
                          style: TextStyle(
                            color: Colors.white,
                          ),
                          cursorColor: Colors.white,
                          keyboardType: TextInputType.emailAddress,
                          decoration: InputDecoration(
                            prefixIcon: Icon(
                              Icons.mail,
                              color: Colors.white,
                            ),
                            hintText: 'E-Mail',
                            prefixText: ' ',
                            hintStyle: TextStyle(color: Colors.white),
                            focusColor: Colors.white,
                            focusedBorder: UnderlineInputBorder(
                                borderSide: BorderSide(
                                  color: Colors.white,
                                )),
                            enabledBorder: UnderlineInputBorder(
                                borderSide: BorderSide(
                                  color: Colors.white,
                                )),
                          )),
                      SizedBox(
                        height: size.height * 0.02,
                      ),
                      TextField(
                          style: TextStyle(
                            color: Colors.white,
                          ),
                          cursorColor: Colors.white,
                          controller: _passwordController,
                          obscureText: true,
                          decoration: InputDecoration(
                            prefixIcon: Icon(
                              Icons.vpn_key,
                              color: Colors.white,
                            ),
                            hintText: 'Password',
                            prefixText: ' ',
                            hintStyle: TextStyle(color: Colors.white),
                            focusColor: Colors.white,
                            focusedBorder: UnderlineInputBorder(
                                borderSide: BorderSide(
                                  color: Colors.white,
                                )),
                            enabledBorder: UnderlineInputBorder(
                                borderSide: BorderSide(
                                  color: Colors.white,
                                )),
                          )),
                      SizedBox(
                        height: size.height * 0.02,
                      ),
                      SizedBox(
                        height: size.height * 0.08,
                      ),
                      InkWell(
                        onTap: () {
                          _authService
                              .createAccount(
                              _nameController.text,
                              _emailController.text,
                              _passwordController.text,
                              _ageController.text,
                              _LocationController.text)
                              .then((value) {
                            return Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => LoginPage()));
                          });
                        },
                        child: Container(
                          padding: EdgeInsets.symmetric(vertical: 5),
                          decoration: BoxDecoration(
                              border: Border.all(color: Colors.white, width: 2),
                              //color: colorPrimaryShade,
                              borderRadius:
                              BorderRadius.all(Radius.circular(30))),
                          child: Padding(
                            padding: const EdgeInsets.all(5.0),
                            child: Center(
                                child: Text(
                                  "Save",
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 20,
                                  ),
                                )),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            Padding(
              padding:
              EdgeInsets.only(top: size.height * .06, left: size.width * .02),
              child: Align(
                alignment: Alignment.topLeft,
                child: Row(
                  children: [
                    IconButton(
                      onPressed: () => Navigator.pop(context),
                      icon: Icon(
                        Icons.arrow_back_ios_outlined,
                        color: Colors.blue.withOpacity(.75),
                        size: 26,
                      ),
                    ),
                    SizedBox(
                      width: size.width * 0.3,
                    ),
                    Text(
                      "Register",
                      style: TextStyle(
                          fontSize: 20,
                          color: Colors.white.withOpacity(.75),
                          fontWeight: FontWeight.bold),
                    )
                  ],
                ),
              ),
            )
          ],
        ));
  }
}