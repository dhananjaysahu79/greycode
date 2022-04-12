import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:stream_chat_flutter/stream_chat_flutter.dart' as stream_chat;

Future<bool> createUser(UserCredential userCreds, BuildContext context) async {
  // First check user exist in our firestore database or not
  if(await checkUserAlreadyPresent(userCreds, context)) {
    print("User was already present at Firestore.");
    return true;
  }
  // If there is no user create one
  return createUserInFirestore(userCreds, context);
}

Future<bool> checkUserAlreadyPresent(UserCredential userCreds, BuildContext context) async{
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
  await createUserOnStream(userCreds.user?.uid, context);
  }catch(e){
    print("tried creating user but failed +$e");
    return false;
  }
  print("User created at firestore");
  return true;
}

Future<void> createUserOnStream(userID, BuildContext context) async {
  final client = stream_chat.StreamChatCore.of(context).client;
  await client.connectUser(
    stream_chat.User(
      id: userID,
    ),
    client.devToken(userID).rawValue
  );
}


Future createChannel(BuildContext context, receiverID) async {

  try {
    final core = stream_chat.StreamChatCore.of(context);
    final channel = core.client.channel(
      'messaging', 
      extraData: {
        'members' : [
          core.currentUser!.id,
          receiverID
        ]
      }
    );
    return [true, channel]; 
  } catch (e) {
    return [false,e];
  }
  
  // await channel.watch();
}