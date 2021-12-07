import 'package:flutter/material.dart';
import 'package:time_tracker/app_sign_in/email_signin_form.dart';
import 'package:time_tracker/services/auth.dart';

class EmailSignInPage extends StatelessWidget {
  final AuthBase auth;
  const EmailSignInPage({Key? key, required this.auth}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Login", ),
      ),
      backgroundColor: Colors.grey[200],
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Card(child: _buildContent()),
      ),
    );
  }

  Widget _buildContent() {
    return Container(
      child: EmailSignInForm(auth: auth,),
    );
  }
}
