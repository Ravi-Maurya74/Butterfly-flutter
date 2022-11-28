import 'package:flutter/material.dart';
import 'package:social_media/helpers/networking.dart';
import 'package:social_media/pages/user_page.dart';

class FollowingUser extends StatefulWidget {
  FollowingUser(
      {super.key, required this.user_id, required this.loggedInUserData});
  int user_id;
  dynamic loggedInUserData;

  @override
  State<FollowingUser> createState() => _FollowingUserState();
}

class _FollowingUserState extends State<FollowingUser> {
  bool hasData = false;
  dynamic current_user;
  Future<void> doAsyncStuff() async {
    setState(() {
      hasData = false;
    });
    current_user =
        await NetworkHelper(url: 'api/detail/${widget.user_id}').getData();
    setState(() {
      hasData = true;
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    doAsyncStuff();
  }

  @override
  Widget build(BuildContext context) {
    return !hasData
        ? Center(
            child: CircularProgressIndicator(),
          )
        : GestureDetector(
            child: ListTile(
              leading: CircleAvatar(child: Icon(Icons.person)),
              title: Text(
                '${current_user['first_name']} ${current_user['last_name']}',
                style: TextStyle(fontFamily: 'Kalam'),
              ),
              subtitle: Text(
                '${current_user['user_email']}',
                style: TextStyle(fontFamily: 'Kalam'),
              ),
            ),
            onTap: () => {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => UserPage(
                                data: current_user,
                                loggedInUserData: widget.loggedInUserData,
                              ))),
                });
  }
}
