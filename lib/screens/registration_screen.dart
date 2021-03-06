import 'package:flash_app/screens/chat_screen.dart';
import 'package:flutter/material.dart';
import 'package:flash_app/components/rounded_button.dart';
import 'package:flash_app/constants.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'chat_screen.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';

class RegistrationScreen extends StatefulWidget {
  static const String id = 'registration_screen';
  @override
  _RegistrationScreenState createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen> {
  final _auth = FirebaseAuth.instance;
  bool spinner =false;
  String email;
  String password;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: ModalProgressHUD(
        inAsyncCall: spinner,
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 24.0),
          child: SingleChildScrollView(
            reverse: true,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                Hero(
                  tag: 'logo  ',
                  child: Container(
                    height: 200.0,
                    child: Image.asset('images/yay.png'),
                  ),
                ),
                SizedBox(
                  height: 48.0,
                ),
                TextField(
                  keyboardType: TextInputType.emailAddress,
                  textAlign: TextAlign.center,
                  onChanged: (value) {
                    email=value;
                  },
                  decoration:kTextFieldDecoration.copyWith(hintText: 'Enter your email.'),
                ),
                SizedBox(
                  height: 8.0,
                ),
                TextField(
                  obscureText: true,
                  textAlign: TextAlign.center,
                  onChanged: (value) {
                    password=value;
                  },
                  decoration:kTextFieldDecoration.copyWith(hintText: 'Enter your password.'),
                ),
                SizedBox(
                  height: 24.0,
                ),
                RoundedButton(color: Colors.lightBlueAccent, title: 'Register',
                  onPressed:() async {
                  setState(() {
                    spinner=true;
                  });
                 try{
                   final newUser = await _auth.createUserWithEmailAndPassword(email: email, password: password);
                   if(newUser!=null){
                     Navigator.pushNamed(context, ChatScreen.id);
                   }
                   setState(() {
                     spinner=false;
                   });
                 }
                 catch(e){
                   print(e);
                 }
                },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
