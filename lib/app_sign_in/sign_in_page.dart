import 'package:flutter/material.dart';
import 'package:time_tracker/app_sign_in/sign_in_button.dart';
import 'package:time_tracker/app_sign_in/social_sign_in_button.dart';
import 'package:time_tracker/services/auth.dart';

class SignInPage extends StatelessWidget {
  const SignInPage({Key? key, required this.auth, required this.onSignIn}) : super(key: key);

  final AuthBase auth;
  final Function(AuthUser?) onSignIn;

  Future<void> _signInAnonymously() async{
    try{
      final authResult = await auth.signInAnonymously();
      onSignIn(authResult);
    }catch(e){
      print(e.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
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
              Text(
                "Sign In",
                textAlign: TextAlign.center,
                style: TextStyle(
                    color: Colors.black,
                    fontSize: 30.0,
                    fontWeight: FontWeight.w900),
              ),
              SizedBox(
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
                  onPress: (){},
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
                  onPress: (){},
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
                  onPress: (){},
                ),
              ),

              SizedBox(
                height: 8.0,
              ),
              Text("or", textAlign: TextAlign.center,),

              SizedBox(
                height: 8.0,
              ),
              Container(
                child: SignInButton(
                  text: "Go Anonymous",
                  height: 50,
                  borderRadius: 5,
                  color: Colors.amberAccent,
                  onPress: _signInAnonymously,
                ),
              ),

            ],
          ),
        ),
      ),
    );
  }
}
