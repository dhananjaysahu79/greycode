import 'package:flutter/src/widgets/framework.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'getUser.dart';
import 'createUser.dart';


Future<bool> signInWithGoogle({required BuildContext context}) async {
  // Trigger the authentication flow
  final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();
  print('triggered1');
  // Obtain the auth details from the request
  final GoogleSignInAuthentication? googleAuth = await googleUser?.authentication;
  print('triggered2');
  // Create a new credential
  final credential = GoogleAuthProvider.credential(
    accessToken: googleAuth?.accessToken,
    idToken: googleAuth?.idToken,
  );
  print('triggered3');
  // Once signed in, return the UserCredential
  UserCredential userCreds = await FirebaseAuth.instance.signInWithCredential(credential);
  bool isProfileCreated = await createUser(userCreds, context);
  if(isProfileCreated){
    bool isSet = await setUserCreds(userCreds);
    return isSet;
  }
  return false;
}