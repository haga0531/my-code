import 'package:flutter/material.dart';
import 'package:mycode/services/api.dart';
import 'package:mycode/views/home_page.dart';
import 'package:mycode/views/signup_page.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Code App',
      theme: ThemeData(
        primaryColor: Colors.blueGrey,
      ),
      home: HomeController(),
    );
  }
}

class HomeController extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<String>(
      stream: Api().onAuthStateChanged,
      builder: (context, AsyncSnapshot<String> snapshot) {
        if (snapshot.hasData) {
          return HomePage();
        } else {
          return SignUpPage(authType: AuthType.signIn);
        }
      },
    );
  }
}
