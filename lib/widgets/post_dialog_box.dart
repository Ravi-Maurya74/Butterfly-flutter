// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:ndialog/ndialog.dart';
import 'package:social_media/helpers/networking.dart';

void ShowDialogBox(BuildContext context, int user_id, Function afterPost) {
  TextEditingController controller = TextEditingController();
  NDialog(
    dialogStyle: DialogStyle(titleDivider: true),
    title: Text("Create Post"),
    content: TextField(
      autofocus: true,
      decoration: InputDecoration(
          labelText: 'Post', hintText: 'Enter you post content'),
      controller: controller,
    ),
    actions: <Widget>[
      Padding(
        padding: const EdgeInsets.all(15.0),
        child: ElevatedButton(
            style: ButtonStyle(
              backgroundColor: MaterialStateProperty.all<Color>(
                  Theme.of(context).primaryColor),
            ),
            child: Text("Post"),
            onPressed: () {
              NetworkHelper(url: '').createPost(user_id, controller.text);
              afterPost();
              Navigator.pop(context);
            }),
      ),
      Padding(
        padding: const EdgeInsets.all(15.0),
        child: ElevatedButton(
            style: ButtonStyle(
              backgroundColor: MaterialStateProperty.all<Color>(
                  Theme.of(context).primaryColor),
            ),
            child: Text("Close"),
            onPressed: () => Navigator.pop(context)),
      ),
    ],
  ).show(context);
}
