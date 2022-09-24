import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:freelancerflutter/screens/updateprofilescreen.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:freelancerflutter/screens/signupscreen.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import '../constant.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  late String nom;
  late String email;
  late String phone;
  late String imageUrl;
late String id;
  late Future<bool> fetchedprofile;

  File? image;
  Future pickImage() async {
    try {
      final image = await ImagePicker().pickImage(source: ImageSource.gallery);
      if (image == null) return;
      final imageTemporary = File(image.path);
      
      print(image.path);
      setState(() => this.image = imageTemporary);
      updateimage();
    } on PlatformException catch (e) {
      print('Failed to pick image: $e');
    }
  }

  void updateimage() async {
    //create multipart request for POST or PATCH method
   
  var request =
        http.MultipartRequest("POST", Uri.http(baseUrl, "/updateImageClient/"+id));
   
    var pic = await http.MultipartFile.fromPath("Image", image!.path);
    //add multipart to request
    request.files.add(pic);
    var response = await request.send();

    //Get the response from the server
    var responseData = await response.stream.toBytes();
    var responseString = String.fromCharCodes(responseData);
    Map<String, dynamic> userData =
                                            json.decode(responseString);
      SharedPreferences prefs =
                                            await SharedPreferences
                                                .getInstance();
                                                 
                        prefs.setString("imageUrl", userData["imageUrl"]);
   print(responseString);

  }

  String state = "";
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
  void initState() {
    // TODO: implement initState

    fetchedprofile = Fetchedprofile();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: fetchedprofile,
        builder: (context, AsyncSnapshot<bool> snapshot) {
          if (snapshot.hasData) {
            return Stack(
              children: [
                Image.asset(
                  "assets/images/background.png",
                  height: MediaQuery.of(context).size.height,
                  width: MediaQuery.of(context).size.width,
                  fit: BoxFit.cover,
                ),
                Scaffold(
                  appBar: AppBar(
                     automaticallyImplyLeading: false,
                    title: Text("Profile"),
                    actions: [
                      IconButton(
                        icon: Icon(Icons.update_outlined),
                        onPressed: () => {
                          Navigator.of(context).push(
                            MaterialPageRoute<void>(
                              builder: (BuildContext context) =>
                                  UpdateProfile(),
                            ),
                          )
                        },
                      ),
                    ],
                  ),
                  backgroundColor: Colors.transparent,
                  body: SingleChildScrollView(

                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(140),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey.withOpacity(0.5),
                                spreadRadius: 10,
                                blurRadius: 5,
                                offset: Offset(0, 3),
                              ),
                            ],
                          ),
                          child: InkWell(
                            onTap: (() async {
                             
                              setState(() {
                                
                               pickImage();
                              });
                            }),
                            child: CircleAvatar(
                              radius: 70,
                              backgroundImage:
                                  imageUrl == "assets/images/account.png"
                                      ? AssetImage(imageUrl)
                                      : NetworkImage("http://10.0.2.2:3000/uploads/"+imageUrl.substring(8)) as ImageProvider,
                            ),
                          ),
                        ),
                       SizedBox(
                          height: 20,
                        ),
                        Text(
                          nom,
                          style: TextStyle(
                              fontSize: 50, fontWeight: FontWeight.bold),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        Column(
                          mainAxisSize: MainAxisSize.max,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                              Padding(
                                                padding:
                                                    const EdgeInsetsDirectional
                                                        .fromSTEB(20, 20, 20, 12),
                                                child: TextFormField(
                                                  initialValue: nom,
                                                 
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
                                  
                             Padding(
                                                padding:
                                                    const EdgeInsetsDirectional
                                                        .fromSTEB(20, 20, 20, 12),
                                                child: TextFormField(
                                                  initialValue: email,
                                                 
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
                                                        .fromSTEB(20, 20, 20, 12),
                                                child: TextFormField(
                                                  initialValue: phone,
                                                 
                                                  // ignore: body_might_complete_normally_nullable
                                                  validator: (String? value) {
                                                    if (value!.isEmpty) {
                                                      return " your Number";
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
                                                    labelText: 'Your Number ...',
                                                    labelStyle: TextStyle(
                                                      fontFamily: 'Lexend Deca',
                                                      color: Color(0xFF57636C),
                                                      fontSize: 14,
                                                      fontWeight:
                                                          FontWeight.normal,
                                                    ),
                                                    hintText:
                                                        'your Number...',
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
                      ],
                    ),
                  ),
                )
              ],
            );
          } else {
            return const Center(
                child: CircularProgressIndicator(
              //the futurebuilder always shows this widget
              color: Colors.blue,
            ));
          }
        });
  }
}
