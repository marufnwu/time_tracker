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
  AuthUser? _mUser;

  @override
  void initState() {
    super.initState();
    _checkCurrentUser();
  }

  Future<void> _checkCurrentUser() async{
    _updateUser(await widget.auth!.currentUser());
  }

  void _updateUser(AuthUser? user){
    setState(() {
      _mUser = user!;
    });
  }

  void _signout(){
    setState(() {
      _mUser = null;
    });
  }

  @override
  Widget build(BuildContext context) {
    return _mUser != null ?  HomePage(
      onSignout: ()=>_signout(),
      auth: widget.auth!,
    ) : SignInPage(
        onSignIn: (user)=>_updateUser(user),
        auth: widget.auth!
    );
  }
}
