// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:social_media/helpers/networking.dart';
import 'package:social_media/pages/search_page.dart';

class SearchSheet extends StatefulWidget {
  const SearchSheet({Key? key, required this.loggedInUserData})
      : super(key: key);
  final dynamic loggedInUserData;

  @override
  State<SearchSheet> createState() => _SearchSheetState();
}

class _SearchSheetState extends State<SearchSheet> {
  bool loading = false;
  String searchName = '';
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(20),
                topRight: Radius.circular(20),
              )),
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 15),
                  child: Text(
                    'Search name/id',
                    style: TextStyle(fontSize: 25, fontFamily: 'Kalam'),
                  ),
                ),
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 15, vertical: 5),
                child: TextField(
                  onChanged: (value) {
                    searchName = value;
                  },
                ),
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 15, vertical: 20),
                child: SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () async {
                      setState(() {
                        loading = true;
                      });
                      dynamic data =
                          await NetworkHelper(url: '').searchUser(searchName);
                      setState(() {
                        loading = false;
                      });
                      if (!mounted) return;
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => SearchPage(
                                data: data,
                                loggedInUserData: widget.loggedInUserData),
                          ));
                    },
                    child: Text(
                      'Search',
                      style: TextStyle(fontFamily: 'Kalam', fontSize: 18),
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
        loading
            ? Align(
                child: CircularProgressIndicator(),
                alignment: AlignmentDirectional.topCenter,
              )
            : Container(),
      ],
    );
  }
}
