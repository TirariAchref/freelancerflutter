import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:freelancerflutter/screens/signupscreen.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import '../constant.dart';
class AddOfffre extends StatefulWidget {
  const AddOfffre({ Key? key }) : super(key: key);

  @override
  State<AddOfffre> createState() => _AddOfffreState();
}

class _AddOfffreState extends State<AddOfffre> {

   late TextEditingController subjectController;
  late TextEditingController descriptionController;
late TextEditingController priceController;
late TextEditingController timeController;
    late String? _subject;

  late String? _description;
     late String? _price;

  late String? _time;
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
imageUrl = prefs.getString("imageUrl")!;
     return true;
  }
  @override
  void initState() {
    fetchedprofile= Fetchedprofile();
    subjectController = TextEditingController();
    timeController = TextEditingController();
     priceController = TextEditingController();
    descriptionController = TextEditingController();
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
                title: Text("Add Offre"),
              
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
                                        'Add Offre',
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
                                          _subject = text;
                                        },
                                        // ignore: body_might_complete_normally_nullable
                                        validator: (String? value) {
                                          if (value!.isEmpty) {
                                            return "Please Put your Subject";
                                          
                                          }
                                        },
                                        controller: subjectController,
                                        obscureText: false,
                                        decoration: InputDecoration(
                                          labelText: 'Your Subject ...',
                                          labelStyle: TextStyle(
                                            fontFamily: 'Lexend Deca',
                                            color: Color(0xFF57636C),
                                            fontSize: 14,
                                            fontWeight: FontWeight.normal,
                                          ),
                                          hintText: 'Enter your Subject...',
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
                                          _description = text;
                                        },
                                        // ignore: body_might_complete_normally_nullable
                                        validator: (String? value) {
                                          if (value!.isEmpty) {
                                            return "Please Put your Description";
                                          
                                          }
                                        },
                                        controller: descriptionController,
                                        obscureText: false,
                                        decoration: InputDecoration(
                                          labelText: 'Your description ...',
                                          labelStyle: TextStyle(
                                            fontFamily: 'Lexend Deca',
                                            color: Color(0xFF57636C),
                                            fontSize: 14,
                                            fontWeight: FontWeight.normal,
                                          ),
                                          hintText: 'Enter your description...',
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
                                        keyboardType: TextInputType.number,
                                        onSaved: (text) {
                                          _price = text;
                                        },
                                        // ignore: body_might_complete_normally_nullable
                                        validator: (String? value) {
                                          if (value!.isEmpty) {
                                            return "Please Put your Price";
                                          
                                          }
                                        },
                                        controller: priceController,
                                        obscureText: false,
                                        decoration: InputDecoration(
                                          labelText: 'Your Price ...',
                                          labelStyle: TextStyle(
                                            fontFamily: 'Lexend Deca',
                                            color: Color(0xFF57636C),
                                            fontSize: 14,
                                            fontWeight: FontWeight.normal,
                                          ),
                                          hintText: 'Enter your price...',
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
                                        keyboardType: TextInputType.number,
                                        onSaved: (text) {
                                          _time = text;
                                        },
                                        // ignore: body_might_complete_normally_nullable
                                        validator: (String? value) {
                                          if (value!.isEmpty) {
                                            return "Please Put your Time in days";
                                          
                                          }
                                        },
                                        controller: timeController,
                                        obscureText: false,
                                        decoration: InputDecoration(
                                          labelText: 'Your Time in days ...',
                                          labelStyle: TextStyle(
                                            fontFamily: 'Lexend Deca',
                                            color: Color(0xFF57636C),
                                            fontSize: 14,
                                            fontWeight: FontWeight.normal,
                                          ),
                                          hintText: 'Enter your time...',
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
                                    _time=_time!+" Days";
                                    _price=_price!+" DT";


                                    Map<String, dynamic> userData = {

                                      "UserId": id  ,
                                      "subject": _subject,
                                      "description": _description,
                                       "Price": _price  ,
                                      "Status": "false",
                                      "Time": _time,
                                      "imageClient": imageUrl,
                                      "UserIdAccept": "",
                                    
                                    };
                                    print(userData);

                                    Map<String, String> headers = {
                                      "Content-Type":
                                          "application/json; charset=UTF-8"
                                    };

                                    http
                                        .post(Uri.http(baseUrl, "/createoffre"),
                                            headers: headers,
                                            body: json.encode(userData))
                                        .then((http.Response response) async {
                                      if (response.statusCode == 200) {
                                        Map<String, dynamic> userData =
                                            json.decode(response.body);

                                       

                                        showDialog(
                                          context: context,
                                          builder: (BuildContext context) {
                                            return const AlertDialog(
                                              title: Text("Offre Added"),
                                              content: Text(
                                                  "Offre Added Successfully!"),
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
                                                  "Error add !"),
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
                                                  "Error add  !"),
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
                                      'Add Offre',
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