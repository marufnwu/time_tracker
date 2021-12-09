import 'package:flutter/material.dart';
import 'package:time_tracker/app_sign_in/email_sign_in_form_bloc_based.dart';
import 'package:time_tracker/app_sign_in/email_sign_in_form_change_notifier.dart';
import 'package:time_tracker/app_sign_in/email_signin_form.dart';
import 'package:time_tracker/services/auth.dart';

class EmailSignInPage extends StatelessWidget {
  const EmailSignInPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Login",
        ),
      ),
      backgroundColor: Colors.grey[200],
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Card(child: _buildContent(context)),
      ),
    );
  }

  Widget _buildContent(BuildContext context) {
    return Container(
      child: EmailSignInFormChangeNotifier.create(context),
    );
  }
}
