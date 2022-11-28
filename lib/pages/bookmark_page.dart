import 'package:flutter/material.dart';
import 'package:social_media/widgets/post.dart';

class BookmarkPage extends StatelessWidget {
  const BookmarkPage(
      {required this.bookmarked_posts,
      required this.loggedInUserData,
      required this.refresh,
      super.key});
  final List<dynamic> bookmarked_posts;
  final dynamic loggedInUserData;
  final Function refresh;

  @override
  Widget build(BuildContext context) {
    return Container(
      child: RefreshIndicator(
        onRefresh: () async {
          refresh();
        },
        child: ListView.builder(
          itemBuilder: (context, index) {
            return Post(
              key: UniqueKey(),
              loggedInUserData: loggedInUserData,
              index: bookmarked_posts[index],
              isOnUserPage: false,
              deleteupdate: () {},
            );
          },
          itemCount: bookmarked_posts.length,
        ),
      ),
    );
  }
}
