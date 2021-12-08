import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:time_tracker/common_widget/platform_altert_widget.dart';
import 'package:time_tracker/services/auth.dart';
import 'package:time_tracker/services/auth_providers.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);
  Future<void> _signInOut(BuildContext context) async{
    try{
      final auth = AuthProvider.of(context);
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
     _signInOut(context);
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
