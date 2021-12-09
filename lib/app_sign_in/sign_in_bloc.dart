import 'dart:async';

import 'package:time_tracker/services/auth.dart';

class SignInBloc{
  final AuthBase auth;


  final StreamController<bool> _isLoadingController = StreamController<bool>();

  SignInBloc(this.auth);
  Stream<bool> get isLoadingStream => _isLoadingController.stream;

  void dispose(){
    _isLoadingController.close();
  }

  void setIsLoading(bool isLoading) => _isLoadingController.add(isLoading);

  Future<AuthUser?> _signIn(Future<AuthUser?> Function() method)async{
    try{
      setIsLoading(true);
      return await method();
    }catch(e){
      rethrow;
    }finally{
      setIsLoading(false);
    }
  }


  Future<AuthUser?> signInAnonymously() async => await _signIn(auth.signInAnonymously);
  Future<AuthUser?> signWithGoogle() async => await _signIn(auth.signWithGoogle);
  Future<AuthUser?> signWithFacebook() async => await _signIn(auth.signWithFacebook);

}
