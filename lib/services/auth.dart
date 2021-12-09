import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/services.dart';
import 'package:flutter_facebook_login/flutter_facebook_login.dart';
import 'package:google_sign_in/google_sign_in.dart';

class AuthUser {
  AuthUser({required String uid});
}

abstract class AuthBase {
  Future<AuthUser?> currentUser();
  Future<void> signOut();
  Stream<AuthUser?>? get authUserStateChanges;

  Future<AuthUser?> signInAnonymously();
  Future<AuthUser?> signWithGoogle();
  Future<AuthUser?> signWithFacebook();

  Future<AuthUser?> signInWithEmailPassword(String email, String password);
  Future<AuthUser?> signUpWithEmailPassword(String email, String password);
}

class Auth extends AuthBase {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  AuthUser? _userFromFirebaseUser(User? user) {
    if (user == null) {
      return null;
    }

    return AuthUser(uid: user.uid);
  }

  @override
  Future<AuthUser?> signInAnonymously() async {
    final authResult = await _firebaseAuth.signInAnonymously();
    return _userFromFirebaseUser(authResult.user);
  }

  @override
  Stream<AuthUser?>? get authUserStateChanges {
    return _firebaseAuth
        .authStateChanges()
        .map((user) => _userFromFirebaseUser(user));
  }

  @override
  Future<AuthUser?> currentUser() async {
    return _userFromFirebaseUser(_firebaseAuth.currentUser);
  }

  @override
  Future<AuthUser?> signWithGoogle() async {
    GoogleSignIn googleSignIn = GoogleSignIn();
    GoogleSignInAccount? googleAccount = await googleSignIn.signIn();

    GoogleSignInAuthentication? googleAuth =
        await googleAccount!.authentication;
    if (googleAuth.accessToken != null && googleAuth.idToken != null) {
      final authResult = await _firebaseAuth.signInWithCredential(
        GoogleAuthProvider.credential(
            idToken: googleAuth.idToken, accessToken: googleAuth.accessToken),
      );

      return _userFromFirebaseUser(authResult.user);
    } else {
      throw PlatformException(
          code: "ERROR_MISSING_GOOGLE_AUTH_TOKEN",
          message: "Sign in aborted by user");
    }
  }

  @override
  Future<AuthUser?> signWithFacebook() async {
    final facebookLogin = FacebookLogin();
    final result =
        await facebookLogin.logInWithReadPermissions(['public_profile']);

    if (result.accessToken != null) {
      final authResult = await _firebaseAuth.signInWithCredential(
          FacebookAuthProvider.credential(result.accessToken.token));

      return _userFromFirebaseUser(authResult.user);
    } else {
      throw PlatformException(
          code: "ERROR_MISSING_GOOGLE_AUTH_TOKEN",
          message: result.errorMessage);
    }
  }

  @override
  Future<AuthUser?> signInWithEmailPassword(String email, String password) async {
    final authResult = await _firebaseAuth.signInWithEmailAndPassword(email: email, password: password);
    return _userFromFirebaseUser(authResult.user);

  }

  @override
  Future<AuthUser?> signUpWithEmailPassword(String email, String password) async {
    final authResult = await _firebaseAuth.createUserWithEmailAndPassword(email: email, password: password);
    return _userFromFirebaseUser(authResult.user);
  }

  @override
  Future<void> signOut() async {
    await GoogleSignIn().signOut();
    await FacebookLogin().logOut();
    _firebaseAuth.signOut();
  }
}
