import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key, required this.onSignout}) : super(key: key);
  final VoidCallback onSignout;
  Future<void> _signInOut() async{
    try{
      await FirebaseAuth.instance.signOut();
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
