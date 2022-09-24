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

class ProfilDetails extends StatefulWidget {
  const ProfilDetails(this.userid);
final String userid;
  @override
  State<ProfilDetails> createState() => _ProfilDetailsState();
}

class _ProfilDetailsState extends State<ProfilDetails> {
 late String nom;
  late String email;
  late String phone;
  late String imageUrl;
late String id;
  late Future<bool> fetchedprofile;

  
  Future<bool> Fetchedprofile() async {
      http.Response response = await http.get(Uri.http(baseUrl, "/getuser/"+widget.userid));
    var userdata = json.decode(response.body);
   
   nom =userdata["nom"];
email =userdata["email"];
phone =userdata["phone"];

imageUrl =userdata["imageUrl"];
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
                    title: Text("Profile"),
               
                  ),
                  backgroundColor: Colors.transparent,
                  body: Column(
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
                        child: CircleAvatar(
                            radius: 70,
                            backgroundImage:
                                imageUrl == "assets/images/account.png"
                                    ? AssetImage(imageUrl)
                                    : NetworkImage("http://10.0.2.2:3000/uploads/"+imageUrl.substring(8)) as ImageProvider,
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
                          ElevatedButton.icon(
                            icon: Icon(Icons.account_box_outlined),
                            onPressed: () {},
                            style: ButtonStyle(
                              shape: MaterialStateProperty.all<
                                  RoundedRectangleBorder>(
                                RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(50),
                                ),
                              ),
                              backgroundColor: MaterialStateProperty.all<Color>(
                                  Color.fromARGB(255, 111, 214, 255)),
                              padding: MaterialStateProperty.all(
                                EdgeInsets.symmetric(
                                    vertical: 15, horizontal: 150),
                              ),
                            ),
                            label: Text(
                              nom,
                            ),
                          ),
                          SizedBox(
                            height: 18,
                          ),
                          ElevatedButton.icon(
                            icon: Icon(Icons.email),
                            onPressed: () {},
                            style: ButtonStyle(
                              shape: MaterialStateProperty.all<
                                  RoundedRectangleBorder>(
                                RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(50),
                                ),
                              ),
                              backgroundColor: MaterialStateProperty.all<Color>(
                                  Color.fromARGB(255, 111, 214, 255)),
                              padding: MaterialStateProperty.all(
                                EdgeInsets.symmetric(
                                    vertical: 15, horizontal: 150),
                              ),
                            ),
                            label: Text(
                              email,
                            ),
                          ),
                          SizedBox(
                            height: 18,
                          ),
                          ElevatedButton.icon(
                            icon: Icon(Icons.phone),
                            onPressed: () {},
                            style: ButtonStyle(
                              shape: MaterialStateProperty.all<
                                  RoundedRectangleBorder>(
                                RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(50),
                                ),
                              ),
                              backgroundColor: MaterialStateProperty.all<Color>(
                                  Color.fromARGB(255, 111, 214, 255)),
                              padding: MaterialStateProperty.all(
                                EdgeInsets.symmetric(
                                    vertical: 15, horizontal: 150),
                              ),
                            ),
                            label: Text(
                              phone,
                            ),
                          ),
                          SizedBox(
                            height: 18,
                          ),
                        ],
                      ),
                    ],
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
