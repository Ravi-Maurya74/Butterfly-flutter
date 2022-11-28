// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:social_media/helpers/networking.dart';
import 'package:social_media/pages/home_page.dart';
import 'package:social_media/helpers/storage.dart';

class LogInPage extends StatefulWidget {
  LogInPage({super.key});

  @override
  State<LogInPage> createState() => _LogInPageState();
}

class _LogInPageState extends State<LogInPage> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  bool correctEmail = true;
  bool correctPassword = true;
  SecureStorage secureStorage = SecureStorage();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/images/back.jpeg'),
            fit: BoxFit.fill,
          ),
        ),
        constraints: BoxConstraints.expand(),
        child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
          Container(
            height: MediaQuery.of(context).size.height * 0.45,
            width: MediaQuery.of(context).size.height * 0.38,
            child: Material(
              color: Colors.white,
              elevation: 10,
              borderRadius: BorderRadius.circular(10),
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Image(
                        image: AssetImage('assets/images/icon2.png'),
                        height: MediaQuery.of(context).size.height * 0.12,
                      ),
                      Row(
                        children: [
                          Icon(Icons.person),
                          SizedBox(
                            width: 10,
                          ),
                          Flexible(
                            child: TextFormField(
                              decoration: InputDecoration(
                                labelText: 'Email',
                                hintText: 'Enter your email',
                                errorText:
                                    correctEmail ? null : 'Invalid email!',
                              ),
                              controller: emailController,
                            ),
                          )
                        ],
                      ),
                      Row(
                        children: [
                          Icon(Icons.lock),
                          SizedBox(
                            width: 10,
                          ),
                          Flexible(
                            child: TextFormField(
                              decoration: InputDecoration(
                                labelText: 'Password',
                                hintText: 'Enter your password',
                                errorText: correctPassword
                                    ? null
                                    : 'Invalid password!',
                              ),
                              obscureText: true,
                              controller: passwordController,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        width: MediaQuery.of(context).size.height * 0.2,
                        child: ElevatedButton(
                          onPressed: () async {
                            var data = await NetworkHelper(
                                    url: 'api/idemail/${emailController.text}')
                                .getData();
                            print(data);
                            if (data == null) {
                              setState(() {
                                correctEmail = false;
                              });
                            } else {
                              setState(() {
                                correctEmail = true;
                              });
                              if (data['password'] == passwordController.text &&
                                  passwordController.text.isNotEmpty) {
                                setState(() {
                                  correctPassword = true;
                                });
                                print('correct Password');
                                var new_data = await NetworkHelper(
                                        url: 'api/detail/${data['id']}')
                                    .getData();
                                print(new_data);
                                secureStorage.writeData(
                                    'email', emailController.text);
                                secureStorage.writeData(
                                    'password', passwordController.text);
                                if (!mounted) return;
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) =>
                                          HomePage(data: new_data),
                                    ));
                              } else {
                                setState(() {
                                  correctPassword = false;
                                });
                              }
                            }
                          },
                          style: ButtonStyle(
                              backgroundColor: MaterialStateProperty.all<Color>(
                                  Color.fromRGBO(253, 182, 134, 1))),
                          child: Text(
                            'Login',
                            style: TextStyle(color: Colors.white, fontSize: 16),
                          ),
                        ),
                      )
                    ]),
              ),
            ),
          ),
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.02,
          ),
          TextButton(
            onPressed: () {
              Navigator.pushNamed(context, '/signup');
            },
            child: Text(
              'Sign-up',
              style: TextStyle(
                color: Colors.black,
                fontSize: 18,
                decoration: TextDecoration.underline,
              ),
            ),
          )
        ]),
      ),
    );
  }
}
