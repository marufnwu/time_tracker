import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:time_tracker/services/auth.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key, required this.auth,  required this.onSignout}) : super(key: key);
  final VoidCallback onSignout;
  final AuthBase auth;
  Future<void> _signInOut() async{
    try{
      await auth.signOut();
      onSignout();
    }catch(e){
      print(e.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Home Page"),
        actions: [
          TextButton(
              onPressed: _signInOut,
              child: Text("Logout", style: TextStyle(color: Colors.white),)
          )
        ],
      ),
    );
  }
}
