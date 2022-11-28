// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:social_media/helpers/networking.dart';
import 'dart:math';
import 'package:social_media/widgets/reply_dialog_box.dart';
import 'package:social_media/widgets/single_reply.dart';

class RepliesPage extends StatefulWidget {
  const RepliesPage(
      {super.key,
      required this.postData,
      required this.userdata,
      required this.loggedInUserData});
  final dynamic postData, userdata, loggedInUserData;

  @override
  State<RepliesPage> createState() => _RepliesPageState();
}

class _RepliesPageState extends State<RepliesPage> {
  bool hasreplies = false;
  late dynamic replies;

  Future<void> doAsyncStuff() async {
    setState(() {
      hasreplies = false;
    });
    replies = await NetworkHelper(url: '').getReplies(widget.postData['id']);
    setState(() {
      hasreplies = true;
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
    return Scaffold(
      appBar: AppBar(
        centerTitle: false,
        title: Column(
          children: [
            Text(
              '${widget.userdata['first_name']} ${widget.userdata['last_name']} posted:',
              style: TextStyle(fontSize: 22, fontFamily: 'Kalam'),
            ),
            Text(
              '${(widget.postData['content'] as String).substring(0, min((widget.postData['content'] as String).length, 30))}...',
              style: TextStyle(fontSize: 15, fontFamily: 'Kalam'),
            ),
          ],
        ),
        // flexibleSpace: Text(widget.postData['content']),
      ),
      body: !hasreplies
          ? Center(
              child: CircularProgressIndicator(),
            )
          : ListView.builder(
              itemBuilder: (context, index) {
                return SingleReply(
                  reply: replies[index],
                );
              },
              itemCount: (replies as List).length,
            ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          ShowReplyDialogBox(context, widget.postData['id'], doAsyncStuff,
              widget.loggedInUserData['id']);
        },
        child: Icon(Icons.message),
      ),
    );
  }
}
