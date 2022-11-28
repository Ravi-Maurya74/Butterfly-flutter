// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, unnecessary_string_interpolations

import 'package:flutter/material.dart';
import 'package:social_media/helpers/networking.dart';
import 'package:intl/intl.dart';
import 'package:social_media/pages/replies_page.dart';
import 'package:social_media/pages/user_page.dart';
import 'package:social_media/widgets/post_icons.dart';

class Post extends StatefulWidget {
  Post(
      {required this.loggedInUserData,
      required this.index,
      required this.isOnUserPage,
      required this.deleteupdate,
      super.key});
  final int index;
  dynamic loggedInUserData;
  bool isOnUserPage;
  Function deleteupdate;

  @override
  State<Post> createState() => _PostState();
}

class _PostState extends State<Post> {
  bool hasPostData = false;
  dynamic postData, userData;
  DateTime? created = null;
  late List<dynamic> liked_by, bookmarked_by;
  bool hasCurrentUserliked = false;
  bool hasCurrentUserBookmarked = false;
  @override
  void initState() {
    super.initState();
    doAsyncStuff();
  }

  Future<void> doAsyncStuff() async {
    postData =
        await NetworkHelper(url: 'api/postdetail/${widget.index}').getData();
    created = DateFormat("yyyy-MM-dd")
        .parse((postData['created'] as String).substring(0, 10));
    // print('dateasdf');
    // print(created);
    liked_by = postData['liked_by'];
    bookmarked_by = postData['bookmarked_by'];
    if (liked_by.contains(widget.loggedInUserData['id'])) {
      hasCurrentUserliked = true;
    } else {
      hasCurrentUserliked = false;
    }

    if (bookmarked_by.contains(widget.loggedInUserData['id'])) {
      hasCurrentUserBookmarked = true;
    } else {
      hasCurrentUserBookmarked = false;
    }

    userData =
        await NetworkHelper(url: 'api/detail/${postData['user_id']}').getData();
    if (mounted) {
      setState(() {
        hasPostData = true;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(10),
      child: hasPostData == false
          ? Center(
              child: CircularProgressIndicator(),
            )
          : Material(
              elevation: 15,
              shadowColor: Theme.of(context).primaryColor,
              borderRadius: BorderRadius.circular(10),
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        GestureDetector(
                          onTap: () {
                            if (!widget.isOnUserPage) {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => UserPage(
                                        loggedInUserData:
                                            widget.loggedInUserData,
                                        data: userData),
                                  ));
                            }
                          },
                          child: Row(
                            children: [
                              CircleAvatar(
                                child: Icon(Icons.person),
                              ),
                              SizedBox(
                                width: 10,
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    '${userData['first_name']} ${userData['last_name']}',
                                    style: TextStyle(
                                        fontSize: 15,
                                        fontFamily: 'Kalam',
                                        fontWeight: FontWeight.w700),
                                  ),
                                  Text(
                                    userData['user_email'],
                                    style: TextStyle(
                                        color: Colors.black54,
                                        fontSize: 10,
                                        fontFamily: 'Kalam'),
                                  ),
                                ],
                              )
                            ],
                          ),
                        ),
                        Container(
                            child: (userData['id'] ==
                                        widget.loggedInUserData['id'] &&
                                    widget.isOnUserPage)
                                ? IconButton(
                                    onPressed: () async {
                                      await NetworkHelper(url: '')
                                          .deletepost(postData['id']);
                                      widget.deleteupdate();
                                    },
                                    icon: Icon(Icons.delete))
                                : null),
                      ],
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Text(
                      postData['content'],
                      textAlign: TextAlign.justify,
                      style: TextStyle(
                          fontSize: 17,
                          fontFamily: 'Kalam',
                          fontWeight: FontWeight.w500),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Column(
                              children: [
                                PostIcon(
                                    iconData: hasCurrentUserliked
                                        ? Icons.favorite
                                        : Icons.favorite_outline_outlined,
                                    onClick: () async {
                                      if (hasCurrentUserliked) {
                                        await NetworkHelper(url: '')
                                            .dislikePost(
                                                widget.loggedInUserData['id'],
                                                postData['id']);
                                      } else {
                                        await NetworkHelper(url: '').likePost(
                                            widget.loggedInUserData['id'],
                                            postData['id']);
                                      }
                                      doAsyncStuff();
                                    }),
                                Text(
                                  '${liked_by.length}',
                                  style: TextStyle(fontFamily: 'Kalam'),
                                ),
                              ],
                            ),
                            Column(
                              children: [
                                PostIcon(
                                    iconData: Icons.message,
                                    onClick: () {
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) => RepliesPage(
                                              postData: postData,
                                              userdata: userData,
                                              loggedInUserData:
                                                  widget.loggedInUserData,
                                            ),
                                          ));
                                    }),
                                Text(
                                  'likes',
                                  style: TextStyle(fontFamily: 'Kalam'),
                                ),
                              ],
                            ),
                            PostIcon(iconData: Icons.share, onClick: () {}),
                            PostIcon(
                                iconData: hasCurrentUserBookmarked
                                    ? Icons.bookmark_added
                                    : Icons.bookmark_add_outlined,
                                onClick: () async {
                                  if (hasCurrentUserBookmarked) {
                                    await NetworkHelper(url: '').unmarkPost(
                                        widget.loggedInUserData['id'],
                                        postData['id']);
                                  } else {
                                    await NetworkHelper(url: '').bookmarkPost(
                                        widget.loggedInUserData['id'],
                                        postData['id']);
                                  }
                                  doAsyncStuff();
                                }),
                          ],
                        ),
                        Text(
                          '${DateFormat.yMMMMd('en_US').format(created!)}',
                          style: TextStyle(fontFamily: 'Kalam'),
                        )
                      ],
                    )
                  ],
                ),
              ),
            ),
    );
  }
}
