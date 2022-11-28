// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:social_media/helpers/networking.dart';
import 'package:social_media/widgets/post.dart';

class HomePostPage extends StatefulWidget {
  HomePostPage(
      {required this.loggedInUserData,
      required this.following,
      required this.refresh,
      super.key}) {
    print('second last $following');
  }
  dynamic following;
  dynamic loggedInUserData;
  Function refresh;

  @override
  State<HomePostPage> createState() => _HomePostPageState();
}

class _HomePostPageState extends State<HomePostPage> {
  late List<dynamic> allPostData;
  bool hasAllPostData = false;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    doAsyncStuff();
  }

  Future<void> doAsyncStuff() async {
    print('last ${widget.following}');
    allPostData =
        await NetworkHelper(url: '').getHomePagePosts(widget.following);
    setState(() {
      hasAllPostData = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: hasAllPostData == false
          ? Center(
              child: CircularProgressIndicator(),
            )
          : RefreshIndicator(
              onRefresh: () async {
                await widget.refresh();
                allPostData = await NetworkHelper(url: '')
                    .getHomePagePosts(widget.following);
                setState(() {
                  allPostData;
                });
              },
              child: ListView.builder(
                itemBuilder: (context, index) {
                  Map<String, dynamic> map = allPostData[index];
                  print(map);
                  return Post(
                    key: UniqueKey(),
                    index: map['id'],
                    loggedInUserData: widget.loggedInUserData,
                    isOnUserPage: false,
                    deleteupdate: () {},
                  );
                },
                itemCount: allPostData.length,
                cacheExtent: 1500,
              ),
            ),
    );
  }
}
