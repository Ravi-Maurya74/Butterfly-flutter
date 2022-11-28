import 'package:flutter/material.dart';
import 'package:social_media/widgets/single_following_user.dart';

class FollowingPage extends StatelessWidget {
  FollowingPage(
      {super.key, required this.following, required this.loggedInUserData});
  final List<dynamic> following;
  final dynamic loggedInUserData;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: Text(
        'Following',
        style: TextStyle(
          fontFamily: 'Kalam',
          fontWeight: FontWeight.w700,
          fontSize: 25,
        ),
      )),
      body: ListView.builder(
        itemBuilder: (context, index) {
          return FollowingUser(
            user_id: following[index],
            loggedInUserData: loggedInUserData,
          );
        },
        itemCount: following.length,
      ),
    );
  }
}
