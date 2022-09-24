import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:freelancerflutter/constant.dart';
import 'package:freelancerflutter/screens/root.dart';

import 'package:freelancerflutter/screens/signupscreen.dart';
import 'package:freelancerflutter/screens/updatepass.dart';
import 'package:freelancerflutter/screens/verificationcoode.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class AccountFouand extends StatefulWidget {
  const AccountFouand({Key? key}) : super(key: key);

  @override
  State<AccountFouand> createState() => _AccountFouandState();
}

class _AccountFouandState extends State<AccountFouand> {
  late String nom;
  late String email;
  late String phone;
  late String imageUrl;
  late String id;
  late Future<bool> fetchedprofile;
  late TextEditingController emailAddressController;
  late TextEditingController passwordController;
  late bool passwordVisibility;
  late String? _email;

  late String? _password;

  final GlobalKey<FormState> _keyForm = GlobalKey<FormState>();
  @override
  void initState() {
    super.initState();

    fetchedprofile = Fetchedprofile();
    super.initState();
    emailAddressController = TextEditingController();
    passwordController = TextEditingController();
    passwordVisibility = false;
  }

  Future<bool> Fetchedprofile() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    nom = prefs.getString("nom")!;
    email = prefs.getString("email")!;
    phone = prefs.getString("phone")!;
    imageUrl = prefs.getString("imageUrl")!;
    id = prefs.getString("_id")!;
    print(imageUrl);
    return true;
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        Image.asset(
          "assets/images/background.png",
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          fit: BoxFit.cover,
        ),
        FutureBuilder(
            future: fetchedprofile,
            builder: (context, AsyncSnapshot<bool> snapshot) {
              if (snapshot.hasData) {
                return Scaffold(
                    backgroundColor: Colors.transparent,
                    appBar: AppBar(
                      title: Text('Find My Account'),
                      elevation: 0.0,
                    ),
                    body: Form(
                        key: _keyForm,
                        child: SafeArea(
                            child: SingleChildScrollView(
                          child: Container(
                            height: MediaQuery.of(context).size.height,
                            child: Column(
                              mainAxisSize: MainAxisSize.max,
                              children: [
                                Padding(
                                  padding: const EdgeInsetsDirectional.fromSTEB(
                                      24, 24, 24, 24),
                                  child: Column(
                                    mainAxisSize: MainAxisSize.max,
                                    children: [
                                      Center(
                                        child: Column(
                                          children: [
                                            const Padding(
                                              padding: EdgeInsets.fromLTRB(
                                                  0, 100, 0, 0),
                                              child: Text(
                                                'My Account',
                                                style: TextStyle(
                                                  fontFamily: 'Lexend Deca',
                                                  color: Color.fromARGB(
                                                      255, 0, 153, 255),
                                                  fontSize: 28,
                                                  fontWeight: FontWeight.bold,
                                                ),
                                              ),
                                            ),
                                            CircleAvatar(
                                              radius: 70,
                                              backgroundImage: imageUrl ==
                                                      "assets/images/account.png"
                                                  ? AssetImage(imageUrl)
                                                  : NetworkImage(
                                                      "http://10.0.2.2:3000/uploads/" +
                                                          imageUrl.substring(
                                                              8)) as ImageProvider,
                                            ),
                                            Padding(
                                              padding:
                                                  const EdgeInsetsDirectional
                                                      .fromSTEB(0, 20, 0, 12),
                                              child: TextFormField(
                                                initialValue: email,
                                                onSaved: (text) {
                                                  _email = text;
                                                },
                                                // ignore: body_might_complete_normally_nullable
                                                validator: (String? value) {
                                                  if (value!.isEmpty) {
                                                    return " your Email";
                                                  } else {
                                                    bool emailValid = RegExp(
                                                            r'^.+@[a-zA-Z]+\.{1}[a-zA-Z]+(\.{0,1}[a-zA-Z]+)$')
                                                        .hasMatch(value);
                                                    if (!emailValid) {
                                                      return "Email not valide";
                                                    }
                                                  }
                                                },
                                                enabled: false,
                                                obscureText: false,
                                                decoration: InputDecoration(
                                                  labelText: 'Your Email ...',
                                                  labelStyle: TextStyle(
                                                    fontFamily: 'Lexend Deca',
                                                    color: Color(0xFF57636C),
                                                    fontSize: 14,
                                                    fontWeight:
                                                        FontWeight.normal,
                                                  ),
                                                  hintText:
                                                      'your Email...',
                                                  hintStyle: TextStyle(
                                                    fontFamily: 'Lexend Deca',
                                                    color: Color(0xFF57636C),
                                                    fontSize: 14,
                                                    fontWeight:
                                                        FontWeight.normal,
                                                  ),
                                                  enabledBorder:
                                                      OutlineInputBorder(
                                                    borderSide: BorderSide(
                                                      color: Color(0xFFDBE2E7),
                                                      width: 2,
                                                    ),
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            8),
                                                  ),
                                                  focusedBorder:
                                                      OutlineInputBorder(
                                                    borderSide: BorderSide(
                                                      color: Color(0xFFDBE2E7),
                                                      width: 2,
                                                    ),
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            8),
                                                  ),
                                                  filled: true,
                                                  fillColor: Colors.white,
                                                  contentPadding:
                                                      EdgeInsetsDirectional
                                                          .fromSTEB(
                                                              24, 24, 20, 24),
                                                ),
                                                style: TextStyle(
                                                  fontFamily: 'Lexend Deca',
                                                  color: Color(0xFF1D2429),
                                                  fontSize: 14,
                                                  fontWeight: FontWeight.normal,
                                                ),
                                              ),
                                            ),
                                          Padding(
                                              padding:
                                                  const EdgeInsetsDirectional
                                                      .fromSTEB(0, 20, 0, 12),
                                              child: TextFormField(
                                                initialValue: nom,
                                                onSaved: (text) {
                                                  _email = text;
                                                },
                                                // ignore: body_might_complete_normally_nullable
                                                validator: (String? value) {
                                                  if (value!.isEmpty) {
                                                    return " your Name";
                                                  } else {
                                                    bool emailValid = RegExp(
                                                            r'^.+@[a-zA-Z]+\.{1}[a-zA-Z]+(\.{0,1}[a-zA-Z]+)$')
                                                        .hasMatch(value);
                                                    if (!emailValid) {
                                                      return "Email not valide";
                                                    }
                                                  }
                                                },
                                                enabled: false,
                                                obscureText: false,
                                                decoration: InputDecoration(
                                                  labelText: 'Your Name ...',
                                                  labelStyle: TextStyle(
                                                    fontFamily: 'Lexend Deca',
                                                    color: Color(0xFF57636C),
                                                    fontSize: 14,
                                                    fontWeight:
                                                        FontWeight.normal,
                                                  ),
                                                  hintText:
                                                      'your Name...',
                                                  hintStyle: TextStyle(
                                                    fontFamily: 'Lexend Deca',
                                                    color: Color(0xFF57636C),
                                                    fontSize: 14,
                                                    fontWeight:
                                                        FontWeight.normal,
                                                  ),
                                                  enabledBorder:
                                                      OutlineInputBorder(
                                                    borderSide: BorderSide(
                                                      color: Color(0xFFDBE2E7),
                                                      width: 2,
                                                    ),
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            8),
                                                  ),
                                                  focusedBorder:
                                                      OutlineInputBorder(
                                                    borderSide: BorderSide(
                                                      color: Color(0xFFDBE2E7),
                                                      width: 2,
                                                    ),
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            8),
                                                  ),
                                                  filled: true,
                                                  fillColor: Colors.white,
                                                  contentPadding:
                                                      EdgeInsetsDirectional
                                                          .fromSTEB(
                                                              24, 24, 20, 24),
                                                ),
                                                style: TextStyle(
                                                  fontFamily: 'Lexend Deca',
                                                  color: Color(0xFF1D2429),
                                                  fontSize: 14,
                                                  fontWeight: FontWeight.normal,
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsetsDirectional.fromSTEB(
                                      24, 0, 24, 0),
                                  child: Row(
                                    mainAxisSize: MainAxisSize.max,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      ElevatedButton(
                                        onPressed: () async {
                                          print("button pressed");
                                          
                                            _keyForm.currentState!.save();
                                             Navigator.of(context).push(
                                          MaterialPageRoute<void>(
                                            builder: (BuildContext context) =>
                                                VerificationCode(),
                                          ),
                                        );

                                           
                                          
                                        },
                                        child: Container(
                                            width: 150,
                                            height: 50,
                                            child: Center(
                                                child: Text(
                                              'Send Code',
                                              style: TextStyle(
                                                fontFamily: 'Lexend Deca',
                                                color: Colors.white,
                                                fontSize: 16,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ))),
                                        style: ElevatedButton.styleFrom(
                                          primary: const Color.fromARGB(
                                              255, 0, 153, 255),
                                          elevation: 3,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ))));
              } else {
                return const Center(
                    child: CircularProgressIndicator(
                  //the futurebuilder always shows this widget
                  color: Colors.blue,
                ));
              }
            })
      ],
    );
  }
}
