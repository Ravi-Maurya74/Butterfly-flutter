import 'package:flutter/material.dart';
import 'package:social_media/widgets/single_following_user.dart';

class FollowersPage extends StatelessWidget {
  FollowersPage({super.key, required this.followers, this.loggedInUserData});
  final List<dynamic> followers;
  final dynamic loggedInUserData;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: Text(
        'Followers',
        style: TextStyle(
          fontFamily: 'Kalam',
          fontWeight: FontWeight.w700,
          fontSize: 25,
        ),
      )),
      body: ListView.builder(
        itemBuilder: (context, index) {
          return FollowingUser(
              user_id: followers[index], loggedInUserData: loggedInUserData);
        },
        itemCount: followers.length,
      ),
    );
  }
}
