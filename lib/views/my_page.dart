import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:mycode/model/user.dart';
import 'package:mycode/services/api.dart';
import 'dart:async';

class MyPage extends StatefulWidget {
  @override
  _MyPageState createState() => _MyPageState();
}

class _MyPageState extends State<MyPage> {
  Api _api = Api();
  User currentUser;
  int _selectIndex = 1;

  @override
  void initState() {
    super.initState();
    _api.getCurrentUserData().then((user) {
      setState(() {
        currentUser = User.fromSnapshot(user);
      });
    });
  }

  Widget currentUserTile(User currentUser) {
    return (currentUser == null)
        ? CircularProgressIndicator()
        : Container(
            child: Column(
              children: [
                ListTile(
                  leading: CircleAvatar(
                    backgroundImage: NetworkImage('${currentUser.image}'),
                    radius: 25,
                  ),
                  title: Text(
                      currentUser.name == null ? '未設定' : '${currentUser.name}'),
                )
              ],
            ),
          );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('My Page'),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [currentUserTile(currentUser)],
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectIndex,
        items: [
          BottomNavigationBarItem(icon: Icon(Icons.home), title: Text('Home')),
          BottomNavigationBarItem(
              icon: Icon(Icons.account_circle), title: Text('My Page')),
        ],
        onTap: (int index) {
          if (index == 0) {
            Navigator.of(context).pushReplacementNamed('/home');
          } else if (index == 1) {
            Navigator.of(context).pushReplacementNamed('/mypage');
          }
        },
      ),
    );
  }
}
