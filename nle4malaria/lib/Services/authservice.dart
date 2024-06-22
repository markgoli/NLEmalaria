import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/services.dart';
import 'package:google_sign_in/google_sign_in.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final GoogleSignIn _googleSignIn = GoogleSignIn();

  // Sign in with Google
  Future<void> signInWithGoogle() async {
    try {
      // Request permissions
      final GoogleSignInAccount? gUser = await _googleSignIn.signIn();

      // Check if the user cancelled the sign-in process
      if (gUser == null) {
        throw PlatformException(
          code: 'sign_in_failed',
          message: 'The user cancelled the sign-in process',
        );
      }

      // Obtain auth details from the request
      // ignore: unnecessary_nullable_for_final_variable_declarations
      final GoogleSignInAuthentication? gAuth = await gUser.authentication;

      // Create a new credential for the user
      final credential = GoogleAuthProvider.credential(
        accessToken: gAuth?.accessToken,
        idToken: gAuth?.idToken,
      );

      // Use the new credential to sign in
      await _auth.signInWithCredential(credential);
    } catch (e) {
      throw PlatformException(
        code: 'sign_in_failed',
        message: e.toString(),
      );
    }
  }
}
