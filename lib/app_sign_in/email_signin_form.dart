import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:time_tracker/app_sign_in/sign_in_button.dart';
import 'package:time_tracker/app_sign_in/validator.dart';
import 'package:time_tracker/common_widget/platform_altert_widget.dart';
import 'package:time_tracker/services/auth.dart';
import 'package:time_tracker/services/auth_providers.dart';
enum EmailSignInformType{
  signIn,
  signUp
}

class EmailSignInForm extends StatefulWidget with EmailAndPasswordValidator{
  EmailSignInForm({Key? key}) : super(key: key);

  @override
  State<EmailSignInForm> createState() => _EmailSignInFormState();
}

class _EmailSignInFormState extends State<EmailSignInForm> {

  bool _isLoading = false;

  var _formType = EmailSignInformType.signIn;



  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  final FocusNode _emailFocusNode = FocusNode();
  final FocusNode _passwordFocusNode = FocusNode();

  String get _getEmail =>  _emailController.text;
  String get _getPassword =>  _passwordController.text;


  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    _emailFocusNode.dispose();
    _passwordFocusNode.dispose();

    super.dispose();
  }


  void _submit() async{
    setState(() {
      _isLoading = true;
    });

   //await Future.delayed(Duration(seconds: 5));

    try{
      final auth = Provider.of<AuthBase>(context, listen: false);
      if(_formType == EmailSignInformType.signIn){
          await auth.signInWithEmailPassword(_getEmail, _getPassword);
      }else{
        await auth.signUpWithEmailPassword(_getEmail, _getPassword);

      }

      Navigator.pop(context);

    } on Exception catch(e){
        PlatformAlertWidget(
            title: "Sign in Failed",
            content: e.toString(),
            defaultActionText: "Okay"
        ).show(context);
    }finally{
      setState(() {
        _isLoading = false;
      });
    }

  }

  void _toggleFormType(){
    setState(() {
      _passwordController.clear();
      _emailController.clear();
      _formType = _formType == EmailSignInformType.signIn ? EmailSignInformType.signUp : EmailSignInformType.signIn;
    });
  }

  List<Widget> _buildChildren() {

    final _primaryText = _formType == EmailSignInformType.signIn? "Sign In":"Create an account";
    final _secondaryText = _formType == EmailSignInformType.signIn? "Need an account? Register ":"Already have account? Sign In";
    bool _isButtonEnable = widget.emailValidator.isValid(_getEmail) && widget.passwordValidator.isValid(_getPassword) && !_isLoading;
    return [
      TextField(
        focusNode: _emailFocusNode,
        controller: _emailController,
        decoration:  InputDecoration(
            label: Text(
              "Email",
              style: TextStyle(fontSize: 20),
            ),
            hintText: "maruf@email.com",
          enabled: _isLoading == false
        ),
        textInputAction: TextInputAction.next,
        onEditingComplete: _emailEditingComplete,
        onChanged: (value)=> _onInputFieldChange(),
      ),
      TextField(
        focusNode: _passwordFocusNode,
        controller: _passwordController,
        decoration:  InputDecoration(
          label: Text(
            "Password",
            style: TextStyle(fontSize: 20),
          ),
          hintText: "*****",
            enabled: _isLoading == false
        ),
        obscureText: true,
        onChanged: (value)=> _onInputFieldChange(),
        textInputAction: TextInputAction.done,
        onEditingComplete: _submit,
      ),
      const SizedBox(
        height: 10,
      ),

      ElevatedButton(
          onPressed: _isButtonEnable? _submit : null,
          child: Text(
              _primaryText
          )
      ),


      TextButton(

          onPressed: _toggleFormType,
          child: Text(_secondaryText)
      )
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(12.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisSize: MainAxisSize.min,
        children:_buildChildren(),
      ),
    );
  }

  void _emailEditingComplete() {
    FocusScope.of(context).requestFocus(_passwordFocusNode);
  }


  void _onInputFieldChange() {
    setState(() {
    });
  }
}
