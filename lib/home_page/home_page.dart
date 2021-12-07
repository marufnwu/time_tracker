import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:time_tracker/common_widget/platform_altert_widget.dart';
import 'package:time_tracker/services/auth.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key, required this.auth}) : super(key: key);
  final AuthBase auth;
  Future<void> _signInOut() async{
    try{
      await auth.signOut();
    }catch(e){
      print(e.toString());
    }
  }

  void _confirmSignOut(BuildContext context) async{
   final didRequestSignOut =  await PlatformAlertWidget(
      title: "Logout",
      content: "Are you sure that you want to logout?",
      defaultActionText: "Logout",
      cancelActionText: "No",
    ).show(context);

   if(didRequestSignOut){
     _signInOut();
   }


  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Home Page"),
        actions: [
          TextButton(
              onPressed:()=>_confirmSignOut(context),
              child: Text("Logout", style: TextStyle(color: Colors.white),)
          )
        ],
      ),
    );
  }
}
