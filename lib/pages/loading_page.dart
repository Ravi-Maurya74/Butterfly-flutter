// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:social_media/pages/login.dart';
import 'package:social_media/widgets/load_widget.dart';
import 'package:social_media/helpers/storage.dart';
import 'package:social_media/helpers/networking.dart';
import 'package:social_media/pages/home_page.dart';

class LoadingPage extends StatefulWidget {
  const LoadingPage({super.key});

  @override
  State<LoadingPage> createState() => _LoadingPageState();
}

class _LoadingPageState extends State<LoadingPage> {
  SecureStorage secureStorage = SecureStorage();
  void checkforuser() async {
    String? email = null;
    email = await secureStorage.getData('email');
    if (email != 'null') {
      print('email not null');
      var data = await NetworkHelper(url: 'api/idemail/$email').getData();
      var new_data =
          await NetworkHelper(url: 'api/detail/${data['id']}').getData();
      if (!mounted) return;
      await Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => HomePage(data: new_data),
          ));
      SystemNavigator.pop();
    } else {
      print('email null.');
      if (mounted) {
        await Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => LogInPage(),
            ));
        SystemNavigator.pop();
      }

      // SystemNavigator.pop();
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    checkforuser();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xff168aad),
      body: Center(
        child: LoadWidget(),
      ),
    );
  }
}
