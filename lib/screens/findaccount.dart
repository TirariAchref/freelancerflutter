import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:freelancerflutter/constant.dart';
import 'package:freelancerflutter/screens/accountfound.dart';
import 'package:freelancerflutter/screens/root.dart';

import 'package:freelancerflutter/screens/signupscreen.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class FindAcount extends StatefulWidget {
  const FindAcount({Key? key}) : super(key: key);

  @override
  State<FindAcount> createState() => _FindAcountState();
}

class _FindAcountState extends State<FindAcount> {
  late TextEditingController emailAddressController;
  late TextEditingController passwordController;
  late bool passwordVisibility;
  late String? _email;

  late String? _password;

  final GlobalKey<FormState> _keyForm = GlobalKey<FormState>();
  @override
  void initState() {
    super.initState();
    emailAddressController = TextEditingController();
    passwordController = TextEditingController();
    passwordVisibility = false;
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
        Scaffold(
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
                                      padding:
                                          EdgeInsets.fromLTRB(0, 100, 0, 0),
                                      child: Text(
                                        'Find Account',
                                        style: TextStyle(
                                          fontFamily: 'Lexend Deca',
                                          color:
                                              Color.fromARGB(255, 0, 153, 255),
                                          fontSize: 28,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ),
                                    Padding(
                                      padding:
                                          const EdgeInsetsDirectional.fromSTEB(
                                              0, 20, 0, 12),
                                      child: TextFormField(
                                        onSaved: (text) {
                                          _email = text;
                                        },
                                        // ignore: body_might_complete_normally_nullable
                                        validator: (String? value) {
                                          if (value!.isEmpty) {
                                            return "Please Put your Email";
                                          } else {
                                            bool emailValid = RegExp(
                                                    r'^.+@[a-zA-Z]+\.{1}[a-zA-Z]+(\.{0,1}[a-zA-Z]+)$')
                                                .hasMatch(value);
                                            if (!emailValid) {
                                              return "Email not valide";
                                            }
                                          }
                                        },
                                        controller: emailAddressController,
                                        obscureText: false,
                                        decoration: InputDecoration(
                                          labelText: 'Your Email ...',
                                          labelStyle: TextStyle(
                                            fontFamily: 'Lexend Deca',
                                            color: Color(0xFF57636C),
                                            fontSize: 14,
                                            fontWeight: FontWeight.normal,
                                          ),
                                          hintText: 'Enter your Email...',
                                          hintStyle: TextStyle(
                                            fontFamily: 'Lexend Deca',
                                            color: Color(0xFF57636C),
                                            fontSize: 14,
                                            fontWeight: FontWeight.normal,
                                          ),
                                          enabledBorder: OutlineInputBorder(
                                            borderSide: BorderSide(
                                              color: Color(0xFFDBE2E7),
                                              width: 2,
                                            ),
                                            borderRadius:
                                                BorderRadius.circular(8),
                                          ),
                                          focusedBorder: OutlineInputBorder(
                                            borderSide: BorderSide(
                                              color: Color(0xFFDBE2E7),
                                              width: 2,
                                            ),
                                            borderRadius:
                                                BorderRadius.circular(8),
                                          ),
                                          filled: true,
                                          fillColor: Colors.white,
                                          contentPadding:
                                              EdgeInsetsDirectional.fromSTEB(
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
                                  if (_keyForm.currentState!.validate()) {
                                    _keyForm.currentState!.save();

                                    http.Response response = await http.get(
                                        Uri.http(baseUrl,
                                            "/getuserEmail/" + _email!));
                                    List<dynamic> menusfromServer =
                                        json.decode(response.body);
                                    if (menusfromServer.length == 0) {
                                      showDialog(
                                        context: context,
                                        builder: (BuildContext context) {
                                          return const AlertDialog(
                                            title: Text("Information"),
                                            content: Text("email incorrect !"),
                                          );
                                        },
                                      );
                                    }else{
                                    for (int i = 0;
                                        i < menusfromServer.length;
                                        i++) {
                                      // SharedPreferences
                                      SharedPreferences prefs =
                                          await SharedPreferences.getInstance();
                                      prefs.setString("_id",  menusfromServer[i]["_id"]);
                                      prefs.setString("nom",  menusfromServer[i]["nom"]);
                                      prefs.setString(
                                          "email",  menusfromServer[i]["email"]);
                                      prefs.setString(
                                          "password",  menusfromServer[i]["password"]);
                                      prefs.setString(
                                          "phone",  menusfromServer[i]["phone"]);
                                      prefs.setString(
                                          "imageUrl",  menusfromServer[i]["imageUrl"]);
                                          print(menusfromServer[i].toString());
                                       Navigator.of(context).push(
                                          MaterialPageRoute<void>(
                                            builder: (BuildContext context) =>
                                                AccountFouand(),
                                          ),
                                        );;
                                     
                                    }
                                  }}
                                },
                                child: Container(
                                    width: 150,
                                    height: 50,
                                    child: Center(
                                        child: Text(
                                      'Find Account',
                                      style: TextStyle(
                                        fontFamily: 'Lexend Deca',
                                        color: Colors.white,
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ))),
                                style: ElevatedButton.styleFrom(
                                  primary:
                                      const Color.fromARGB(255, 0, 153, 255),
                                  elevation: 3,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ))))
      ],
    );
  }
}
