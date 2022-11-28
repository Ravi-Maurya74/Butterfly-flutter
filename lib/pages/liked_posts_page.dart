import 'package:flutter/material.dart';
import 'package:social_media/widgets/post.dart';

class LikedPosts extends StatelessWidget {
  LikedPosts({Key? key, required this.loggedInUserData}) : super(key: key);
  final dynamic loggedInUserData;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Liked Posts',
          style: TextStyle(
              fontFamily: 'Kalam', fontSize: 25, fontWeight: FontWeight.w700),
        ),
      ),
      body: ListView.builder(
        itemBuilder: (context, index) {
          return Post(
              key: UniqueKey(),
              loggedInUserData: loggedInUserData,
              index: loggedInUserData['liked_posts'][index],
              isOnUserPage: false,
              deleteupdate: () {});
        },
        itemCount: (loggedInUserData['liked_posts'] as List<dynamic>).length,
      ),
    );
  }
}
