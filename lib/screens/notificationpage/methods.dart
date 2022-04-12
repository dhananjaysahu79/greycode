import 'package:cloud_firestore/cloud_firestore.dart';

class UserData{
  String fullName;
  String photoUrl;
  String uid;
  UserData(this.fullName,this.photoUrl, this.uid);
}


Future <List<UserData>> getReceivedRequestList(userID) async {
  List<UserData> _userData = [];
  var snapshot = await FirebaseFirestore.instance
    .collection('users')
    .doc(userID)
    .get();
  Map<String, dynamic> data = snapshot.data()!;
  List<dynamic> receivedRequests = data['receivedRequests'];
  print(receivedRequests);
  for(var i = 0; i < receivedRequests.length; i++){
    print("inside for loop");
    print(receivedRequests[i]);
    _userData.add(await getDetailsByID(receivedRequests[i]));
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


  Future <bool> acceptRequest(senderID, receiverID) async {

    try {
        // add requestID to receiver's friend list
        await FirebaseFirestore.instance.collection("users").doc(receiverID).update(
          {
            "friends": FieldValue.arrayUnion([senderID])
          }
        );
        // delete request from receiver's receivedRequest list
        await FirebaseFirestore.instance.collection("users").doc(receiverID).update(
          {
            "receivedRequests": FieldValue.arrayRemove([senderID])
          }
        );
        // add user to sender's friend list
        await FirebaseFirestore.instance.collection("users").doc(senderID).update(
          {
            "friends": FieldValue.arrayUnion([receiverID])
          }
        );
        // delete request from sender sentrequest list
        await FirebaseFirestore.instance.collection("users").doc(receiverID).update(
          {
            "sentRequests": FieldValue.arrayRemove([senderID])
          }
        );
        return true;
    } catch (e) {
        return false;
    }
 }

  Future <bool> rejectRequest(senderID, receiverID) async {
    try {
      // delete request from receiver's receivedRequest list
      await FirebaseFirestore.instance.collection("users").doc(receiverID).update(
        {
          "receivedRequests": FieldValue.arrayRemove([senderID])
        }
      );
      
      // delete request from sender sentrequest list
      await FirebaseFirestore.instance.collection("users").doc(receiverID).update(
        {
          "sentRequests": FieldValue.arrayRemove([senderID])
        }
      );
      return true;
    } catch (e) {
      return false;
    }
  }
