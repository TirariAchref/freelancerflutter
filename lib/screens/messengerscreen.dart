import 'package:flutter/material.dart';
import 'package:freelancerflutter/screens/screens.dart';
import 'package:freelancerflutter/screens/select_user_screen.dart';

import '../app.dart';
import 'package:stream_chat_flutter_core/stream_chat_flutter_core.dart';
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

class MessengerScreen extends StatefulWidget {
  const MessengerScreen({Key? key}) : super(key: key);

  @override
  State<MessengerScreen> createState() => _MessengerScreenState();
}

class _MessengerScreenState extends State<MessengerScreen> {
  late String nom;
  late String email;
  late String phone;
  late String imageUrl;
  late String id;
  late Future<bool> fetchedprofile;
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
            return Scaffold(
                body: SelectUserScreen(
              UserId: id,
              UserName: nom,
              UserPhoto: imageUrl,
            ));
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
