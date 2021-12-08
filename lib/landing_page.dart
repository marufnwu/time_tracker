import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:time_tracker/app_sign_in/sign_in_page.dart';
import 'package:time_tracker/home_page/home_page.dart';
import 'package:time_tracker/services/auth.dart';
import 'package:time_tracker/services/auth_providers.dart';

class LandingPage extends StatefulWidget {
  const LandingPage({Key? key}) : super(key: key);

  @override
  _LandingPageState createState() => _LandingPageState();
}

class _LandingPageState extends State<LandingPage> {


  @override
  Widget build(BuildContext context) {
    final AuthBase? auth = AuthProvider.of(context);
    return StreamBuilder<AuthUser?>(
        stream: auth!.authUserStateChanges,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.active) {
            AuthUser? mUser = snapshot.data;
            return mUser != null
                ? HomePage()
                : SignInPage();
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
