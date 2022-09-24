import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:freelancerflutter/widgets/offrewidget.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

import '../constant.dart';
import '../model/offre.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late  List<Offre> offres = [];
final List<Offre> offresnotre =  [];
  late Future<bool> fetchedUserAndMenu;
  late String imageurloffre;

  Future<bool> fetchUserAndMenu() async {
    http.Response response = await http.get(Uri.http(baseUrl, "/alloffre"));
    List<dynamic> menusfromServer = json.decode(response.body);
    for (int i = 0; i < menusfromServer.length; i++) {
     
      if (menusfromServer[i]["Status"] == "false") {
        offresnotre.add(Offre(
            menusfromServer[i]["_id"].toString(),
            menusfromServer[i]["UserId"].toString(),
            menusfromServer[i]["subject"],
            menusfromServer[i]["description"].toString(),
            menusfromServer[i]["Price"],
            menusfromServer[i]["Status"],
            menusfromServer[i]["Time"].toString(),
           menusfromServer[i]["imageClient"].toString(),
            menusfromServer[i]["UserIdAccept"]));
      }
    }
offres = offresnotre.reversed.toList();


    return true;
  }

  @override
  void initState() {
    fetchedUserAndMenu = fetchUserAndMenu();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: fetchedUserAndMenu,
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
                  title: Text("Home"),
                  
                ),
                backgroundColor: Colors.transparent,
                body: ListView.builder(
                  padding: const EdgeInsets.all(10),
                  itemCount: offres.length,
                  itemBuilder: (context, index) {
                    return OffreWidget(
                        offres[index].id,
                        offres[index].UserId,
                        offres[index].subject,
                        offres[index].description,
                        offres[index].Price,
                        offres[index].Status,
                        offres[index].Time,
                        offres[index].imageClient,
                        offres[index].UserIdAccept);
                  },
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
      },
    );
  }
}
