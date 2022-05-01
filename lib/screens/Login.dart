import '../model/Login.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_signin_button/button_view.dart';
import 'package:flutter_signin_button/flutter_signin_button.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
// import 'package:animated_text_kit/animated_text_kit.dart';
import 'Home.dart';
import '../model/Registration.dart';
import 'SignUp.dart';
import '../httpBaseInstances/dio_instance.dart';
import 'dart:io';
import 'dart:convert';
import 'dart:async';
import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../model/LoginResponse.dart';
import 'package:http/http.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  _LoginPage createState() => _LoginPage();
}

class _LoginPage extends State<LoginPage> {
  //email RegExp
  final _emailRegExp = RegExp(
      r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+");

  final loginModel = Login('', '');
  final loginresponse = LoginResponseObject('', '', '', '', '', '', '');
  List<MaterialColor> colorizeColors = [
    Colors.red,
    Colors.amber,
    Colors.yellow,
  ];

  Dio dio1 = new Dio();
  final _formKey = GlobalKey<FormState>();
  static const colorizeTextStyle =
      TextStyle(fontSize: 25.0, fontFamily: 'SF', color: Colors.redAccent);
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF800020),
      appBar: _getAppBar(),
      body: mainPage(context),
    );
  }

  Widget mainPage(context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: const Color.fromARGB(255, 15, 14, 15),
        body: ListView(
          children: [
            Container(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                      height: 500,
                      margin:
                          const EdgeInsets.only(top: 80, left: 10, right: 10),
                      decoration: BoxDecoration(
                        gradient: LinearGradient(colors: [
                          Color.fromARGB(255, 29, 28, 28),
                          Color.fromARGB(255, 15, 15, 15),
                        ]),
                        borderRadius: BorderRadius.only(
                          topRight: Radius.circular(50),
                          bottomLeft: Radius.circular(50),
                        ),
                      ),
                      child: Form(
                        key: _formKey,
                        child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                'Login ',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    color: Color.fromARGB(255, 163, 8, 8),
                                    fontWeight: FontWeight.bold,
                                    fontSize: 20,
                                    fontFamily: 'Raleway'),
                              ),
                              Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 25),
                                child: Column(
                                  children: [
                                    TextFormField(
                                      decoration: const InputDecoration(
                                          enabledBorder: OutlineInputBorder(
                                              borderRadius: BorderRadius.all(
                                                  Radius.circular(20)),
                                              borderSide: BorderSide(
                                                  color: Color(0xFF8A3324),
                                                  width: 2)),
                                          focusedBorder: OutlineInputBorder(
                                              borderRadius: BorderRadius.all(
                                                  Radius.circular(20)),
                                              borderSide: BorderSide(
                                                  color: Color(0xFF8A3324),
                                                  width: 2)),
                                          filled: true,
                                          fillColor: Color.fromARGB(
                                              255, 250, 250, 250),
                                          focusColor: Color(0xFF800020),
                                          hintText: 'Email',
                                          hintStyle: TextStyle(
                                            color: Color.fromARGB(
                                                255, 173, 167, 169),
                                          )),
                                      validator: (value) {
                                        if (value == null || value.isEmpty) {
                                          return 'Please enter  email';
                                        }
                                        return null;
                                      },
                                    ),
                                    SizedBox(
                                      height: 10,
                                    ),
                                    TextFormField(
                                      obscureText: true,
                                      decoration: const InputDecoration(
                                          enabledBorder: OutlineInputBorder(
                                              borderRadius: BorderRadius.all(
                                                  Radius.circular(20)),
                                              borderSide: BorderSide(
                                                  color: Color(0xFF8A3324),
                                                  width: 2)),
                                          focusedBorder: OutlineInputBorder(
                                              borderRadius: BorderRadius.all(
                                                  Radius.circular(20)),
                                              borderSide: BorderSide(
                                                  color: Color(0xFF8A3324),
                                                  width: 2)),
                                          filled: true,
                                          fillColor: Color.fromARGB(
                                              255, 255, 254, 253),
                                          focusColor: Color(0xFF800020),
                                          hintText: 'Password',
                                          suffixIcon:
                                              Icon(Icons.remove_red_eye),
                                          hintStyle: TextStyle(
                                            color: Color.fromARGB(
                                                255, 173, 167, 169),
                                          )),
                                      onChanged: (value) {
                                        loginModel.password = value;
                                      },
                                      validator: (value) {
                                        if (value == null || value.isEmpty) {
                                          return 'Please enter  password';
                                        }
                                        return null;
                                      },
                                    ),
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.end,
                                      children: [
                                        Text(
                                          "Forget Password",
                                          style: TextStyle(
                                            color: Color.fromARGB(
                                                255, 246, 247, 248),
                                            fontSize: 15,
                                          ),
                                        ),
                                      ],
                                    ),
                                    SizedBox(
                                      height: 20,
                                    ),
                                    Container(
                                      height: 40,
                                      width: MediaQuery.of(context).size.width,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(3),
                                      ),
                                      child: Material(
                                        borderRadius: BorderRadius.circular(3),
                                        color: Color(0xFF800020),
                                        child: MaterialButton(
                                            child: Text(
                                              'Login',
                                              textAlign: TextAlign.center,
                                              style: TextStyle(
                                                  color: Colors.white,
                                                  fontSize: 15),
                                            ),
                                            onPressed: () {
                                              if (_formKey.currentState!
                                                  .validate()) {
                                                ScaffoldMessenger.of(context)
                                                    .showSnackBar(
                                                  const SnackBar(
                                                      content: Text(
                                                          'Loging into Office...')),
                                                );

                                                login();
                                              }
                                            }),
                                      ),
                                    )
                                  ],
                                ),
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 30),
                                child: Column(
                                  children: [
                                    Container(
                                      width: MediaQuery.of(context).size.width,
                                      child: SignInButton(
                                        Buttons.FacebookNew,
                                        text: 'Sign Up with Facebook',
                                        onPressed: () {},
                                      ),
                                    ),
                                    SizedBox(
                                      height: 10,
                                    ),
                                    Container(
                                      width: MediaQuery.of(context).size.width,
                                      child: SignInButton(
                                        Buttons.GoogleDark,
                                        text: 'Sign Up with Google',
                                        onPressed: () {},
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    'Dont have an account',
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                      color: Color.fromARGB(225, 253, 253, 253),
                                      fontWeight: FontWeight.bold,
                                      fontSize: 15,
                                    ),
                                  ),
                                  MaterialButton(
                                      child: Text(
                                        'Sign Up',
                                        textAlign: TextAlign.start,
                                        style: TextStyle(
                                            color:
                                                Color.fromARGB(255, 199, 45, 7),
                                            fontSize: 15),
                                      ),
                                      onPressed: signUP)
                                ],
                              )
                            ]),
                      )),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  AppBar _getAppBar() {
    return AppBar(
        backgroundColor: Color.fromARGB(255, 17, 16, 16),
        elevation: 0,
        title: Row(
    children: [
      Image.asset(
        "assets/images/logo.jpeg",
        fit: BoxFit.contain,
        height: 50,
        width: 50,
      ),
    ],
  ));
  }


 
  signUP() {
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => SignUpPage()));
  }

  myDashboard() {
    Navigator.pushReplacement(
        context, MaterialPageRoute(builder: (context) => Home()));
  }

  Future<dynamic> login() async {
    // debugPrint("login users hit");
    try {
      final response =
          await dio.post("/service/user/login", data: loginModel.toJson());
      if (response.statusCode == 200) {
        SharedPreferences prefs = await SharedPreferences.getInstance();
        prefs.setBool('isLoggedIn', true);
        prefs.setString('userId', response.data['email']);
        prefs.setString('token', response.data['token']);
        myDashboard();
        // return decoded;
      } else {
        throw Exception();
      }
    } on SocketException catch (e) {
      debugPrint("eSocket = " + e.toString());
      throw Exception(e);
    } catch (e) {
      debugPrint("e = " + e.toString());
      throw Exception(e);
    }
  }
}
