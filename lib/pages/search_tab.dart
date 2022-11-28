// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:social_media/helpers/networking.dart';
import 'package:social_media/pages/user_page.dart';

class SearchTab extends StatefulWidget {
  SearchTab({required this.loggedInUserData, super.key});
  dynamic loggedInUserData;

  @override
  State<SearchTab> createState() => _SearchTabState();
}

class _SearchTabState extends State<SearchTab> {
  bool hasData = false;
  List<dynamic>? data = null;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    doAsyncStuff();
  }

  Future<void> doAsyncStuff() async {
    data = await NetworkHelper(url: 'api/getall/').getData();
    setState(() {
      hasData = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: hasData == false
          ? Center(child: CircularProgressIndicator())
          : ListView.builder(
              itemBuilder: (context, index) {
                dynamic current_user = data![index];
                return GestureDetector(
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
                          if (current_user['id'] !=
                              widget.loggedInUserData['id'])
                            {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => UserPage(
                                            data: current_user,
                                            loggedInUserData:
                                                widget.loggedInUserData,
                                          ))),
                            }
                        });
              },
              itemCount: (data!.length),
            ),
    );
  }
}
