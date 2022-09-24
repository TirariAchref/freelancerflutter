import 'package:flutter/material.dart';
import 'package:freelancerflutter/screens/loginscreen.dart';
import 'package:freelancerflutter/screens/mylistscreen.dart';
import 'package:freelancerflutter/screens/qrcode.dart';
import 'package:freelancerflutter/screens/updatepass.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../setting_item.dart';

class MenuScreen extends StatefulWidget {
  const MenuScreen({Key? key}) : super(key: key);

  @override
  State<MenuScreen> createState() => _MenuScreenState();
}

class _MenuScreenState extends State<MenuScreen> {
  late String nom;
  late String email;
  late String phone;
  late String imageUrl;
  late Future<bool> fetchedprofile;

  Future<bool> Fetchedprofile() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    nom = prefs.getString("nom")!;
    email = prefs.getString("email")!;
    phone = prefs.getString("phone")!;
    imageUrl = prefs.getString("imageUrl")!;

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
                    title: const Text(
                      "Menu",
                    ),
                  ),
                  body: Container(
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: AssetImage('assets/images/background.png'),
                        fit: BoxFit.cover,
                      ),
                    ),
                    child: Column(
                      children: [
                        Padding(
                          padding: EdgeInsets.fromLTRB(100, 30, 100, 30),
                          child: Container(
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
                              onTap: (() async {}),
                              child: CircleAvatar(
                                radius: 70,
                                backgroundImage: imageUrl ==
                                        "assets/images/account.png"
                                    ? AssetImage(imageUrl)
                                    : NetworkImage(
                                            "http://10.0.2.2:3000/uploads/" +
                                                imageUrl.substring(8))
                                        as ImageProvider,
                              ),
                            ),
                          ),
                        ),
                        Text(nom,
                            textScaleFactor: 2,
                            style: TextStyle(color: Colors.black, fontSize: 6)),
                        SizedBox(
                          height: 30,
                        ),
                        Container(
                          padding: const EdgeInsets.only(left: 15, right: 15),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(5),
                            color: Colors.white,
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black87.withOpacity(0.1),
                                spreadRadius: 1,
                                blurRadius: 1,
                                offset:
                                    Offset(0, 1), // changes position of shadow
                              ),
                            ],
                          ),
                          child: Column(children: [
                            SettingItem(
                              title: "Update Password",
                              leadingIcon: "assets/icons/shield.svg",
                              bgIconColor: Colors.blue,
                              onTap: () {
                                Navigator.of(context).push(
                                  MaterialPageRoute<void>(
                                    builder: (BuildContext context) =>
                                        UpdatePass(),
                                  ),
                                );
                              },
                            ),
                            SettingItem(
                              title: "My Offres",
                              leadingIcon: "assets/icons/bookmark.svg",
                              bgIconColor: Colors.purple,
                              onTap: () {
                                Navigator.of(context).push(
                                  MaterialPageRoute<void>(
                                    builder: (BuildContext context) =>
                                        ListScreen(),
                                  ),
                                );
                              },
                            ),
                            Padding(
                              padding: const EdgeInsets.only(left: 45),
                              child: Divider(
                                height: 0,
                                color: Colors.grey.withOpacity(0.8),
                              ),
                            ),
                            SettingItem(
                              title: "QR Code",
                              leadingIcon: "assets/icons/send.svg",
                              bgIconColor: Colors.orange,
                              onTap: () {
                                  Navigator.of(context).push(
                                  MaterialPageRoute<void>(
                                    builder: (BuildContext context) =>
                                        QRCode(
                                          nom,
                                          email,
                                          phone
                                        ),
                                  ),
                                );
                              },
                            ),
                          ]),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        Container(
                          padding: const EdgeInsets.only(left: 15, right: 15),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(5),
                            color: Colors.white,
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black87.withOpacity(0.1),
                                spreadRadius: 1,
                                blurRadius: 1,
                                offset:
                                    Offset(0, 1), // changes position of shadow
                              ),
                            ],
                          ),
                          child: Column(children: [
                            SettingItem(
                              title: "Log Out",
                              leadingIcon: "assets/icons/logout.svg",
                              bgIconColor: Colors.black,
                              onTap: () async {
                                Navigator.pushReplacement(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => LoginScreen()),
                                );
                              },
                            ),
                          ]),
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
