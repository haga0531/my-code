import 'package:flutter/material.dart';
import 'package:mycode/services/api.dart';
import 'package:mycode/views/home_page.dart';
import 'package:mycode/views/my_page.dart';
import 'package:mycode/views/signup_page.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
          primaryColor: Colors.blueGrey[800],
          visualDensity: VisualDensity.comfortable),
      home: HomeController(),
      routes: <String, WidgetBuilder>{
        '/home': (BuildContext context) => HomePage(),
        '/mypage': (BuildContext context) => MyPage()
      },
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
          return SignUpPage(authType: AuthType.signUp);
        }
      },
    );
  }
}
