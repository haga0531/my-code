import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:mycode/services/api.dart';
import 'package:mycode/views/add_goal_page.dart';
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
      localizationsDelegates: [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ],
      supportedLocales: [
        const Locale('ja'),
      ],
      theme: ThemeData(
          primaryColor: Colors.blueGrey[800],
          visualDensity: VisualDensity.comfortable),
      home: HomeController(),
      routes: <String, WidgetBuilder>{
        '/home': (BuildContext context) => HomePage(),
        '/mypage': (BuildContext context) => MyPage(),
        '/add': (BuildContext context) => AddGoalPage(),
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
