import 'package:flutter/material.dart';
import 'package:freelancerflutter/screens/myoffredetails.dart';

class MyOffreWidget extends StatelessWidget {
  late String id;
  late String UserId;
  late String subject;
  late String description;
  late String Price;
  late String Status;
  late String Time;
  late String imageClient;
  late String UserIdAccept;
  MyOffreWidget(this.id, this.UserId, this.subject, this.description,
      this.Price, this.Status, this.Time, this.imageClient, this.UserIdAccept);
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => {
        Navigator.of(context).push(
          MaterialPageRoute<void>(
            builder: (BuildContext context) => MMyoffreDetails(
                id,
                UserId,
                subject,
                description,
                Price,
                Status,
                Time,
                imageClient,
                UserIdAccept),
          ),
        )
      },
      child: Card(
        color: Status == "true" ? Color.fromARGB(255, 163, 255, 166) : Color.fromARGB(255, 245, 131, 122),
        child: ListTile(
            title: Text(subject),
            subtitle: Text(" description"),
            leading: CircleAvatar(
              backgroundImage: imageClient == "assets/images/account.png"
                  ? AssetImage(imageClient)
                  : NetworkImage("http://10.0.2.2:3000/uploads/" +
                      imageClient.substring(8)) as ImageProvider,
            )),
      ),
    );
  }
}
