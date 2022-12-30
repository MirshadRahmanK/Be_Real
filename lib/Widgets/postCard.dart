import 'package:be_real/Screens/followScreen.dart';
import 'package:be_real/Widgets/subtitleTxt.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

class PostCard extends StatelessWidget {

  String name;
  String place;
  String hrs;
  String profile;
  String imageUrl;
  PostCard(
      {required this.name,
   
      required this.place,
      required this.hrs,
      required this.profile,
      required this.imageUrl});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        GestureDetector(
          onTap: () {
            Navigator.of(context).push(MaterialPageRoute(builder: (context) {
              return FollowScreen();
            }));
          },
          child: ListTile(
            trailing: IconButton(
                onPressed: () {},
                icon: Icon(
                  Icons.more_horiz,
                  color: Colors.grey,
                )),
            subtitle: Row(
              children: [
                SubtittleTXT(txt: '$place'),
                SubtittleTXT(txt: ' . '),
                SubtittleTXT(txt: '$hrs hrs late  '),
                Icon(
                  Icons.public,
                  color: Colors.grey,
                  size: 20,
                )
              ],
            ),
            title: Text(
              "$name",
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 20,
                  fontWeight: FontWeight.w700),
            ),
            leading: CircleAvatar(
              backgroundImage: NetworkImage('$profile'),
            ),
          ),
        ),
        Padding(
          padding: EdgeInsets.all(8.0),
          child: ClipRRect(
            borderRadius: BorderRadius.all(Radius.circular(20)),
            child: Image(
              height: 450,
              width: MediaQuery.of(context).size.width,
              image: NetworkImage('$imageUrl'),
              fit: BoxFit.cover,
            ),
          ),
        )
      ],
    );
  }
}
