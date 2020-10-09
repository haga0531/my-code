import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  final String uid;
  HomePage({Key key, this.uid}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('ホーム'),
      ),
      body: Text('ほむ'),
      bottomNavigationBar:
          BottomNavigationBar(currentIndex: _currentIndex, items: [
        BottomNavigationBarItem(icon: Icon(Icons.home), title: Text('Home')),
        BottomNavigationBarItem(
            icon: Icon(Icons.account_circle), title: Text('My Page')),
      ]),
    );
  }
}
