import 'package:flutter/material.dart';
import 'package:social_media/pages/user_page.dart';

class SearchPage extends StatelessWidget {
  const SearchPage(
      {super.key, required this.data, required this.loggedInUserData});
  final dynamic data, loggedInUserData;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Search Results')),
      body: ListView.builder(
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
                    if (current_user['id'] != loggedInUserData['id'])
                      {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => UserPage(
                                      data: current_user,
                                      loggedInUserData: loggedInUserData,
                                    ))),
                      }
                  });
        },
        itemCount: (data!.length),
      ),
    );
  }
}
