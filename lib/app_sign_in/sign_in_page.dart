import 'package:flutter/material.dart';
import 'package:time_tracker/app_sign_in/email_signin_page.dart';
import 'package:time_tracker/app_sign_in/sign_in_button.dart';
import 'package:time_tracker/app_sign_in/social_sign_in_button.dart';
import 'package:time_tracker/services/auth.dart';
import 'package:time_tracker/services/auth_providers.dart';

class SignInPage extends StatelessWidget {
  const SignInPage({Key? key}) : super(key: key);


  Future<void> _signInAnonymously(AuthBase auth) async {

    try {
      final authResult = await auth.signInAnonymously();
    } catch (e) {
      print(e.toString());
    }
  }

  void _emailSignInPage(BuildContext context){
    Navigator.of(context).push(
      MaterialPageRoute(
          fullscreenDialog: false,
          builder: (context)=>EmailSignInPage()
      )
    );
  }

  Future<void> _signInWithGoogle(AuthBase auth) async {
    try {
      final authResult = await auth.signWithGoogle();
    } catch (e) {
      print(e.toString());
    }
  }
  Future<void> _signInWithFacebook(AuthBase auth) async {
    try {
      final authResult = await auth.signWithFacebook();
    } catch (e) {
      print(e.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    final auth = AuthProvider.of(context);
    return Scaffold(
      backgroundColor: Colors.grey[200],
      appBar: AppBar(
        title: Text("Time Tracker"),
        elevation: 2.0,
      ),
      body: Container(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                "Sign In",
                textAlign: TextAlign.center,
                style: TextStyle(
                    color: Colors.black,
                    fontSize: 30.0,
                    fontWeight: FontWeight.w900),
              ),
              const SizedBox(
                height: 8.0,
              ),
              Container(
                child: SocialSignInButton(
                  text: "Sign in with Google",
                  textColor: Colors.black,
                  height: 50,
                  imageName: "images/google-logo.png",
                  borderRadius: 5,
                  color: Colors.white,
                  onPress: ()=>_signInWithGoogle(auth),
                ),
              ),
              SizedBox(
                height: 8.0,
              ),
              Container(
                child: SocialSignInButton(
                  text: "Sign in with Facebook",
                  textColor: Colors.white,
                  height: 50,
                  imageName: "images/facebook-logo.png",
                  borderRadius: 5,
                  color: Colors.indigo,
                  onPress: ()=>_signInWithFacebook(auth),
                ),
              ),
              SizedBox(
                height: 8.0,
              ),
              Container(
                child: SignInButton(
                  text: "Sign in with Email",
                  textColor: Colors.white,
                  height: 50,
                  borderRadius: 5,
                  color: Colors.teal,
                  onPress: ()=>_emailSignInPage(context),
                ),
              ),
              SizedBox(
                height: 8.0,
              ),
              Text(
                "or",
                textAlign: TextAlign.center,
              ),
              SizedBox(
                height: 8.0,
              ),
              Container(
                child: SignInButton(
                  text: "Go Anonymous",
                  height: 50,
                  borderRadius: 5,
                  color: Colors.amberAccent,
                  onPress: ()=>_signInAnonymously(auth),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
