import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

Future<bool> createUser(UserCredential userCreds) async {
  // First check user exist in our firestore database or not
  if(await checkUserAlreadyPresent(userCreds)) {
    print("User was already present at Firestore.");
    return true;
  }
  // If there is no user create one
  return createUserInFirestore(userCreds);
}

Future<bool> checkUserAlreadyPresent(UserCredential userCreds) async{
  await FirebaseFirestore
  .instance.collection('users')
  .doc(userCreds.user?.uid)
  .get()
  .then((DocumentSnapshot snapshot) {
    return snapshot.exists;
  }).onError((error, stackTrace) {
    print("Error on checking the user at Firestore $error");
    return false;
  });
  return false;
}


// If there is a new user we will add a default data into the database
Future<bool> createUserInFirestore(UserCredential userCreds) async {
  print('trying creating user');
  try{
  FirebaseFirestore.instance.collection('users').doc(userCreds.user?.uid).set(
    // for new user just create a blank list.
    {
      'Name': userCreds.user?.displayName,
      'imageUrl': userCreds.user?.photoURL,
      'friends' : [],
      'sentRequests' : [],
      'receivedRequests' : [],
    }
    
  );
  }catch(e){
    print("tried creating user but failed +$e");
    return false;
  }
  print("User created at firestore");
  return true;
}