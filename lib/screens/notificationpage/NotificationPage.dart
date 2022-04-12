import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:greycode/screens/notificationpage/methods.dart';
import '../../utils/utilities.dart';

class NotificationPage extends StatefulWidget {
  final userCreds;
  const NotificationPage(this.userCreds, { Key? key }) : super(key: key);

  @override
  State<NotificationPage> createState() => _NotificationPageState();
}

class _NotificationPageState extends State<NotificationPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppBar(),
      body: Column(
        children: [
          Expanded(child: buildFriendRequestsList())
        ],
      )
    );
  }


  AppBar buildAppBar() {
    return AppBar(
      backgroundColor: Colors.white,
      elevation: 0,
      title: Text(
        'Notifications',
        style: TextStyle(
          fontSize: 24,
          color: Colors.black,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  FutureBuilder buildFriendRequestsList(){
   return FutureBuilder(
     future: getReceivedRequestList(widget.userCreds[0].uid),
     builder: (context, AsyncSnapshot snapshot) {
        if (snapshot.hasError)
          return Text("Something went wrong");
        switch (snapshot.connectionState){
          case ConnectionState.waiting: return showCircularProgress();
        default:
        return ListView.builder(
          itemCount: snapshot.data.length,
          padding: const EdgeInsets.only(bottom: 20),
          itemBuilder: ((context, index) {
            return buildFrTile(
              name: snapshot.data[index].fullName,
              imageUrl: snapshot.data[index].photoUrl,
              senderID: snapshot.data[index].uid,
              receiverID: widget.userCreds[0].uid,
            );
          })
        );
      }
     }
   );
 }


  ListTile buildFrTile(
   {
     required String name,
     required String imageUrl,
     required String senderID,
     required String receiverID
   }
 ){
   return ListTile(
    leading: buildImageAvatar(
        imageUrl: imageUrl
    ),
    title: Text(
      name,
      style: TextStyle(
        color: Colors.black87,
        fontSize: 17,
        fontWeight: FontWeight.w900),
    ),
    minLeadingWidth: 2,
    subtitle: Text(
      "Sent you a friend request",
      style: TextStyle(fontSize: 12,),
    ),
    trailing: Wrap(
      spacing: 20,
      children: [
        IconButton(
          icon: Icon(Icons.check, color: Colors.green,), 
          onPressed: () async {
            bool res = await acceptRequest(senderID, receiverID);
            if(res)
            showSnackBar("Added to friendList", context);
            else
            showSnackBar("Something went wrong at our end", context);
            setState(() {});
          },
        ),
        IconButton(
          icon: Icon(Icons.close, color: Colors.red,), 
          onPressed: () async {
            bool res = await rejectRequest(senderID, receiverID);
            if(res)
            showSnackBar("Removed the request", context);
            else
            showSnackBar("Something went wrong at our end", context);
            setState(() {});
          },
        ),
      ],
    ),
  );
 }

 Stack buildImageAvatar(
    {
      required String imageUrl
    }){
    return Stack(
      alignment: Alignment.center,
      children: [
        Container(
          height: 40,
          width: 40,
          decoration: BoxDecoration(
            color: Colors.black,
            borderRadius: BorderRadius.circular(30)
          ),
        ),
        Container(
          height: 36,
          width: 36,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(30),
            image: DecorationImage(
              image: NetworkImage(
                imageUrl
              )
          )),
        ),
      ],
    );
  }

}