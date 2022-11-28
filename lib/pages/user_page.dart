// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, unnecessary_string_interpolations

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:social_media/helpers/networking.dart';
import 'package:social_media/widgets/post.dart';

class UserPage extends StatefulWidget {
  UserPage({required this.loggedInUserData, required this.data, super.key}) {
    tempDate = DateFormat("yyyy-MM-dd").parse(data['dob']);
    following = data['following'];
    followers = data['followers'];
    userPosts = data['user_posts'];
  }
  final dynamic data;
  final dynamic loggedInUserData;
  late DateTime tempDate;
  late List<dynamic> following;
  late List<dynamic> followers;
  late List<dynamic> userPosts;

  @override
  State<UserPage> createState() => _UserPageState();
}

class _UserPageState extends State<UserPage> {
  void delete(int index) {
    setState(() {
      widget.userPosts.removeAt(index);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: AnnotatedRegion<SystemUiOverlayStyle>(
        value: SystemUiOverlayStyle.dark
            .copyWith(statusBarColor: Theme.of(context).primaryColor),
        child: SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              UserPageHeader(
                data: widget.data,
                tempDate: widget.tempDate,
                following: widget.following,
                followers: widget.followers,
                loggedInUserData: widget.loggedInUserData,
              ),
              Expanded(
                child: ListView.builder(
                  itemBuilder: (context, index) {
                    return Post(
                      key: UniqueKey(),
                      index: widget.userPosts[index],
                      loggedInUserData: widget.loggedInUserData,
                      isOnUserPage: true,
                      deleteupdate: () {
                        delete(index);
                      },
                    );
                  },
                  itemCount: widget.userPosts.length,
                  cacheExtent: 1500,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class UserPageHeader extends StatefulWidget {
  UserPageHeader(
      {Key? key,
      required this.data,
      required this.tempDate,
      required this.following,
      required this.followers,
      required this.loggedInUserData})
      : super(key: key);

  dynamic data;
  dynamic loggedInUserData;
  final DateTime tempDate;
  final List following;
  final List followers;

  @override
  State<UserPageHeader> createState() => _UserPageHeaderState();
}

class _UserPageHeaderState extends State<UserPageHeader> {
  late String follow_text;
  late dynamic temploggedInUserData;
  late dynamic tempdata;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    tempdata = widget.data;
    temploggedInUserData = widget.loggedInUserData;
    follow_text = temploggedInUserData['following'].contains(tempdata['id'])
        ? 'Following'
        : 'Follow';
  }

  void updateState() async {
    tempdata =
        await NetworkHelper(url: 'api/detail/${tempdata['id']}').getData();
    temploggedInUserData =
        await NetworkHelper(url: 'api/detail/${temploggedInUserData['id']}')
            .getData();
    follow_text = temploggedInUserData['following'].contains(tempdata['id'])
        ? 'Following'
        : 'Follow';
    setState(() {
      tempdata;
      temploggedInUserData;
      follow_text;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      // height: MediaQuery.of(context).size.height * 0.25,
      decoration: BoxDecoration(color: Theme.of(context).primaryColor),
      padding: EdgeInsets.all(MediaQuery.of(context).size.height * 0.01),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CircleAvatar(
            radius: MediaQuery.of(context).size.height * 0.045,
            child: Icon(
              Icons.person,
              size: MediaQuery.of(context).size.height * 0.046,
            ),
          ),
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.01,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '${widget.data['first_name']} ${widget.data['last_name']}',
                    style: TextStyle(
                        fontSize: MediaQuery.of(context).size.height * 0.03,
                        fontFamily: 'Patrick'),
                  ),
                  Text(
                    '${widget.data['user_email']}',
                    style: TextStyle(
                        fontSize: MediaQuery.of(context).size.height * 0.02,
                        color: Colors.black54,
                        fontFamily: 'Kalam'),
                  ),
                ],
              ),
              Container(
                child: tempdata['id'] == temploggedInUserData['id']
                    ? null
                    : ElevatedButton(
                        onPressed: (() async {
                          if (follow_text == 'Follow') {
                            await NetworkHelper(url: '').followUser(
                                temploggedInUserData['id'], tempdata['id']);
                          } else {
                            await NetworkHelper(url: '').unfollowUser(
                                temploggedInUserData['id'], tempdata['id']);
                          }
                          updateState();
                        }),
                        child: Text(follow_text),
                      ),
              )
            ],
          ),
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.01,
          ),
          Row(
            children: [
              Icon(Icons.celebration),
              SizedBox(
                width: MediaQuery.of(context).size.height * 0.005,
              ),
              Text(
                '${DateFormat.yMMMMd('en_US').format(widget.tempDate)}',
                style: TextStyle(
                    fontSize: MediaQuery.of(context).size.height * 0.02,
                    color: Colors.black54,
                    fontFamily: 'Kalam'),
              ),
            ],
          ),
          Row(
            children: [
              Text(
                '${widget.following.length}',
                style: TextStyle(
                    fontSize: MediaQuery.of(context).size.height * 0.025,
                    fontFamily: 'Kalam'),
              ),
              SizedBox(
                width: MediaQuery.of(context).size.height * 0.005,
              ),
              Text(
                'Following',
                style: TextStyle(
                    fontSize: MediaQuery.of(context).size.height * 0.02,
                    color: Colors.black54,
                    fontFamily: 'Kalam'),
              ),
              SizedBox(
                width: MediaQuery.of(context).size.width * 0.1,
              ),
              Text(
                '${widget.followers.length}',
                style: TextStyle(
                    fontSize: MediaQuery.of(context).size.height * 0.025),
              ),
              SizedBox(
                width: MediaQuery.of(context).size.height * 0.005,
              ),
              Text(
                'Followers',
                style: TextStyle(
                    fontSize: MediaQuery.of(context).size.height * 0.02,
                    color: Colors.black54,
                    fontFamily: 'Kalam'),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
