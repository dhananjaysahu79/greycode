import 'package:firebase_auth/firebase_auth.dart';
import 'package:shared_preferences/shared_preferences.dart';

// Future<String> getCurrentUID() async{
//     final FirebaseAuth _auth = FirebaseAuth.instance;
//     final FirebaseUser user = await _auth.currentUser!();
//     final String uid = user.uid;
//     return uid;
//   }

// Future<FirebaseUser> getCurrentUSER() async{
//     final FirebaseAuth _auth = FirebaseAuth.instance;
//     final FirebaseUser user = await _auth.currentUser();
//     return user;
//   }

Future<bool> setUserCreds(UserCredential creds) async{
  // If no user, send error message
  print(creds.user?.displayName.toString());
  try {
    String name = creds.user?.displayName ?? 'abc';
    String url = creds.user?.photoURL ?? 'abc';
    String userID = creds.user?.uid ?? 'abc';
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('displayName', name);
    await prefs.setString('photoURL', url);
    await prefs.setString('userID', userID);
    // If no error 
    print("Yes successfully stored data in shared prefs");
    return true;

  } catch(e){
    print(e);
     print("storeing data in shared prefs failed $e");
    return false;
  }
  
}

class UserData{
  String fullName;
  String photoUrl;
  UserData(this.fullName,this.photoUrl);
}

Future getUserCreds() async{
  UserData userData;
  List<UserData> _userData = [];
  
  try {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String fullName = (prefs.getString('displayName') ?? 'abc');
    String photoUrl = (prefs.getString('photoURL') ?? '');
    print(fullName);
    if(fullName == 'abc') return [false];
    userData = UserData(fullName,photoUrl);
    _userData.add(userData);
    print(userData);
    return _userData;

  }catch(e){
    return [false];
  }

}

Future getUserID() async {
  try{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String userID = (prefs.getString('userID') ?? '');
    return userID;
  }catch(e){
     return e;
  }
}
Future getUserName() async {
  try{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String userName = (prefs.getString('displayName') ?? '');
    return userName;
  }catch(e){
     return e;
  }
}


Future<bool> logOutUser() async{
  try{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.remove('displayName');
    prefs.remove('userID');
    prefs.remove('photoURL');
    return true;
  }catch(e){
    return false;
  }}



