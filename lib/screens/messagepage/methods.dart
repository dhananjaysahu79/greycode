import 'package:cloud_firestore/cloud_firestore.dart';

class UserData{
  String fullName;
  String photoUrl;
  String uid;
  UserData(this.fullName,this.photoUrl, this.uid);
}


Future <List<UserData>> getFriendList(userID) async {
  List<UserData> _userData = [];
  var snapshot = await FirebaseFirestore.instance
    .collection('users')
    .doc(userID)
    .get();
  Map<String, dynamic> data = snapshot.data()!;
  List<dynamic> friends = data['friends'];
  print(friends);
  for(var i = 0; i < friends.length; i++){
    print("inside for loop");
    print(friends[i]);
    _userData.add(await getDetailsByID(friends[i]));
  }
  return _userData;
}

Future <UserData> getDetailsByID(userID) async {
  var collection = FirebaseFirestore.instance.collection('users');
  var docSnapshot = await collection.doc(userID).get();
  Map<String, dynamic> data = docSnapshot.data()!;
  print("getting data ");
  print(data.toString());
  return UserData(data['Name'], data['imageUrl'], userID);
}