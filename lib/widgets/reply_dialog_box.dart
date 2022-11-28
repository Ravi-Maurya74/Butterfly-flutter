// ignore_for_file: prefer_const_constructors, non_constant_identifier_names

import 'package:flutter/material.dart';
import 'package:ndialog/ndialog.dart';
import 'package:social_media/helpers/networking.dart';

void ShowReplyDialogBox(
    BuildContext context, int post_id, Function refresh, int replier_id) {
  TextEditingController controller = TextEditingController();
  NDialog(
    dialogStyle: DialogStyle(titleDivider: true),
    title: Text('Post reply'),
    content: TextField(
      autofocus: true,
      decoration:
          InputDecoration(labelText: 'Reply', hintText: 'Reply content'),
      controller: controller,
    ),
    actions: [
      Padding(
        padding: const EdgeInsets.all(15.0),
        child: ElevatedButton(
            style: ButtonStyle(
              backgroundColor: MaterialStateProperty.all<Color>(
                  Theme.of(context).primaryColor),
            ),
            child: Text("Reply"),
            onPressed: () async {
              await NetworkHelper(url: '')
                  .sendReply(post_id, controller.text, replier_id);
              await refresh();
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
