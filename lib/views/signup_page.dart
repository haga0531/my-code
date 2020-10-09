import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:mycode/services/api.dart';
import 'package:mycode/services/validator.dart';
import 'package:mycode/views/home_page.dart';

enum AuthType {
  signUp,
  signIn,
}

class SignUpPage extends StatefulWidget {
  final AuthType authType;
  SignUpPage({Key key, @required this.authType}) : super(key: key);

  @override
  _SignUpPageState createState() => _SignUpPageState(authType: this.authType);
}

class _SignUpPageState extends State<SignUpPage> {
  AuthType authType;
  _SignUpPageState({this.authType});

  Api _api = Api();
  final formKey = GlobalKey<FormState>();
  TextEditingController emailInputController;
  TextEditingController passwordInputController;
  String _error;

  @override
  void initState() {
    emailInputController = TextEditingController();
    passwordInputController = TextEditingController();
    super.initState();
  }

  void moveToSignupPage() {
    formKey.currentState.reset();
    setState(() {
      authType = AuthType.signUp;
    });
  }

  void moveToLoginPage() {
    formKey.currentState.reset();
    setState(() {
      authType = AuthType.signIn;
    });
  }

  void submit() async {
    final form = formKey.currentState;
    if (form.validate()) {
      try {
        switch (authType) {
          case AuthType.signIn:
            await _api.signInWithEmailAndPassword(
                emailInputController.text, passwordInputController.text);
            await Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (BuildContext context) => HomePage()));
            break;
          case AuthType.signUp:
            String uid = await _api.createUserWithEmailAndPassword(
                emailInputController.text, passwordInputController.text);
            Firestore.instance.collection('users').document(uid).setData({
              'uid': uid,
              'email': emailInputController.text,
              'image':
                  'https://firebasestorage.googleapis.com/v0/b/my-code-30595.appspot.com/o/profile_icon%2Fuseicon.jpeg?alt=media&token=1fe4f07e-7249-483a-a9fb-195e3bda58da'
            });
            await Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (BuildContext context) => HomePage()));
            break;
          default:
        }
      } catch (e) {
        print('e: ${e.message}');
        setState(() {
          _error = e.message;
        });
      }
    }
  }

  Widget showAlert() {
    if (_error != null) {
      return Container(
        color: Colors.amberAccent,
        width: double.infinity,
        padding: EdgeInsets.all(8),
        child: Row(
          children: [
            Padding(
              padding: const EdgeInsets.only(right: 8),
              child: Icon(Icons.error_outline),
            ),
            Expanded(
                child: Text(
              _error,
              maxLines: 3,
            )),
            Padding(
              padding: const EdgeInsets.only(left: 8),
              child: IconButton(
                  icon: Icon(Icons.close),
                  onPressed: () {
                    setState(() {
                      _error = null;
                    });
                  }),
            )
          ],
        ),
      );
    }
    return SizedBox();
  }

  List<Widget> _buildLayout() {
    if (authType == AuthType.signIn) {
      return [
        showAlert(),
        Center(
          child: Text(
            'アカウント作成',
            style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 30,
                color: Colors.blueGrey),
          ),
        ),
        SizedBox(
          height: 20,
        ),
        TextFormField(
          validator: Validator.emailValidate,
          controller: emailInputController,
          decoration:
              InputDecoration(labelText: 'Email', hintText: 'メールアドレスを入力してください'),
        ),
        TextFormField(
          validator: Validator.passwordValidate,
          controller: passwordInputController,
          decoration: InputDecoration(
              labelText: 'Password', hintText: 'パスワードを入力してください (6文字以上)'),
          obscureText: true,
        ),
        SizedBox(
          height: 30,
        ),
        RaisedButton(
          onPressed: submit,
          child: Text(
            'ログイン',
            style: TextStyle(fontSize: 20),
          ),
          color: Colors.blueGrey,
          textColor: Colors.white,
        ),
        FlatButton(
            onPressed: moveToSignupPage,
            child: Text(
              '新規登録へ',
              style: TextStyle(fontSize: 20, color: Colors.black),
            ))
      ];
    } else {
      return [
        showAlert(),
        Center(
          child: Text(
            'ログイン',
            style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 30,
                color: Colors.blueGrey),
          ),
        ),
        SizedBox(
          height: 20,
        ),
        TextFormField(
          validator: Validator.emailValidate,
          controller: emailInputController,
          decoration:
              InputDecoration(labelText: 'Email', hintText: 'メールアドレスを入力してください'),
        ),
        TextFormField(
          validator: Validator.passwordValidate,
          controller: passwordInputController,
          decoration: InputDecoration(
              labelText: 'Password', hintText: 'パスワードを入力してください (6文字以上)'),
          obscureText: true,
        ),
        SizedBox(
          height: 30,
        ),
        RaisedButton(
          onPressed: submit,
          child: Text(
            '新規登録',
            style: TextStyle(fontSize: 20),
          ),
          color: Colors.blueGrey,
          textColor: Colors.white,
        ),
        FlatButton(
            onPressed: moveToLoginPage,
            child: Text(
              'ログインする',
              style: TextStyle(fontSize: 20, color: Colors.black),
            ))
      ];
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('アカウント作成'),
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.all(20),
          child: Form(
              key: formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: _buildLayout(),
              )),
        ),
      ),
    );
  }
}
