import 'dart:convert';
import 'dart:ffi';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:freelancerflutter/constant.dart';
import 'package:freelancerflutter/screens/root.dart';

import 'package:freelancerflutter/screens/signupscreen.dart';
import 'package:freelancerflutter/screens/updatepass.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
class VerificationCode extends StatefulWidget {
  const VerificationCode({ Key? key }) : super(key: key);

  @override
  State<VerificationCode> createState() => _VerificationCodeState();
}

class _VerificationCodeState extends State<VerificationCode> {
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
  late int randomNumber;
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
     randomNumber = Random().nextInt(9999) + 1000; 
    print(randomNumber);
   
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
                      title: Text('Verification Code'),
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
                                                'Verification Code',
                                                style: TextStyle(
                                                  fontFamily: 'Lexend Deca',
                                                  color: Color.fromARGB(
                                                      255, 0, 153, 255),
                                                  fontSize: 28,
                                                  fontWeight: FontWeight.bold,
                                                ),
                                              ),
                                            ),
                                           Padding(
                                              padding:
                                                  const EdgeInsetsDirectional
                                                      .fromSTEB(0, 20, 0, 12),
                                              child: TextFormField(
                                                keyboardType: TextInputType.number,
                                               
                                                onSaved: (text) {
                                                  _email = text;
                                                },
                                                // ignore: body_might_complete_normally_nullable
                                                validator: (String? value) {
                                                  if (value!.isEmpty) {
                                                    return " Put your Code";
                                                  } 
                                                },
                                                controller: emailAddressController,
                                                obscureText: false,
                                                decoration: InputDecoration(
                                                  labelText: 'Your Code ...',
                                                  labelStyle: TextStyle(
                                                    fontFamily: 'Lexend Deca',
                                                    color: Color(0xFF57636C),
                                                    fontSize: 14,
                                                    fontWeight:
                                                        FontWeight.normal,
                                                  ),
                                                  hintText:
                                                      'your Code...',
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
                                          if (_keyForm.currentState!
                                              .validate()) {
                                            _keyForm.currentState!.save();
                                            if(randomNumber == int.parse(_email!)){
                                                Navigator.of(context).push(
                                          MaterialPageRoute<void>(
                                            builder: (BuildContext context) =>
                                                UpdatePass(),
                                          ),
                                        );;
                                            }else{
                                               showDialog(
                                        context: context,
                                        builder: (BuildContext context) {
                                          return const AlertDialog(
                                            title: Text("Information"),
                                            content: Text("Code incorrect !"),
                                          );
                                        },
                                      );


                                            }
                                           

                                           
                                          }
                                        },
                                        child: Container(
                                            width: 150,
                                            height: 50,
                                            child: Center(
                                                child: Text(
                                              'Change Password',
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
