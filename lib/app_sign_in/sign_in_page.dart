import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:time_tracker/app_sign_in/email_signin_page.dart';
import 'package:time_tracker/app_sign_in/sign_in_bloc.dart';
import 'package:time_tracker/app_sign_in/sign_in_button.dart';
import 'package:time_tracker/app_sign_in/social_sign_in_button.dart';
import 'package:time_tracker/services/auth.dart';
import 'package:time_tracker/services/auth_providers.dart';

class SignInPage extends StatelessWidget {
  SignInPage({Key? key, required this.bloc}) : super(key: key);
  final SignInBloc bloc;
  static Widget create(BuildContext context) {
    final auth = Provider.of<AuthBase>(context);
    return Provider<SignInBloc>(
      create: (_) => SignInBloc(auth),
      dispose: (context, bloc)=>bloc.dispose(),
      child: Consumer<SignInBloc>(
          builder: (context, bloc, _)=> SignInPage(bloc: bloc,)),
    );
  }

  Future<void> _signInAnonymously() async {
    try {
       await bloc.signInAnonymously();
    } catch (e) {
      print(e.toString());
    } finally {
    }
  }

  void _emailSignInPage(BuildContext context) {
    Navigator.of(context).push(MaterialPageRoute(
        fullscreenDialog: false, builder: (context) => EmailSignInPage()));
  }

  Future<void> _signInWithGoogle() async {
    try {
      final authResult = await bloc.signWithGoogle();
    } catch (e) {
      print(e.toString());
    } finally {
    }
  }

  Future<void> _signInWithFacebook() async {
    try {
      final authResult = await bloc.signWithFacebook();
    } catch (e) {
      print(e.toString());
    } finally {
    }
  }

  @override
  Widget build(BuildContext context) {
    final bloc = Provider.of<SignInBloc>(context, listen: false);
    return Scaffold(
      backgroundColor: Colors.grey[200],
      appBar: AppBar(
        title: Text("Time Tracker"),
        elevation: 2.0,
      ),
      body: StreamBuilder<bool>(
        stream: bloc.isLoadingStream,
        initialData: false,
        builder: (context, snapshot)=>_buildContent(context, snapshot.data!)),
      );
  }

  Widget _buildContent(BuildContext context, bool isLoading) {
    return Container(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(height: 50, child: _buildHeader(isLoading)),
            const SizedBox(
              height: 8.0,
            ),
            SocialSignInButton(
              text: "Sign in with Google",
              textColor: Colors.black,
              height: 50,
              imageName: "images/google-logo.png",
              borderRadius: 5,
              color: Colors.white,
              onPress: () => isLoading ? null : _signInWithGoogle(),
            ),
            const SizedBox(
              height: 8.0,
            ),
            SocialSignInButton(
              text: "Sign in with Facebook",
              textColor: Colors.white,
              height: 50,
              imageName: "images/facebook-logo.png",
              borderRadius: 5,
              color: Colors.indigo,
              onPress: () => isLoading ? null : _signInWithFacebook(),
            ),
            const SizedBox(
              height: 8.0,
            ),
            SignInButton(
              text: "Sign in with Email",
              textColor: Colors.white,
              height: 50,
              borderRadius: 5,
              color: Colors.teal,
              onPress: () => isLoading ? null : _emailSignInPage(context),
            ),
            const SizedBox(
              height: 8.0,
            ),
            const Text(
              "or",
              textAlign: TextAlign.center,
            ),
            const SizedBox(
              height: 8.0,
            ),
            SignInButton(
              text: "Go Anonymous",
              height: 50,
              borderRadius: 5,
              color: Colors.amberAccent,
              onPress: () => isLoading ? null : _signInAnonymously(),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader(bool isLoading) {
    if (isLoading) {
      return const Center(
        child: CircularProgressIndicator(),
      );
    } else {
      return const Text(
        "Sign In",
        textAlign: TextAlign.center,
        style: TextStyle(
            color: Colors.black, fontSize: 30.0, fontWeight: FontWeight.w900),
      );
    }
  }
}
