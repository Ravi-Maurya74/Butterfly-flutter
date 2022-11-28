// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:social_media/pages/followers_page.dart';
import 'package:social_media/pages/following_page.dart';
import 'package:social_media/pages/liked_posts_page.dart';
import 'package:social_media/pages/user_page.dart';

Widget drawerBuilder(BuildContext context, dynamic data) {
  List<dynamic> following = data['following'];
  return Drawer(
    child: LayoutBuilder(
      builder: (p0, p1) => Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          SizedBox(
            height: 0.28 * p1.maxHeight,
            child: DrawerHeader(
              decoration: BoxDecoration(color: Theme.of(context).primaryColor),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CircleAvatar(
                    radius: p1.maxWidth * 0.1,
                    child: IconButton(
                      icon: Icon(Icons.person),
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) =>
                                UserPage(data: data, loggedInUserData: data),
                          ),
                        );
                      },
                    ),
                  ),
                  SizedBox(
                    height: p1.maxHeight * 0.01,
                  ),
                  Text(
                    '${data['first_name']}  ${data['last_name']}',
                    style: TextStyle(
                        fontSize: p1.maxHeight * 0.024, fontFamily: 'Patrick'),
                  ),
                  Text(
                    data['user_email'],
                    style: TextStyle(
                        fontSize: p1.maxHeight * 0.02,
                        color: Colors.black54,
                        fontFamily: 'Patrick'),
                  ),
                  SizedBox(
                    height: p1.maxHeight * 0.02,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text(
                        '${following.length} following',
                        style: TextStyle(fontFamily: 'Patrick'),
                      ),
                      SizedBox(
                        width: p1.maxWidth * 0.08,
                      ),
                      Text(
                        '${(data['followers'] as List).length} followers',
                        style: TextStyle(fontFamily: 'Patrick'),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
          GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) =>
                      UserPage(data: data, loggedInUserData: data),
                ),
              );
            },
            child: ListTile(
              title: Text(
                'Profile',
                style: TextStyle(fontFamily: 'Kalam', fontSize: 20),
              ),
            ),
          ),
          GestureDetector(
            onTap: () => Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) =>
                    FollowingPage(following: following, loggedInUserData: data),
              ),
            ),
            child: ListTile(
              title: Text(
                'Following',
                style: TextStyle(fontFamily: 'Kalam', fontSize: 20),
              ),
            ),
          ),
          GestureDetector(
            onTap: () => Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => FollowersPage(
                      followers: data['followers'], loggedInUserData: data),
                )),
            child: ListTile(
              title: Text(
                'Followers',
                style: TextStyle(fontFamily: 'Kalam', fontSize: 20),
              ),
            ),
          ),
          GestureDetector(
            onTap: () => Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => LikedPosts(loggedInUserData: data),
              ),
            ),
            child: ListTile(
              title: Text(
                'Liked Posts',
                style: TextStyle(fontFamily: 'Kalam', fontSize: 20),
              ),
            ),
          ),
        ],
      ),
    ),
  );
}
