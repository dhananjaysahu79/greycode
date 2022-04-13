import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:greycode/utils/utilities.dart';
import 'package:stream_chat_flutter/stream_chat_flutter.dart' as stream_chat;

Future<bool> createUser(UserCredential userCreds, BuildContext context) async {
  // First check user exist in our firestore database or not
  bool isPresent = await checkUserAlreadyPresent(userCreds, context);
  if(isPresent) {
    print("User was already present at Firestore.");
    return true;
  }
  else {
  // If there is no user create one
    return createUserInFirestore(userCreds, context);
  }
}

Future<bool> checkUserAlreadyPresent(UserCredential userCreds, BuildContext context) async{

  try {
    var snapshot = await FirebaseFirestore.instance
      .collection('users')
      .doc(userCreds.user?.uid)
      .get();
    return snapshot.exists;
  } catch (e) {
    print("Error in checkUserAlreadyPresent: $e");
    return false;
  }

}


// If there is a new user we will add a default data into the database
Future<bool> createUserInFirestore(UserCredential userCreds, BuildContext context) async {
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

  // Call to create the user in Stream chat.
  bool _ = await createUserOnStream(userCreds.user?.uid, context);
  }catch(e){
    print("tried creating user but failed +$e");
    return false;
  }
  print("User created at firestore");
  return true;
}

Future<bool> createUserOnStream(userID, BuildContext context) async {
  try {
    final client = stream_chat.StreamChat.of(context).client;
    await client.connectUser(
      stream_chat.User(
        id: userID,
      ),
      client.devToken(userID).rawValue
    );
  } catch (e) {
    return true;
  }
  return true;
}


Future createChannel(BuildContext context, senderID, receiverID) async {
  bool res = await createUserOnStream(senderID, context);
  try {
    final client = stream_chat.StreamChat.of(context).client;
    showSnackBar(senderID, context);
    final channel = client.channel(
      'messaging', 
      extraData: {
        'members' : [
          senderID,
          receiverID
        ]
      }
    );
    return [true, channel]; 
  } catch (e) {
    print("Error in createChannel: $e");
    return [false,e];
  }
  
  // await channel.watch();
}