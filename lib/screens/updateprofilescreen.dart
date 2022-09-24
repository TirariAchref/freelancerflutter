import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:freelancerflutter/screens/root.dart';
import 'package:freelancerflutter/screens/signupscreen.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import '../constant.dart';
class UpdateProfile extends StatefulWidget {
  const UpdateProfile({ Key? key }) : super(key: key);

  @override
  State<UpdateProfile> createState() => _UpdateProfileState();
}

class _UpdateProfileState extends State<UpdateProfile> {
  late TextEditingController emailAddressController;
  late TextEditingController passwordController;

    late String? _email;

  late String? _password;
    final GlobalKey<FormState> _keyForm = GlobalKey<FormState>();
 late String id;
    late String nom;
  late String email;
  late String phone;
  late String imageUrl;

   late Future<bool> fetchedprofile;

  Future<bool> Fetchedprofile() async{
 SharedPreferences prefs = await SharedPreferences.getInstance();
  id = prefs.getString("_id")!;
    nom = prefs.getString("nom")!;
email = prefs.getString("email")!;
phone = prefs.getString("phone")!;

     return true;
  }
  @override
  void initState() {
    fetchedprofile= Fetchedprofile();
    emailAddressController = TextEditingController();
    passwordController = TextEditingController();
    super.initState();
    
   
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
                title: Text("Update Profile"),
              
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
                                        'Update Profile',
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
                                            return "Please Put your name";
                                          
                                          }
                                        },
                                        controller: emailAddressController,
                                        obscureText: false,
                                        decoration: InputDecoration(
                                          labelText: 'Your name ...',
                                          labelStyle: TextStyle(
                                            fontFamily: 'Lexend Deca',
                                            color: Color(0xFF57636C),
                                            fontSize: 14,
                                            fontWeight: FontWeight.normal,
                                          ),
                                          hintText: 'Enter your name...',
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
                                   Padding(
                                      padding:
                                          const EdgeInsetsDirectional.fromSTEB(
                                              0, 20, 0, 12),
                                      child: TextFormField(
                                        onSaved: (text) {
                                          _password = text;
                                        },
                                        // ignore: body_might_complete_normally_nullable
                                        validator: (String? value) {
                                          if (value!.isEmpty) {
                                            return "Please Put your phone";
                                          
                                          }
                                        },
                                        controller: passwordController,
                                        obscureText: false,
                                        decoration: InputDecoration(
                                          labelText: 'Your phone ...',
                                          labelStyle: TextStyle(
                                            fontFamily: 'Lexend Deca',
                                            color: Color(0xFF57636C),
                                            fontSize: 14,
                                            fontWeight: FontWeight.normal,
                                          ),
                                          hintText: 'Enter your phone...',
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

                                    Map<String, dynamic> userData = {

                                      "email": email,
                                      "nom": _email,
                                      "phone": _password,
                                    
                                    };
                                    print(userData);

                                    Map<String, String> headers = {
                                      "Content-Type":
                                          "application/json; charset=UTF-8"
                                    };

                                    http
                                        .put(Uri.http(baseUrl, "/updateuserpass/"+id),
                                            headers: headers,
                                            body: json.encode(userData))
                                        .then((http.Response response) async {
                                      if (response.statusCode == 200) {
                                        Map<String, dynamic> userData =
                                            json.decode(response.body);

                                        // SharedPreferences
                                        SharedPreferences prefs =
                                            await SharedPreferences
                                                .getInstance();
                                               
                     prefs.setString("nom", userData["nom"]);
                      prefs.setString("email", userData["email"]);
                     
                        prefs.setString("phone", userData["phone"]);

                                        showDialog(
                                          context: context,
                                          builder: (BuildContext context) {
                                            return const AlertDialog(
                                              title: Text("Update User"),
                                              content: Text(
                                                  "Username and phone updated !"),
                                            );
                                          },
                                        );
                                      } else if (response.statusCode == 404) {
                                        showDialog(
                                          context: context,
                                          builder: (BuildContext context) {
                                            return const AlertDialog(
                                              title: Text("Information"),
                                              content: Text(
                                                  "Error update !"),
                                            );
                                          },
                                        );
                                      } else if (response.statusCode == 400) {
                                        showDialog(
                                          context: context,
                                          builder: (BuildContext context) {
                                            return const AlertDialog(
                                              title: Text("Information"),
                                              content: Text(
                                                  "Error update  !"),
                                            );
                                          },
                                        );
                                      }
                                    });
                                  }
                                },
                                child: Container(
                                    width: 150,
                                    height: 50,
                                    child: Center(
                                        child: Text(
                                      'Update',
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