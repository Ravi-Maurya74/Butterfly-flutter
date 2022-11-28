// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables
import 'package:flutter/material.dart';
import 'package:social_media/helpers/networking.dart';
import 'package:intl/intl.dart';
import 'package:social_media/helpers/storage.dart';

import 'home_page.dart';

class SignupPage extends StatefulWidget {
  SignupPage({super.key});

  @override
  State<SignupPage> createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {
  final nameController = TextEditingController();

  final emailController = TextEditingController();

  final passwordController = TextEditingController();
  SecureStorage secureStorage = SecureStorage();

  DateTime? dob = null;
  String dobText = 'Not selected';

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
            height: MediaQuery.of(context).size.height * 0.50,
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
                                labelText: 'Name',
                                hintText: 'Enter your full name',
                              ),
                              controller: nameController,
                            ),
                          )
                        ],
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
                              ),
                              obscureText: true,
                              controller: passwordController,
                            ),
                          ),
                        ],
                      ),
                      Container(
                        padding: EdgeInsets.only(left: 5, top: 10),
                        alignment: Alignment.topLeft,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'DOB: $dobText',
                              style: TextStyle(fontSize: 15),
                            ),
                            IconButton(
                                onPressed: () {
                                  showDatePicker(
                                          context: context,
                                          initialDate: DateTime.utc(2010),
                                          firstDate: DateTime.utc(1950),
                                          lastDate: DateTime.utc(2010))
                                      .then((value) {
                                    print('date');
                                    print(value);
                                    dob = value;
                                    print(dob);
                                    setState(() {
                                      dobText = DateFormat.yMMMMd('en_US')
                                          .format(dob!)
                                          .toString();
                                    });
                                  });
                                },
                                icon: Icon(Icons.calendar_month))
                          ],
                        ),
                      ),
                      SizedBox(
                        width: MediaQuery.of(context).size.height * 0.2,
                        child: ElevatedButton(
                          onPressed: () async {
                            print('herer1');
                            if (nameController.text.isEmpty ||
                                emailController.text.isEmpty ||
                                passwordController.text.isEmpty ||
                                dob == null) return;
                            print('heer2');
                            int code = await NetworkHelper(url: '').sendData(
                                nameController.text,
                                emailController.text,
                                passwordController.text,
                                dob!);
                            if (code == 201) {
                              var data = await NetworkHelper(
                                      url:
                                          'api/idemail/${emailController.text}')
                                  .getData();
                              var new_data = await NetworkHelper(
                                      url: 'api/detail/${data['id']}')
                                  .getData();
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
                            }
                          },
                          style: ButtonStyle(
                              backgroundColor: MaterialStateProperty.all<Color>(
                                  Color.fromRGBO(253, 182, 134, 1))),
                          child: Text(
                            'Signup',
                            style: TextStyle(color: Colors.white, fontSize: 16),
                          ),
                        ),
                      )
                    ]),
              ),
            ),
          ),
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.1,
          ),
        ]),
      ),
    );
  }
}
