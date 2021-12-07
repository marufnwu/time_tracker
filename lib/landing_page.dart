import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:time_tracker/app_sign_in/sign_in_page.dart';
import 'package:time_tracker/home_page/home_page.dart';
import 'package:time_tracker/services/auth.dart';

class LandingPage extends StatefulWidget {
  const LandingPage({Key? key, this.auth}) : super(key: key);

  final AuthBase? auth;
  @override
  _LandingPageState createState() => _LandingPageState();
}

class _LandingPageState extends State<LandingPage> {


  @override
  Widget build(BuildContext context) {
    return StreamBuilder<AuthUser?>(
        stream: widget.auth!.authUserStateChanges,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.active) {
            AuthUser? mUser = snapshot.data;
            return mUser != null
                ? HomePage(
                    auth: widget.auth!,
                  )
                : SignInPage(auth: widget.auth!);
          }else if(snapshot.connectionState == ConnectionState.waiting){
            return Scaffold(
              body: CircularProgressIndicator(),
            );
          }
          else{
            return Scaffold(
              body: CircularProgressIndicator(),
            );
          }
        });
  }
}
