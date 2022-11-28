// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:social_media/pages/bookmark_page.dart';
import 'package:social_media/widgets/post_dialog_box.dart';
import 'package:social_media/widgets/drawerBuilder.dart';
// import 'package:social_media/pages/bottom_navigation_pages.dart';
import 'package:social_media/pages/search_tab.dart';
import 'package:social_media/pages/home_posts_page.dart';
import 'package:social_media/helpers/networking.dart';
import 'package:social_media/widgets/search_sheet.dart';
import 'settings_page.dart';

class HomePage extends StatefulWidget {
  HomePage({required this.data, super.key}) {}
  dynamic data;

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  int _selectedIndex = 0;
  late dynamic stateData;

  late List<Widget?> NavigationPages;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    stateData = widget.data;
    NavigationPages = <Widget>[
      HomePostPage(
          following: stateData['following'],
          loggedInUserData: stateData,
          refresh: updateData),
      SearchTab(loggedInUserData: stateData),
      BookmarkPage(
          bookmarked_posts: stateData['bookmarked_posts'],
          loggedInUserData: stateData,
          refresh: updateData),
      SettingsPage(),
    ];
  }

  void updateData() async {
    stateData =
        await NetworkHelper(url: 'api/detail/${stateData['id']}').getData();
    stateData;
    NavigationPages = <Widget>[
      HomePostPage(
          following: stateData['following'],
          loggedInUserData: stateData,
          refresh: updateData),
      SearchTab(loggedInUserData: stateData),
      BookmarkPage(
          bookmarked_posts: stateData['bookmarked_posts'],
          loggedInUserData: stateData,
          refresh: updateData),
      SettingsPage(),
    ];
    setState(() {
      stateData;
      NavigationPages;
      _selectedIndex;
    });
    print('update not working');
  }

  @override
  Widget build(BuildContext context) {
    print(stateData);
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        title: Text(
          '${stateData['first_name']} ${stateData['last_name']}',
          style: TextStyle(
              fontFamily: 'Kalam', fontSize: 24, fontWeight: FontWeight.w700),
        ),
        // automaticallyImplyLeading: false,
        leading: CircleAvatar(
          radius: 10,
          child: IconButton(
            icon: Icon(Icons.person),
            onPressed: () => _scaffoldKey.currentState!.openDrawer(),
          ),
        ),
      ),
      drawer: drawerBuilder(context, stateData),
      body: NavigationPages[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        selectedLabelStyle: TextStyle(fontFamily: 'Kalam'),
        selectedItemColor: Colors.black54,
        items: [
          BottomNavigationBarItem(
              icon: Icon(Icons.home),
              label: 'Home',
              backgroundColor: Theme.of(context).primaryColor),
          BottomNavigationBarItem(
              icon: Icon(Icons.search),
              label: 'Search',
              backgroundColor: Theme.of(context).primaryColor),
          BottomNavigationBarItem(
              icon: Icon(Icons.bookmark),
              label: 'Bookmarks',
              backgroundColor: Theme.of(context).primaryColor),
          BottomNavigationBarItem(
              icon: Icon(Icons.settings),
              label: 'Settings',
              backgroundColor: Theme.of(context).primaryColor),
        ],
        currentIndex: _selectedIndex,
        onTap: (value) {
          setState(() {
            _selectedIndex = value;
            updateData();
          });
        },
      ),
      floatingActionButton: _selectedIndex == 1
          ? FloatingActionButton(
              onPressed: () {
                showModalBottomSheet(
                  context: context,
                  builder: (context) {
                    return SingleChildScrollView(
                      child: Padding(
                          padding: EdgeInsets.only(
                              bottom: MediaQuery.of(context).viewInsets.bottom),
                          child: SearchSheet(
                            loggedInUserData: stateData,
                          )),
                    );
                  },
                  isScrollControlled: true,
                  backgroundColor: Colors.white.withOpacity(0.0),
                );
              },
              child: Icon(Icons.search),
            )
          : FloatingActionButton(
              onPressed: () {
                ShowDialogBox(context, stateData['id'], updateData);
              },
              child: Icon(Icons.add),
            ),
    );
  }
}
