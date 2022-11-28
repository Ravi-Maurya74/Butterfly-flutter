import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:social_media/helpers/storage.dart';

class SettingsPage extends StatelessWidget {
  SettingsPage({super.key});
  SecureStorage secureStorage = SecureStorage();

  @override
  Widget build(BuildContext context) {
    return Container(
        child: Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          IconButton(
            icon: Icon(Icons.logout),
            onPressed: () async {
              await secureStorage.writeData('email', 'null');
              SystemNavigator.pop();
            },
            iconSize: 50,
          ),
          Text(
            'Logout',
            style: TextStyle(fontFamily: 'Kalam', fontSize: 30),
          )
        ],
      ),
    ));
  }
}
