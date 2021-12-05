import 'package:firebase_auth/firebase_auth.dart';

class AuthUser{
  AuthUser({required String uid});
}

abstract class AuthBase{
  Future<AuthUser?> signInAnonymously();
  Future<AuthUser?> currentUser();
  Future<void> signOut();
}

class Auth extends AuthBase{

  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  AuthUser? _userFromFirebaseUser(User? user){
    if(user == null){
      return null;
    }

    return AuthUser(uid: user.uid);
  }

  @override
  Future<AuthUser?> signInAnonymously() async{
    final authResult = await _firebaseAuth.signInAnonymously();
    return _userFromFirebaseUser(authResult.user);
  }

  @override
  Future<AuthUser?> currentUser() async{
    return _userFromFirebaseUser(_firebaseAuth.currentUser);
  }

  @override
  Future<void> signOut() async{
    _firebaseAuth.signOut();
  }

}