import 'package:flutter/material.dart';
import 'package:project/views/home.dart';
import 'package:project/my_dashboard.dart';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';


void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.brown,
      ),
      home: MyLoginPage(),
    );
  }
}

class MyLoginPage extends StatefulWidget {
  const MyLoginPage({Key? key}) : super(key: key);

  @override
  _MyLoginPageState createState() => _MyLoginPageState();
}

class _MyLoginPageState extends State<MyLoginPage> {
  final username_controller = TextEditingController();
  final password_controller = TextEditingController();

  late SharedPreferences logindata;
  late bool newuser;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(" Shared Preferences"),
      ),
      body: Center(
        child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Text(
                "Login Form",
                style: TextStyle(fontSize: 30, fontWeight:
                FontWeight.bold),
              ),
              Padding(
                padding: const EdgeInsets.all(15.0),
                child: TextField(
                  controller: username_controller,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'username',
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(15.0),
                child: TextField(
                  controller: password_controller,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Password',
                  ),
                ),
              ),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  onPrimary: Colors.blue,

                ),
                onPressed: () {
                  String username = username_controller.text;
                  String password = password_controller.text;

                  if (username != '' && password != '') {
                    print('Successfull');
                    logindata.setBool('login', false);
                    logindata.setString('username', username);
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => HomePage()));
                  }
                },
                child: Text("Log-In"),
              )
            ]
        ),
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    check_if_already_login();
  }

  void check_if_already_login() async {
    logindata = await SharedPreferences.getInstance();
    newuser = (logindata.getBool('login') ?? true);
    print(newuser);
    if (newuser == false) {
      Navigator.pushReplacement(
          context, new MaterialPageRoute(builder: (context) => MyDashboard()));
    }
  }

  void dispose() {
    username_controller.dispose();
    password_controller.dispose();
    super.dispose();
  }
}
