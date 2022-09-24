import 'package:flutter/material.dart';
import 'package:qr_flutter/qr_flutter.dart';

class QRCode extends StatelessWidget {
  const QRCode(this.nom, this.email, this.phone);
  final String nom;
  final String email;
  final String phone;

  @override
  Widget build(BuildContext context) {
    final qrKey = GlobalKey();
    String qrData = "name : " + nom + "email : " + email + "phone : " + phone;
    return Stack(
      children: [
        Image.asset(
          "assets/images/background.png",
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          fit: BoxFit.cover,
        ),
        Scaffold(
          backgroundColor: Colors.transparent,
          appBar: AppBar(
            title: Text("QRCode"),
            
            elevation: 0.0,
          ),
          body: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisSize: MainAxisSize.max,
              children: [
                Text(
                        "Your QR Code",
                        style: TextStyle(
                            fontSize: 50, fontWeight: FontWeight.bold),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                RepaintBoundary(
                  key: qrKey,
                  child: QrImage(
                    data: qrData, //This is the part we give data to our QR
                    //  embeddedImage: , You can add your custom image to the center of your QR
                    //  semanticsLabel:'', You can add some info to display when your QR scanned
                    size: 250,
                    backgroundColor: Colors.white,
                    version: QrVersions.auto, //You can also give other versions
                  ),
                )
              ],
            ),
          ),
        )
      ],
    );
  }
}
